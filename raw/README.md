# Raw Sources

This directory stores immutable source material and source manifests.

Use `raw/assets/` for local screenshots, PDFs, images, and attachments when they can be safely committed. Use `raw/sources/` for source manifests when the original source lives outside the repository or should not be copied into git.

The LLM should read raw sources but should not rewrite them. Synthesis belongs in `wiki/`.
