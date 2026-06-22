# Repository Guidelines

## Project Structure & Module Organization

This repository is an investment research wiki, not an application.

- `wiki/raw/`: immutable PDFs, spreadsheets, screenshots, conversations, and adjacent `-summary.md` or `-extracted.md` transformations.
- `wiki/raw/<sponsor>/`: sponsor-specific evidence.
- `wiki/`: maintained synthesis.
- `wiki/entities/`, `offerings/`, `properties/`, `topics/`, and `diligence/`: research pages grouped by purpose.
- `wiki/index.md`: canonical catalog; `wiki/log.md`: append-only activity history.
- `.agents/skills/llm-wiki/`: required wiki workflow.
- `.codex/` and `.githooks/`: project automation, including source-change review.

Place future code, models, or datasets in `tests/`, `models/`, and `data/`.

## Research Workflow

Use macOS `zsh` for every command. Before wiki work, read `wiki/SCHEMA.md`, `wiki/index.md`, and the latest 20–30 entries in `wiki/log.md`; then search existing material and run `git status --short`.

Do not overwrite original sources unless explicitly directed. Mark sponsor claims, screenshots, secondary interpretations, and LLM-assisted content as unverified. Distinguish targets from realized results and gross project returns from net investor returns. Prefer primary evidence for legal, tax, regulatory, and financial claims.

## Commands & Validation

There is no application build or automated test suite. Validate research changes manually:

```zsh
rg "search term" wiki raw
find wiki -type f -name '*.md' | sort
git diff --check
git diff
jq empty .codex/hooks.json
/bin/zsh .codex/hooks/load-llm-wiki.zsh
/bin/zsh .githooks/pre-commit
```

Confirm claims against cited evidence, resolve internal links, and verify relative links into `wiki/raw/`. Update `wiki/index.md` after material page changes and append every material ingest, synthesis, review, or query to `wiki/log.md`.

The pre-commit hook runs `$llm-wiki` when staged files under `wiki/raw/` change. It leaves generated research unstaged and blocks once so contributors can review and stage the intended updates before retrying the commit.

## Style & Naming

Use lowercase, hyphen-separated filenames such as `self-storage-benchmarks.md`. Write ATX headings, short paragraphs, concise bullets, and tables where comparison helps. Use `[[Obsidian Wikilinks]]` internally and relative Markdown links for source files. Prefer updating an existing page over creating a duplicate.

## Commits & Pull Requests

Use concise Conventional Commits, for example `docs: ingest offering materials` or `chore: update session hook`. Stage only related files and preserve unrelated user changes. Pull requests should explain purpose, changed files, assumptions, validation performed, and relevant source links.

## Security

Never commit credentials, bank details, tax identifiers, private investor records, or confidential sponsor materials without explicit authorization. Keep `.DS_Store` and other OS metadata untracked.
