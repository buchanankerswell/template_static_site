# Template setup (delete this file when done)

1. Rename `CONDA_ENV_ID`, titles, and `package:`-style inputs to the real site name. Fill `README.md` (5 sections), `docs/` content, and `.zenodo.json` (enables DOI minting on first release).
2. If the site needs generated media, add a `pipeline/` build (fetch/transcribe/encode) with `fetch`, `cues`, and `site` targets, and point the `build` target at it.
3. Vendor `tokens.css`/`dialogs.css`/`dialogs.js` from the pinned `actions` tag (see `docs/` notes) instead of these copies if the tag has moved on.
4. Create the GitHub repo from this template, enable Pages from `docs/`, push, and tag `v0.1.0` to exercise validation + release.
