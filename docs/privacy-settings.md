# Preference provenance and review

`config/user.js` contains a **small, deliberate selection** of literal preference entries from the uploaded `prefs.js`. They are not inferred to all have been manually changed: Firefox may generate or modify some settings. IDs, account names, region-specific data, usage timestamps, installation paths and extensions registration metadata are excluded.

Notable settings:

- `dom.security.https_only_mode=true`: HTTPS-Only Mode.
- `network.trr.mode=3` with `network.trr.uri`: strict DNS-over-HTTPS; DNS can fail if resolver is unreachable.
- `toolkit.telemetry.*` and `browser.newtabpage.activity-stream.*`: selected telemetry-related settings; verify availability in your Firefox version.
- `privacy.clearSiteData.*` and `privacy.clearOnShutdown_v2.formdata`: selected data-clearing preferences; these do **not** mean all browsing data is automatically cleared.

This configuration intentionally does **not** disable malware/phishing protections or hard-code a search engine. Check every setting for current Firefox versions, privacy tradeoffs and web compatibility before offering it as a general recommendation.
