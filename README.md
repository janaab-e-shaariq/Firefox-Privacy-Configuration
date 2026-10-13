# Firefox Privacy Configuration

A **configuration-only** project for an existing **newly created Firefox desktop profile**. No browsing history, profile backups, cookies, passwords, personal identifiers, or extension data are included.

This is based on a **reviewed subset** of preferences extracted from a Firefox profile configured with inspiration from [Firefox Stop Watching Me](https://github.com/benskev/Firefox-Stop-Watching-Me). It is not an official Mozilla or upstream project, and does **not** reproduce all upstream settings.

## Quick start

1. Install Firefox desktop. Open `about:profiles`, **Create a New Profile**, launch it once, then close Firefox completely.
2. Click **Open Directory** beside that profile's **Root Directory** and copy its absolute directory path.
3. Download this repository and open a terminal in its root folder.
4. **No Python needed:** use the native installer for your operating system. Replace the example profile path with the exact **Root Directory** shown in `about:profiles`.

**Windows PowerShell:**
```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -ProfileDir "$env:APPDATA\Mozilla\Firefox\Profiles\XXXXXXXX.Privacy" -Launch
```
Only run scripts after reviewing them. The execution-policy flag applies to this invocation; it does not change your machine's persistent policy.

**Linux:**
```bash
bash scripts/install.sh --profile-dir "$HOME/.mozilla/firefox/XXXXXXXX.Privacy" --launch
```

**macOS:**
```bash
bash scripts/install.sh --profile-dir "$HOME/Library/Application Support/Firefox/Profiles/XXXXXXXX.Privacy" --launch
```

**Optional Python alternative:**
```bash
python3 scripts/install.py --profile-dir "/exact/path/from/about:profiles" --launch
```

**Manual method (no scripts required):** copy `config/user.js` to the selected, closed Firefox profile's Root Directory; then launch that profile and open `extensions/install.html` to install add-ons.

The script backs up any existing `user.js`, copies the reviewed config, and opens `extensions/install.html` in the target Firefox profile (with `--launch`). **Click each official Mozilla Add-ons link to request an install; Firefox asks for your approval.** This is deliberately not silent or system-wide.

Alternatively copy [`config/user.js`](config/user.js) by hand into the new profile Root Directory, then open [`extensions/install.html`](extensions/install.html) in Firefox.

## What gets configured

- HTTPS-Only Mode
- Selected Firefox telemetry and recommendation endpoints
- Strict DNS-over-HTTPS using the resolver specified in `user.js` (can break captive portals/local DNS)
- Selected form-data and site-data clearing preferences

**Search engine:** We do not include a persistent enterprise policy and do not force a Brave Search default. Users can set **Brave Search** under `about:preferences#search`. Firefox search defaults do not reliably migrate through `user.js` alone.

## Extensions

The [local installation guide](extensions/install.html) lists the **14 third-party extension packages** found in the source profile, links to their official Mozilla Add-ons XPI downloads, and requests a user click/approval for each. The links are historical/version-pinned and might need updating. System add-ons and built-in themes are excluded. You should consider disabling redundant extensions (e.g. overlapping tab unloaders) and reviewing permissions.

## Limitations and security

- Firefox may change/remove preferences between versions. Verify behaviour in `about:config`.
- `user.js` reapplies each startup; edit/remove lines if you want preferences to stay changed.
- Strict DoH can break corporate networks, internal domains and captive portals.
- Extensions are installed only after the user approves them. No extension binaries are committed.
- This is a curated subset, **not a full clone** of the uploaded Firefox profile.
- Scripts target only the directory supplied by the user; they do not change the Firefox installation or default profile.

See [setup and validation](docs/installation.md) and [preference review](docs/privacy-settings.md).

## Credit and licensing

Inspired by [benskev/Firefox-Stop-Watching-Me](https://github.com/benskev/Firefox-Stop-Watching-Me). Check upstream licensing and attribution before copying any upstream config text. This repository contains original setup/documentation plus a curated set of settings; choose a licence for your own original contributions before publishing.
