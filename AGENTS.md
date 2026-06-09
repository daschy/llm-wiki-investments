# Repository Guidelines

## Purpose

This repository is an investment research wiki, not an application. Preserve source evidence in `sources/` and maintain durable, cross-referenced synthesis in `wiki/`.

All shell commands and scripts must use `zsh` on macOS.

## Session Start

Use the repository skill at `.agents/skills/llm-wiki/SKILL.md` for wiki work.

Before answering research questions, ingesting sources, or editing wiki pages:

1. Read `wiki/SCHEMA.md` if it exists. Until then, treat this file as the repository schema.
2. Read `wiki/index.md`.
3. Read the latest 20-30 entries in `wiki/log.md`.
4. Search existing pages before creating new ones.
5. Run `git status --short` and preserve unrelated user changes.

The project-only Codex `SessionStart` hook in `.codex/` injects this workflow on startup, resume, clear, and compaction. Project hooks run only when the repository is trusted. Review new or changed Codex hooks with `/hooks`.

## Repository Structure

- `sources/`: source evidence and source-derived transformations.
- `sources/<sponsor>/`: sponsor-specific PDFs, spreadsheets, screenshots, conversations, and summaries.
- `sources/assets/`: shared attachments safe to store in the repository.
- `wiki/`: maintained knowledge base.
- `wiki/index.md`: content catalog and retrieval map.
- `wiki/log.md`: append-only chronology of ingests, reviews, queries, maintenance, and major edits.
- `wiki/entities/`: sponsors, operators, counterparties, and other notable organizations.
- `wiki/offerings/`: investment vehicles and offering terms.
- `wiki/properties/`: asset-level research.
- `wiki/topics/`: reusable concepts, benchmarks, and frameworks.
- `wiki/diligence/`: investment memos, risks, and open verification questions.
- `.agents/skills/llm-wiki/`: repository-local wiki workflow.
- `.codex/`: project-only Codex lifecycle hooks.
- `.githooks/`: tracked Git hooks.

If code, models, or datasets are introduced, place them in `tests/`, `models/`, and `data/`.

## Source Handling

Treat original PDFs, spreadsheets, screenshots, exports, and pasted source artifacts as immutable. Do not revise or overwrite them unless explicitly directed.

Keep OCR, extracted text, and source summaries beside the source they describe. Use suffixes such as `-summary.md` and `-extracted.md`. These derived files may be corrected when verification finds an error, but must remain clearly labeled as transformations or interpretations.

Do not silently turn sponsor claims, screenshots, LLM conversations, or secondary interpretations into verified facts. Mark provenance and uncertainty explicitly.

## Wiki Maintenance

- Prefer updating an existing page over creating a duplicate.
- Create a page only when the subject is central to a source or appears across multiple sources.
- Use lowercase, hyphen-separated filenames.
- Use ATX headings, short paragraphs, concise bullets, and Markdown tables where comparison helps.
- Use Obsidian wikilinks for internal pages, for example `[[10FSSAC5]]`.
- Use relative Markdown links for files under `sources/`.
- Add relevant cross-links when creating or materially updating a page.
- Preserve contradictory claims with dates and sources; do not silently overwrite them.
- Update `wiki/index.md` after material wiki changes.
- Append every material ingest, synthesis, review, query, or maintenance action to `wiki/log.md`.
- Keep `wiki/log.md` append-only except when explicitly repairing corruption or rotating it.

For substantial queries that would be costly to reproduce, file the synthesis in the appropriate wiki section. Do not create pages for trivial lookups.

## Research Standards

- Verify dates, names, entity structures, offering terms, calculations, and source references.
- Distinguish gross project returns from net investor returns.
- Distinguish targets, estimates, and marketing claims from realized results.
- Prefer primary sources for legal, tax, regulatory, financial, and current factual claims.
- For time-sensitive or high-stakes claims, verify current primary guidance before updating the wiki.
- State when a conclusion is unverified, sponsor-provided, screenshot-derived, or LLM-assisted.
- Do not present tax, legal, or investment analysis as professional advice.

## Commands

Run commands with `zsh`.

- `sed -n '1,220p' wiki/index.md`: inspect the catalog.
- `tail -n 60 wiki/log.md`: inspect recent activity.
- `rg "term" wiki sources`: search existing research and evidence.
- `find wiki -type f -name '*.md' | sort`: list wiki pages.
- `git status --short`: inspect the working tree.
- `git diff --check`: detect whitespace errors.
- `git diff`: review unstaged edits.
- `git diff --cached`: review staged edits.
- `git log --oneline -5`: inspect recent repository direction.
- `jq empty .codex/hooks.json`: validate Codex hook JSON.
- `/bin/zsh .codex/hooks/load-llm-wiki.zsh`: test the session-start handler.
- `git config core.hooksPath .githooks`: enable tracked Git hooks.

There is no application build or automated test suite.

## Hooks

### Codex Hooks

`.codex/hooks.json` defines a project-only `SessionStart` hook. It runs `.codex/hooks/load-llm-wiki.zsh` through `/bin/zsh` and injects `$llm-wiki` orientation instructions.

The hook script does not need executable permission because `/bin/zsh` invokes it directly. Validate changes with `jq` and a direct zsh execution.

### Git Hooks

`.githooks/post-commit` detects newly committed files under `sources/` and runs `codex exec` for source-ingest review. Generated summaries and wiki edits are intentionally left unstaged for a separate review and follow-up commit.

`.githooks/pre-commit` is intentionally minimal because source review happens after the source commit, avoiding commit loops.

## Validation

Before sharing or committing research changes:

1. Run `git diff --check`.
2. Review every changed claim against its cited source.
3. Confirm new internal links resolve and source links use valid relative paths.
4. Confirm `wiki/index.md` reflects new or materially changed pages.
5. Confirm `wiki/log.md` records the action.
6. For spreadsheets or models, verify formulas, assumptions, and edge cases manually.
7. For hook changes, validate configuration syntax and execute the handler directly.

## Git Workflow

Use concise Conventional Commit messages, such as:

- `docs: ingest offering materials`
- `docs: qualify tax guidance`
- `chore: add project session hook`

Stage only files belonging to the intended change. Never stage unrelated working-tree changes silently.

When adding raw files under `sources/`:

1. Commit the source files and any already-prepared adjacent summary.
2. Let the post-commit hook review the ingest.
3. Inspect any unstaged hook output.
4. Commit accepted wiki synthesis separately.

Do not amend or revert user work unless explicitly requested. Pull requests should state purpose, changed files, assumptions, verification performed, and source links.

## Security

Do not commit private investor records, tax identifiers, bank details, credentials, or confidential sponsor materials without explicit authorization and appropriate access controls.

`.DS_Store` and other OS metadata must remain untracked. Do not expose sensitive local paths, tokens, or account data in wiki pages or logs.
