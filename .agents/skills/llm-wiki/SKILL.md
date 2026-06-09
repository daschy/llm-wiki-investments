---
name: llm-wiki
description: "Karpathy's LLM Wiki: build/query interlinked markdown KB."
license: MIT
allowed-tools: functions.exec_command, functions.apply_patch, functions.view_image, multi_tool_use.parallel, web.run, tool_search
metadata:
  hermes:
    tags: [wiki, knowledge-base, research, notes, markdown, rag-alternative]
    category: research
    related_skills: [obsidian, arxiv]
---

# Karpathy's LLM Wiki

Build and maintain a persistent, compounding knowledge base as interlinked markdown files.
Based on [Andrej Karpathy's LLM Wiki pattern](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

Unlike traditional RAG (which rediscovers knowledge from scratch per query), the wiki
compiles knowledge once and keeps it current. Cross-references are already there.
Contradictions have already been flagged. Synthesis reflects everything ingested.

**Division of labor:** The human curates sources and directs analysis. The agent
summarizes, cross-references, files, and maintains consistency.

## When This Skill Activates

Use this skill when the user:
- Asks to create, build, or start a wiki or knowledge base
- Asks to ingest, add, or process a source into their wiki
- Asks a question and an existing wiki is present at the configured path
- Asks to lint, audit, or health-check their wiki
- References their wiki, knowledge base, or "notes" in a research context

## Required Tools

Use Codex tools directly; do not refer to unavailable Hermes tools such as
`read_file`, `search_files`, `execute_code`, or `web_extract`.

- **Local inspection and validation:** `functions.exec_command`, always with
  `shell: "zsh"` and the repository root as `workdir`. Prefer `rg`, `rg --files`,
  `sed`, `tail`, `find`, `shasum -a 256`, and Git read-only commands.
- **Parallel independent reads:** `multi_tool_use.parallel` wrapping
  `functions.exec_command`.
- **Manual file edits:** `functions.apply_patch`. Do not overwrite original source
  artifacts. Formatting or deterministic bulk transformations may use an existing
  repository script when appropriate.
- **Current external research and URL/PDF retrieval:** `web.run`. For legal, tax,
  regulatory, financial, or time-sensitive claims, browse current primary sources
  and include source links in the answer and stored synthesis.
- **Local screenshots and images:** `functions.view_image`. Use the image-generation
  tool only when the user asks to create or edit an image.
- **Structured office files:** invoke the available Documents or Spreadsheets skill
  when processing `.docx`, `.xlsx`, `.csv`, or similar artifacts.
- **Tool discovery:** use `tool_search` only when a required connector capability is
  not already callable.

If a named tool is unavailable, use the closest available Codex equivalent while
preserving the workflow: orient, search before creating, preserve provenance,
validate, update the index, and append the log.

## Wiki Location

For a repository-local wiki, use the Git repository root:

```zsh
ROOT="$(git rev-parse --show-toplevel)"
WIKI="$ROOT/wiki"
SOURCES="$ROOT/sources"
```

If there is no repository, use `WIKI_PATH` when set, otherwise default to `~/wiki`.
The wiki is plain Markdown; no database is required.

## Architecture: Three Layers

```
wiki/
├── SCHEMA.md           # Conventions, structure rules, domain config
├── index.md            # Sectioned content catalog with one-line summaries
├── log.md              # Chronological action log (append-only, rotated yearly)
├── sources/            # Layer 1: Immutable source material
│   ├── articles/       # Web articles, clippings
│   ├── papers/         # PDFs, arxiv papers
│   ├── transcripts/    # Meeting notes, interviews
│   |── assets/         # Images, diagrams referenced by sources
|   |── <sponsors>/     # Sponsor-specific sources
├── entities/           # Layer 2: Entity pages (people, orgs, products, models)
├── concepts/           # Layer 2: Concept/topic pages
├── comparisons/        # Layer 2: Side-by-side analyses
└── queries/            # Layer 2: Filed query results worth keeping
```

**Layer 1 — Sources:** Original artifacts are immutable after capture. Clearly
labeled extracted text and summaries beside them may be corrected after verification.
**Layer 2 — The Wiki:** Agent-owned markdown files. Created, updated, and
cross-referenced by the agent.
**Layer 3 — The Schema:** `SCHEMA.md` defines structure, conventions, and tag taxonomy.
The active repository schema overrides generic examples and templates in this skill.

## Resuming an Existing Wiki (CRITICAL — do this every session)

When the user has an existing wiki, **always orient yourself before doing anything**:

① **Read `SCHEMA.md`** — understand the domain, conventions, and tag taxonomy.
② **Read `index.md`** — learn what pages exist and their summaries.
③ **Scan recent `log.md`** — read the last 20-30 entries to understand recent activity.

```zsh
ROOT="$(git rev-parse --show-toplevel)"
if [[ -f "$ROOT/wiki/SCHEMA.md" ]]; then
  sed -n '1,240p' "$ROOT/wiki/SCHEMA.md"
else
  sed -n '1,260p' "$ROOT/AGENTS.md"
fi
sed -n '1,240p' "$ROOT/wiki/index.md"
tail -n 100 "$ROOT/wiki/log.md"
git -C "$ROOT" status --short
```

Only after orientation should you ingest, query, or lint. This prevents:
- Creating duplicate pages for entities that already exist
- Missing cross-references to existing content
- Contradicting the schema's conventions
- Repeating work already logged

Search existing pages and source summaries with `rg` before creating anything new.

## Initializing a New Wiki

When the user asks to create or start a wiki:

1. Determine the repository root or wiki path
2. Create the directory structure above
3. Ask the user what domain the wiki covers — be specific
4. Write `SCHEMA.md` customized to the domain (see template below)
5. Write initial `index.md` with sectioned header
6. Write initial `log.md` with creation entry
7. Confirm the wiki is ready and suggest first sources to ingest

### SCHEMA.md Template

Adapt to the user's domain. The schema constrains agent behavior and ensures consistency:

```markdown
# Wiki Schema

## Domain
[What this wiki covers — e.g., "AI/ML research", "personal health", "startup intelligence"]

## Conventions
- File names: lowercase, hyphens, no spaces (e.g., `transformer-architecture.md`)
- Every wiki page starts with YAML frontmatter (see below)
- Use `[[wikilinks]]` to link between pages (minimum 2 outbound links per page)
- When updating a page, always bump the `updated` date
- Every new page must be added to `index.md` under the correct section
- Every action must be appended to `log.md`
- **Provenance markers:** On pages that synthesize 3+ sources, append `^[sources/path/source-file.md]`
  at the end of paragraphs whose claims come from a specific source. This lets a reader trace each
  claim back without re-reading the whole raw file. Optional on single-source pages where the
  `sources:` frontmatter is enough.

## Frontmatter
  ```yaml
  ---
  title: Page Title
  created: YYYY-MM-DD
  updated: YYYY-MM-DD
  type: entity | concept | comparison | query | summary
  tags: [from taxonomy below]
  sources: [sources/path/source-name.md]
  # Optional quality signals:
  confidence: high | medium | low        # how well-supported the claims are
  contested: true                        # set when the page has unresolved contradictions
  contradictions: [other-page-slug]      # pages this one conflicts with
  ---
  ```

`confidence` and `contested` are optional but recommended for opinion-heavy or fast-moving
topics. Lint surfaces `contested: true` and `confidence: low` pages for review so weak claims
don't silently harden into accepted wiki fact.

### sources/ Frontmatter

Raw sources ALSO get a small frontmatter block so re-ingests can detect drift:

```yaml
---
source_url: https://example.com/article   # original URL, if applicable
ingested: YYYY-MM-DD
sha256: <hex digest of the raw content below the frontmatter>
---
```

The `sha256:` lets a future re-ingest of the same URL skip processing when content is unchanged,
and flag drift when it has changed. Compute over the body only (everything after the closing
`---`), not the frontmatter itself.

## Tag Taxonomy
[Define 10-20 top-level tags for the domain. Add new tags here BEFORE using them.]

Example for AI/ML:
- Models: model, architecture, benchmark, training
- People/Orgs: person, company, lab, open-source
- Techniques: optimization, fine-tuning, inference, alignment, data
- Meta: comparison, timeline, controversy, prediction

Rule: every tag on a page must appear in this taxonomy. If a new tag is needed,
add it here first, then use it. This prevents tag sprawl.

## Page Thresholds
- **Create a page** when an entity/concept appears in 2+ sources OR is central to one source
- **Add to existing page** when a source mentions something already covered
- **DON'T create a page** for passing mentions, minor details, or things outside the domain
- **Split a page** when it exceeds ~200 lines — break into sub-topics with cross-links
- **Archive a page** when its content is fully superseded — move to `_archive/`, remove from index

## Entity Pages
One page per notable entity. Include:
- Overview / what it is
- Key facts and dates
- Relationships to other entities ([[wikilinks]])
- Source references

## Concept Pages
One page per concept or topic. Include:
- Definition / explanation
- Current state of knowledge
- Open questions or debates
- Related concepts ([[wikilinks]])

## Comparison Pages
Side-by-side analyses. Include:
- What is being compared and why
- Dimensions of comparison (table format preferred)
- Verdict or synthesis
- Sources

## Update Policy
When new information conflicts with existing content:
1. Check the dates — newer sources generally supersede older ones
2. If genuinely contradictory, note both positions with dates and sources
3. Mark the contradiction in frontmatter: `contradictions: [page-name]`
4. Flag for user review in the lint report
```

### index.md Template

The index is sectioned by type. Each entry is one line: wikilink + summary.

```markdown
# Wiki Index

> Content catalog. Every wiki page listed under its type with a one-line summary.
> Read this first to find relevant pages for any query.
> Last updated: YYYY-MM-DD | Total pages: N

## Entities
<!-- Alphabetical within section -->

## Concepts

## Comparisons

## Queries
```

**Scaling rule:** When any section exceeds 50 entries, split it into sub-sections
by first letter or sub-domain. When the index exceeds 200 entries total, create
a `_meta/topic-map.md` that groups pages by theme for faster navigation.

### log.md Template

```markdown
# Wiki Log

> Chronological record of all wiki actions. Append-only.
> Format: `## [YYYY-MM-DD] action | subject`
> Actions: ingest, update, query, lint, create, archive, delete
> When this file exceeds 500 entries, rotate: rename to log-YYYY.md, start fresh.

## [YYYY-MM-DD] create | Wiki initialized
- Domain: [domain]
- Structure created with SCHEMA.md, index.md, log.md
```

## Core Operations

### 1. Ingest

When the user provides a source (URL, file, paste), integrate it into the wiki:

① **Capture the raw source:**
   - URL → use `web.run` to retrieve and inspect it, then preserve a source artifact
     or clearly labeled source summary under the repository `sources/` hierarchy
   - PDF → open it with `web.run` when remote; for a local PDF, use available
     document/PDF extraction tooling and visually inspect relevant pages when needed
   - Pasted text → save to appropriate `sources/` subdirectory
   - Name the file descriptively and preserve sponsor/topic grouping
   - For Markdown captures, add raw frontmatter (`source_url`, `ingested`, `sha256`)
     only when the active schema requires it.
     On re-ingest of the same URL: recompute the sha256, compare to the stored value —
     skip if identical, flag drift and update if different. This is cheap enough to
     do on every re-ingest and catches silent source changes.

② **Discuss takeaways** with the user — what's interesting, what matters for
   the domain. (Skip this in automated/cron contexts — proceed directly.)

③ **Check what already exists** — search `wiki/` and `sources/` with `rg` to find
   existing pages for mentioned entities/concepts. This is the difference between
   a growing wiki and a pile of duplicates.

④ **Write or update wiki pages:**
   - **New entities/concepts:** Create pages only if they meet the Page Thresholds
     in SCHEMA.md (2+ source mentions, or central to one source)
   - **Existing pages:** Add new information, update facts, bump `updated` date.
     When new info contradicts existing content, follow the Update Policy.
   - **Cross-reference:** Add relevant `[[wikilinks]]` and check whether existing
     pages should link back. Follow any minimum-link rule in the active schema.
   - **Tags:** Use tags only when the active schema defines a taxonomy.
   - **Provenance:** On pages synthesizing 3+ sources, append `^[sources/path/source.md]`
     markers to paragraphs whose claims trace to a specific source.
   - **Confidence:** For opinion-heavy, fast-moving, or single-source claims, set
     `confidence: medium` or `low` in frontmatter. Don't mark `high` unless the
     claim is well-supported across multiple sources.

⑤ **Update navigation:**
   - Add new pages to `index.md` under the correct section, alphabetically
   - Update the "Total pages" count and "Last updated" date in index header
   - Append to `log.md`: `## [YYYY-MM-DD] ingest | Source Title`
   - List every file created or updated in the log entry

⑥ **Report what changed** — list every file created or updated to the user.

A single source can trigger updates across 5-15 wiki pages. This is normal
and desired — it's the compounding effect.

### 2. Query

When the user asks a question about the wiki's domain:

① **Read `index.md`** to identify relevant pages.
② **Search with `rg`** across `wiki/` and source summaries for key terms.
③ **Read relevant pages** with `sed`, `cat`, or another read-only shell command.
④ **Synthesize an answer** from the compiled knowledge. Cite the wiki pages
   you drew from: "Based on [[page-a]] and [[page-b]]..."
⑤ **File valuable answers back** — if the answer is a substantial comparison,
   deep dive, or novel synthesis, use the appropriate schema-defined section such
   as `diligence/` or `topics/`.
   Don't file trivial lookups — only answers that would be painful to re-derive.
⑥ **Update log.md** with the query and whether it was filed.

### 3. Lint

When the user asks to lint, health-check, or audit the wiki:

① **Orphan pages:** Find pages with no inbound `[[wikilinks]]` from other pages.
Use `functions.exec_command` with `/bin/zsh`. For simple checks, combine `rg`,
`find`, `sed`, `awk`, `sort`, and `comm`. If a deterministic parser is needed,
add or reuse a small repository script rather than embedding an ad hoc program in
the skill.

② **Broken wikilinks:** Find `[[links]]` that point to pages that don't exist.

③ **Index completeness:** Every wiki page should appear in `index.md`. Compare
   the filesystem against index entries.

④ **Frontmatter validation:** When the active schema requires frontmatter, verify
   all required fields and taxonomy constraints. Do not impose frontmatter on a
   repository whose schema explicitly defers migration.

⑤ **Stale content:** Pages whose `updated` date is >90 days older than the most
   recent source that mentions the same entities.

⑥ **Contradictions:** Pages on the same topic with conflicting claims. Look for
   pages that share tags/entities but state different facts. Surface all pages
   with `contested: true` or `contradictions:` frontmatter for user review.

⑦ **Quality signals:** List pages with `confidence: low` and any page that cites
   only a single source but has no confidence field set — these are candidates
   for either finding corroboration or demoting to `confidence: medium`.

⑧ **Source drift:** For each file in `sources/` with a `sha256:` frontmatter, recompute
   the hash and flag mismatches. Mismatches indicate the raw file was edited
   (shouldn't happen — sources/ is immutable) or ingested from a URL that has since
   changed. Not a hard error, but worth reporting.

⑨ **Page size:** Flag pages over 200 lines — candidates for splitting.

⑩ **Tag audit:** List all tags in use, flag any not in the SCHEMA.md taxonomy.

⑪ **Log rotation:** If log.md exceeds 500 entries, rotate it.

⑫ **Report findings** with specific file paths and suggested actions, grouped by
   severity (broken links > orphans > source drift > contested pages > stale content > style issues).

⑬ **Append to log.md:** `## [YYYY-MM-DD] lint | N issues found`

## Working with the Wiki

### Searching

```zsh
# Find pages by content
rg -n -i "search term" wiki sources -g '*.md'

# Find pages by filename
rg --files wiki sources -g '*.md' | sort

# Find wikilinks
rg -n '\[\[[^]]+\]\]' wiki -g '*.md'

# Recent activity
tail -n 100 wiki/log.md

# Validate edits
git diff --check
git diff -- .agents/skills/llm-wiki wiki
```

### Bulk Ingest

When ingesting multiple sources at once, batch the updates:
1. Read all sources first
2. Identify all entities and concepts across all sources
3. Check existing pages for all of them (one search pass, not N)
4. Create/update pages in one pass (avoids redundant updates)
5. Update index.md once at the end
6. Write a single log entry covering the batch

### Archiving

When content is fully superseded or the domain scope changes:
1. Create `_archive/` directory if it doesn't exist
2. Move the page to `_archive/` with its original path (e.g., `_archive/entities/old-page.md`)
3. Remove from `index.md`
4. Update any pages that linked to it — replace wikilink with plain text + "(archived)"
5. Log the archive action

### Obsidian Integration

The wiki directory works as an Obsidian vault out of the box:
- `[[wikilinks]]` render as clickable links
- Graph View visualizes the knowledge network
- YAML frontmatter powers Dataview queries
- The `sources/assets/` folder holds images referenced via `![[image.png]]`

For best results:
- Set Obsidian's attachment folder to `sources/assets/`
- Enable "Wikilinks" in Obsidian settings (usually on by default)
- Install Dataview plugin for queries like `TABLE tags FROM "entities" WHERE contains(tags, "company")`

If using the Obsidian skill alongside this one, set `OBSIDIAN_VAULT_PATH` to the
same directory as the wiki path.

## Pitfalls

- **Never overwrite original source artifacts** — correct only clearly labeled
  source-derived transformations or the corresponding wiki synthesis.
- **Always orient first** — read SCHEMA + index + recent log before any operation in a new session.
  Skipping this causes duplicates and missed cross-references.
- **Always update index.md and log.md** — skipping this makes the wiki degrade. These are the
  navigational backbone.
- **Don't create pages for passing mentions** — follow the Page Thresholds in SCHEMA.md. A name
  appearing once in a footnote doesn't warrant an entity page.
- **Don't create pages without relevant cross-references** — isolated pages are hard to retrieve.
- **Follow the active schema for frontmatter and tags** — do not migrate conventions piecemeal.
- **Keep pages scannable** — a wiki page should be readable in 30 seconds. Split pages over
  200 lines. Move detailed analysis to dedicated deep-dive pages.
- **Ask before mass-updating** — if an ingest would touch 10+ existing pages, confirm
  the scope with the user first.
- **Rotate the log** — when log.md exceeds 500 entries, rename it `log-YYYY.md` and start fresh.
  The agent should check log size during lint.
- **Handle contradictions explicitly** — don't silently overwrite. Note both claims with dates,
  mark in frontmatter, flag for user review.

## Related Tools

[llm-wiki-compiler](https://github.com/atomicmemory/llm-wiki-compiler) is a Node.js CLI that
compiles sources into a concept wiki with the same Karpathy inspiration. It's Obsidian-compatible,
so users who want a scheduled/CLI-driven compile pipeline can point it at the same vault this
skill maintains. Trade-offs: it owns page generation (replaces the agent's judgment on page
creation) and is tuned for small corpora. Use this skill when you want agent-in-the-loop curation;
use llmwiki when you want batch compile of a source directory.
