# Wiki Log

## [2026-06-03] ingest | 10 Federal Storage slide screenshots

Created the initial LLM wiki structure and ingested screenshot-derived notes on [[10 Federal Storage]], [[10FSSAC5]], acquired properties, pipeline, market thesis, automation strategy, and diligence questions.

## [2026-06-03] maintenance | Adopt llm-wiki structure

Updated repository instructions to use raw sources, wiki pages, `wiki/index.md`, and append-only `wiki/log.md` for storage and retrieval.

## [2026-06-03] ingest | Real estate syndicate diligence Claude conversation

Added [[Real Estate Syndicate Diligence Claude Conversation]] and [[Real Estate Syndicate Diligence Criteria]] from `sources/real-estate-syndicate-diligence-claude-conversation.md`.

## [2026-06-03] maintenance | Rename raw source directory

Updated repository guidance and wiki source references after moving source manifests and assets from `raw/` to `sources/`.

## [2026-06-04] ingest | 10 Federal PDFs and track-record workbook

Ingested sponsor-provided 10FSSAC5 pitchbook, PPM, LLC agreement PDFs, and 10 Federal track-record workbook from `sources/10fed/`. Added source summaries, expanded [[10FSSAC5]] terms, fees, waterfall, and diligence hooks, added [[A Place for Stuff]], and updated sponsor and automation notes.

## [2026-06-04] maintenance | Move source summaries out of wiki

Moved source-summary pages from `wiki/sources/` into the relevant `sources/` directories beside their underlying source assets, removed the empty `wiki/sources/` directory, and updated repository guidance plus `wiki/index.md` source links.

## [2026-06-04] ingest | Self-storage industry benchmarks

Added `sources/self-storage-industry-benchmarks-2026-06-04-summary.md` with public REIT sector, Public Storage, Extra Space Storage, CubeSmart, and Marcus & Millichap / GlobeSt benchmark metrics for comparing 10 Federal Storage performance claims against the broader self-storage industry.

## [2026-06-04] ingest | Self-storage annual benchmarks since 2020

Added `sources/self-storage-industry-benchmarks-since-2020-summary.md` with a year-by-year Public Storage same-store revenue, NOI, and occupancy benchmark from 2020 through 2025, plus partial Nareit Q1 2026 sector context.

## [2026-06-04] synthesis | Add annual benchmark trend

Updated [[Self-Storage Industry Benchmarks]] with the year-by-year Public Storage same-store trend since 2020 and linked the new annual benchmark source summary.

## [2026-06-04] synthesis | Benchmark 10 Federal against industry

Added [[Self-Storage Industry Benchmarks]] and updated [[10 Federal Storage]], [[Self-Storage Fragmentation Thesis]], and [[Self-Storage Automation Strategy]] with public REIT and industry comparison context.

## [2026-06-04] diligence | 10 Federal Storage

Added [[10 Federal Storage Diligence Memo - 2026-06-04]] with an investment view, rubric score, sponsor/track-record issues, 10FSSAC5 raise reconciliation concerns, fee/conflict risks, automation operating-risk signals, public-source checks, and sponsor follow-up questions.

## [2026-06-07] maintenance | Repair source-summary links

Replaced obsolete wiki links to source-summary pages moved under `sources/` with direct relative Markdown links across the current entity, offering, property, and topic pages.

## [2026-06-07] ingest | Private market platform requirements chat

Added `sources/private-market-platform-requirements-chat-2026-06-07.md`, an LLM-assisted research conversation source artifact covering accredited-investor requirements and onboarding considerations for Nasdaq Private Market, Forge, EquityZen, and Hiive.

## [2026-06-07] synthesis | Private market platform entity onboarding

Added a beside-source summary and [[Private Market Platform Entity Onboarding]]. Captured the LLC/Dutch BV ownership structure, common platform and deal-level onboarding gates, expected documentation, and the unresolved need to confirm whether the direct BV owners must independently qualify as accredited investors or may be looked through to their ultimate owners.

## [2026-06-07] review | Private market platform onboarding synthesis

Reviewed the committed source summary against the underlying conversation and current primary guidance. Updated the summary and [[Private Market Platform Entity Onboarding]] to reflect the SEC's January 23, 2026 Rule 501(a)(8) interpretation permitting look-through to natural-person owners, while preserving platform and transaction acceptance as open diligence items. Corrected W-9/W-8 wording to describe tax forms as furnished by the relevant payee, account holder, beneficial owner, or intermediary rather than issued by the platform.

## [2026-06-08] ingest | 10FSSAC5 tax structure conversation

Added `sources/10fed/10fssac5-tax-structure-conversation-2026-06-08.md` and a beside-source summary covering K-1 reporting, the subsidiary REIT structure, depreciation limitations, quarterly distribution intent, preferred return accrual, the 15% target IRR waterfall, and considerations for an investor LLC taxed as a C corporation.

## [2026-06-09] review | 10FSSAC5 tax structure synthesis

Reviewed the committed LLM-assisted tax conversation against existing 10FSSAC5 pitchbook, PPM, and LLC-agreement summaries. Strengthened the source-summary provenance warning, added qualified tax and reporting synthesis to [[10FSSAC5]], and expanded [[10 Federal Storage Diligence Questions]] for K-1 timing, state filings, assets outside the REIT, taxable income without cash, depreciation policy, illustrative reporting, and investor-specific C-corporation advice.

## [2026-06-09] maintenance | Add investment research wiki schema

Added `wiki/SCHEMA.md` with repository-specific source hierarchy, page types, provenance rules, page thresholds, maintenance requirements, index and log policies, and quality standards. Updated `wiki/index.md` with its maintenance date, current page count, and a retrieval route for 10FSSAC5 tax-structure research.

## [2026-06-09] maintenance | Add Codex tooling to llm-wiki skill

Updated `.agents/skills/llm-wiki/SKILL.md` with a machine-readable Codex tool allowlist, macOS `zsh` command conventions, repository-root path handling, current-web-research guidance, and repository-specific source/wiki structure. Replaced unavailable Hermes pseudo-tools and removed conflicting frontmatter and Linux service assumptions.

## [2026-06-09] maintenance | Wiki integrity review

Reviewed the source inventory, maintained page inventory, index coverage, internal wikilinks, source-summary links, page sizes, log size, and working tree. No new source required ingestion; all 12 maintained content pages remain indexed, no maintained page exceeds the 200-line split threshold, and no current content or source link required repair. Preserved the historical `[[Real Estate Syndicate Diligence Claude Conversation]]` log reference under the append-only log policy after confirming the source summary now appears in `wiki/index.md` as a relative Markdown link.

## [2026-06-09] query | Quick overview of 10 Federal Storage

Summarized [[10 Federal Storage]], [[10FSSAC5]], and the current diligence view. Treated the sponsor's strategy and historical returns as unverified claims and highlighted track-record, debt, fee, property-underwriting, automation, and tax-structure gaps. Not filed as a separate page because the answer is a straightforward retrieval from existing synthesis.

## [2026-06-09] maintenance | Add source-change pre-commit hook

Added `.githooks/pre-commit` to detect staged changes under `sources/` and run `codex exec` with the `$llm-wiki` workflow. The hook leaves generated research unstaged, blocks the first commit for review, and fingerprints the staged source diff under `.git/` so an unchanged retry does not rerun the update. Updated `AGENTS.md` with the hook behavior and validation command.

## [2026-06-09] review | Staged sources README deletion

Reviewed the staged deletion of `sources/README.md`. The file contained repository source-handling guidance rather than investment evidence, no maintained links reference it, and the core source provenance and immutability rules remain in `AGENTS.md` and `wiki/SCHEMA.md`. No adjacent source summary, durable wiki synthesis, or index update was warranted.

## [2026-06-09] review | BAM Capital and GSP REI staged web sources

Reviewed the staged BAM Capital current-offerings page and GSP REI Income Fund page as sponsor public-marketing evidence. Added adjacent source summaries, [[BAM Capital]], [[BAM Multifamily Growth & Income Fund V]], [[GSP REI]], and [[GSP REI Income Fund]]. Preserved the BAM capture's truncation and naming discrepancy; treated all target returns, fixed-return language, principal-preservation claims, payment history, tax benefits, and UBIT statements as unverified pending legal documents, financial records, and professional review. Updated `wiki/index.md`; did not modify or stage the original source files.

## [2026-06-09] review | BAM Capital and GSP REI synthesis precision

Reviewed the staged source summaries and durable pages against both captured webpages. Clarified that capture metadata does not establish offering freshness, treated GSP's fixed return as a sponsor-stated rate promise whose enforceability and priority require legal documents, and added open verification of the compounding method. No new page or index entry was warranted, and the immutable webpage captures were not modified.

## [2026-06-09] review | PPR Capital current offerings

Reviewed the staged `sources/pprcapitalmgmt.com/current-offerings.md` capture plus the adjacent untracked `sources/pprcapitalmgmt.com/ppr-capital-foundation-fund.md` and `sources/pprcapitalmgmt.com/invest-in-the-opportunity-fund.md` captures. Added the adjacent source summaries `sources/pprcapitalmgmt.com/current-offerings-summary.md`, `sources/pprcapitalmgmt.com/ppr-capital-foundation-fund-summary.md`, and `sources/pprcapitalmgmt.com/invest-in-the-opportunity-fund-summary.md`; the durable pages `wiki/entities/ppr-capital-management.md`, `wiki/offerings/ppr-capital-foundation-fund.md`, and `wiki/offerings/ppr-capital-opportunity-fund-ii.md`; and updated `wiki/index.md` to index the new pages and source summaries. Preserved the sponsor's naming and investor-eligibility ambiguities as unverified.

## [2026-06-09] maintenance | Normalize PPR Foundation capture whitespace

Cleaned trailing whitespace from `sources/pprcapitalmgmt.com/ppr-capital-foundation-fund.md` in the working tree. The staged copy was left unchanged per instruction, so `git diff --cached --check` still reflects the earlier capture state.

## [2026-06-22] ingest | Crystal View Capital public website

Captured the Crystal View Capital public website into `sources/crystalviewcapital.com/`: preserved the existing `homepage.md`, added Markdown captures for 134 sitemap pages, added Markdown captures for 8 additional public routes discovered through the Framer search index, and saved the raw `framer-search-index-2026-06-22.json`. Added `sources/crystalviewcapital.com/site-capture-index-2026-06-22.md` and `sources/crystalviewcapital.com/website-public-pages-2026-06-22-summary.md`; created [[Crystal View Capital]] and [[Crystal View Capital Fund IV]]; updated `wiki/index.md`. Treated all target returns, preferred returns, AUM, distributions, IRR/MOIC, testimonials, tax commentary, acquisition updates, and strategy claims as sponsor-provided and unverified pending governing documents, financial records, and professional review.

## [2026-06-22] maintenance | Prune Crystal View Capital source captures

Removed low-signal website-plumbing captures from `sources/crystalviewcapital.com/`, including lead-capture, contact, event, policy, investor-summit, RSVP/referral, webinar registration/confirmation, and raw Framer search-index files. Retained 124 Markdown source files, including the existing homepage capture, sponsor/offering pages, strategy, track record, FAQ, disclaimer, family-office, news, webinar, and article/update pages. Updated `site-capture-index-2026-06-22.md` and `website-public-pages-2026-06-22-summary.md` to reflect the pruned source set.

## [2026-06-22] synthesis | Crystal View Capital diligence questions

Reviewed the retained Crystal View Capital public website captures listed by the user. Added [[Crystal View Capital Diligence Questions]] to convert Fund IV public-marketing, track-record, article-archive, tax, debt, fee, and operating claims into a sponsor document-request checklist. Updated [[Crystal View Capital]], [[Crystal View Capital Fund IV]], `sources/crystalviewcapital.com/website-public-pages-2026-06-22-summary.md`, and `wiki/index.md` to preserve the website disclaimer, internal KPI inconsistency, and unresolved verification gaps. No source files were modified other than the adjacent source summary.

## [2026-06-22] maintenance | Rename sources directory to raw

Renamed the repository evidence directory from `sources/` to `raw/`. Updated maintained wiki links, repository guidance, schema language, adjacent source summaries, and the source-change pre-commit hook to use `raw/` as the canonical immutable evidence location. Historical log entries above retain their original context.

## [2026-06-22] maintenance | Move raw under wiki

Moved the repository evidence directory from `raw/` to `wiki/raw/`. Updated repository guidance, catalog links, maintained page source references, and the pre-commit hook to use `wiki/raw/` as the canonical evidence location from the repository root.

## [2026-06-22] update | 10 Federal source refresh
- Updated [[10 Federal Storage]] to note that the 2025 track-record workbook spans multiple asset types and reports project-level IRRs on a best-efforts basis, not net investor-level returns.
- Updated [[10FSSAC5]] to note that both the main LLC agreement and the retail-investor LLC agreement variant are present and the governing version should be confirmed against signed documents.

## [2026-06-22] maintenance | Repair orphaned maintained pages

Ran a wiki integrity pass covering maintained-page index coverage, internal wikilinks, and diff hygiene. Confirmed 22 maintained content pages remain indexed with no broken wikilinks, then added backlinks to [[Private Market Platform Entity Onboarding]] from [[Real Estate Syndicate Diligence Criteria]] and to [[10 Federal Storage Diligence Memo - 2026-06-04]] from [[10 Federal Storage Diligence Questions]] and [[10FSSAC5]] so both orphaned maintained pages are reachable from the main research graph.
