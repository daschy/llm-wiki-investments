# Repository Guidelines

## Project Structure & Module Organization

This repository is an investment research wiki, not an application codebase. Keep durable synthesis in `wiki/` and source material in `sources/`.

- `sources/`: immutable source material, source manifests, and source-derived Markdown/text transformations. Add new sources here, but do not revise source content unless explicitly directed.
- `sources/<sponsor>/`: sponsor-specific PDFs, screenshots, spreadsheets, and manifests.
- `sources/assets/`: shared attachments safe to store in the repository.
- Keep source summaries, OCR, text extractions, and other transformed `.txt` or `.md` files close to the source assets they describe, in the same directory. Use a suffix such as `-summary.md` or `-extracted.md` to avoid overwriting source manifests.
- `wiki/`: LLM-maintained knowledge base.
- `wiki/index.md`: catalog of wiki pages; read this first and update it after material wiki edits.
- `wiki/log.md`: append-only chronology of ingests, maintenance, queries, and major edits.
- `wiki/entities/`, `wiki/offerings/`, `wiki/properties/`, `wiki/topics/`, `wiki/diligence/`: organized research pages.

If code, models, or datasets are added, use `tests/`, `models/`, and `data/`.

## Build, Test, and Development Commands

There is no build system yet. Run commands with `zsh`.

- `ls -la`: inspect repository contents.
- `sed -n '1,220p' wiki/index.md`: review the wiki catalog before answering research questions.
- `rg "term" wiki sources`: search notes, source manifests, and text files.
- `git status`: check working-tree changes before editing or committing.
- `git diff`: review document edits before sharing.
- `git log --oneline -5`: check recent commit wording and repository direction.
- `git config core.hooksPath .githooks`: enable the tracked repository hooks if they are not already active.

Document future project commands here, such as `npm test`, `make build`, or `python -m pytest`.

## Repository Hooks

Tracked Git hooks live in `.githooks/` and must be run with `zsh`. The `post-commit` hook detects newly committed files under `sources/`, runs `codex exec` to review the ingest, and leaves any Codex-generated summaries or wiki updates unstaged for a deliberate follow-up commit.

If the hook is not firing, run `git config core.hooksPath .githooks` once in this repository.

## Coding Style & Naming Conventions

Use Markdown with ATX headings (`#`, `##`), short paragraphs, and concise bullets. Keep filenames lowercase and hyphen-separated, for example `wiki/topics/self-storage-fragmentation-thesis.md` or `wiki/entities/10-federal-storage.md`.

Use Obsidian-style links for internal navigation, such as `[[10 Federal Storage]]`. Mark sponsor-provided, screenshot-derived, or otherwise unverified claims clearly. Prefer synthesis in `wiki/`.

## Testing Guidelines

No automated tests exist yet. For research pages, manually verify dates, entity names, claims, and source references. For spreadsheets or models, check formulas, assumptions, and edge cases.

If scripts are introduced, place tests in `tests/` and name them after behavior, for example `test_scorecard_weights.py`.

## Commit & Pull Request Guidelines

Use concise conventional-style commit messages. Existing examples include `docs: initialize investment research wiki` and `docs: rename source directory`.

When adding new files under `sources/`, expect the commit to complete first and then run the source-ingest hook. Review the resulting working tree, stage any intended source summaries and wiki updates, then make a follow-up commit if the hook produced changes.

Pull requests should include purpose, changed files, assumptions, and source links. Include screenshots or exported previews for spreadsheet or visual changes.

## Security & Configuration Tips

Do not commit private investor records, tax identifiers, bank details, or confidential sponsor materials. Keep sensitive files outside the repository unless explicit access controls are in place. `.DS_Store` is ignored; do not add OS metadata files.
