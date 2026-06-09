# Investment Research Wiki Schema

## Domain

Private-market investment research, currently focused on U.S. real estate syndications, self-storage offerings, sponsor diligence, property underwriting, tax structure, and private-company secondary platform onboarding.

## Layers

- `sources/`: original evidence and adjacent source-derived transformations.
- `wiki/`: durable synthesis maintained from the available evidence.
- `AGENTS.md`: repository workflow, validation, security, and Git conventions.

Original PDFs, spreadsheets, screenshots, exports, and conversation artifacts are immutable unless the user explicitly directs otherwise. Adjacent `-summary.md` and `-extracted.md` files are derived research artifacts and may be corrected with clear provenance.

## Page Types

- `entities/`: sponsors, operators, counterparties, and notable organizations.
- `offerings/`: investment vehicles, structures, terms, fees, and waterfalls.
- `properties/`: individual assets and portfolios.
- `topics/`: reusable concepts, market benchmarks, and diligence frameworks.
- `diligence/`: investment memos, risk assessments, and open questions.

## Conventions

- Use lowercase, hyphen-separated filenames.
- Use ATX headings, short paragraphs, concise bullets, and tables where comparison helps.
- Use `[[wikilinks]]` for internal wiki pages.
- Use relative Markdown links for files under `sources/`.
- Mark sponsor-provided, screenshot-derived, LLM-assisted, and otherwise unverified claims explicitly.
- Distinguish targets and estimates from realized results.
- Distinguish gross project returns from net investor returns.
- Preserve material contradictions with dates and source references.
- Do not present tax, legal, or investment analysis as professional advice.

Existing pages predate a frontmatter convention. Do not add YAML frontmatter piecemeal. Adopt it only through a deliberate migration covering all maintained wiki pages.

## Page Thresholds

- Create a page when a subject is central to a source or appears across multiple sources.
- Update an existing page when the subject is already covered.
- Do not create pages for passing mentions or trivial lookups.
- Consider splitting pages over 200 lines when separate topics can stand alone.
- File substantial query results only when they would be costly to reproduce.

## Source Priority

Use evidence in this order when claims conflict:

1. Executed agreements, regulatory filings, official guidance, and audited or independently verified records.
2. Current sponsor legal documents and direct primary-source disclosures.
3. Sponsor presentations, workbooks, screenshots, and public marketing.
4. Reputable secondary research.
5. LLM-assisted conversations and interpretations.

Newer sources do not automatically supersede stronger legal or primary evidence. Record unresolved conflicts rather than choosing silently.

## Required Maintenance

Before wiki work:

1. Read this file.
2. Read `wiki/index.md`.
3. Read the latest 20-30 entries in `wiki/log.md`.
4. Search existing wiki and source summaries.

After material wiki work:

1. Update `wiki/index.md` when navigation or page coverage changes.
2. Append the action to `wiki/log.md`.
3. Verify dates, names, claims, links, and source references.
4. Run `git diff --check`.

## Index Policy

`wiki/index.md` is the canonical catalog. List every maintained content page once under its primary type, alphabetically within each section. Source summaries belong in the Sources section as relative Markdown links.

Update the index date and page count after adding, removing, or moving maintained content pages. The count excludes `SCHEMA.md`, `index.md`, and `log.md`.

## Log Policy

`wiki/log.md` is append-only. Use:

`## [YYYY-MM-DD] action | subject`

Common actions: `ingest`, `synthesis`, `review`, `query`, `maintenance`, `diligence`, `archive`.

Rotate the log after 500 entries rather than rewriting historical entries.

## Quality Signals

- Treat single-source and investor-specific conclusions as provisional.
- Request corroboration for material return, tax, legal, debt, and operating claims.
- Keep open verification items in the relevant diligence page.
- Prefer primary sources for current legal, tax, regulatory, and financial claims.
- State when current external verification was not performed.
