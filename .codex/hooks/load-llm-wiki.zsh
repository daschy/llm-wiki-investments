#!/bin/zsh

set -eu

# SessionStart context is injected as developer guidance by Codex.
print -r -- 'Invoke $llm-wiki for this repository. Read its SKILL.md before doing any work, then orient by reading wiki/SCHEMA.md when present, wiki/index.md, and the recent entries in wiki/log.md. Treat AGENTS.md as the repository-specific schema when wiki/SCHEMA.md is absent.'
