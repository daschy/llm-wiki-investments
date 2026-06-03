# Repository Guidelines

## Project Structure & Module Organization

This repository is an investment research wiki, not an application codebase. Keep durable synthesis in `wiki/` and source material in `sources/`.

- `sources/`: immutable source material and source manifests. Add new sources here, but do not revise source content unless explicitly directed.
- `sources/assets/`: local PDFs, screenshots, images, and other attachments safe to store in the repository.
- `wiki/`: LLM-maintained knowledge base.
- `wiki/index.md`: catalog of wiki pages. Read this first before research work and update it after material wiki edits.
- `wiki/log.md`: append-only chronology of ingests, queries, lint passes, and major edits.
- `wiki/entities/`, `wiki/offerings/`, `wiki/properties/`, `wiki/topics/`, `wiki/sources/`, `wiki/diligence/`: organized research pages.
- `notes/`: legacy or ad hoc notes not yet integrated.

If code, models, or datasets are added, use `tests/`, `models/`, and `data/`.

## Build, Test, and Development Commands

There is no build system yet. Run commands with `zsh`.

- `ls -la`: inspect repository contents.
- `sed -n '1,220p' wiki/index.md`: review the wiki catalog before answering research questions.
- `rg "term" wiki sources`: search synthesized notes and source manifests.
- `git status`: check working-tree changes before editing or committing.
- `git diff`: review document edits before sharing.

Document future project commands here, such as `npm test`, `make build`, or `python -m pytest`.

## Coding Style & Naming Conventions

Use Markdown with ATX headings (`#`, `##`), short paragraphs, and concise bullets. Keep filenames lowercase and hyphen-separated, for example `wiki/topics/self-storage-fragmentation-thesis.md` or `wiki/entities/10-federal-storage.md`.

Use Obsidian-style links for internal navigation, such as `[[10 Federal Storage]]`. Mark sponsor-provided or otherwise unverified claims clearly.

## Testing Guidelines

No automated tests exist yet. For research pages, manually verify dates, entity names, claims, and source references. For spreadsheets or models, check formulas, assumptions, and edge cases.

If scripts are introduced, place tests in `tests/` and name them after behavior, for example `test_scorecard_weights.py`.

## Commit & Pull Request Guidelines

This repository currently has no commit history. Use concise conventional-style commit messages, such as `docs: add sponsor diligence summary` or `models: add sponsor pipeline tracker`.

Pull requests should include purpose, changed files, key assumptions, and relevant source links. Include screenshots or exported previews for spreadsheet, visual, or attachment-heavy changes.

## Security & Configuration Tips

Do not commit private investor records, tax identifiers, subscription documents, bank details, or confidential sponsor materials. Keep sensitive files outside the repository unless explicit access controls are in place.
