# Installation and verification

1. Install a recent stable Firefox desktop build.
2. Create a **new** profile via `about:profiles` and launch it once.
3. Close Firefox before copying `user.js`.
4. Run the no-Python installer (`scripts/install.ps1` on Windows, `scripts/install.sh` on Linux/macOS), use the optional `install.py`, or copy `config/user.js` manually. All scripts require an explicit profile Root Directory, back up existing `user.js`, and ask before modifying it. See README commands.
5. Firefox opens the local HTML add-on page. For each desired add-on, follow its AMO download link, verify source and permissions, and approve installation. If an old version is missing, search the Mozilla Add-ons directory for a currently maintained release.
6. Open `about:addons` and verify your choices.
7. Open `about:config` to verify relevant settings.
8. To use Brave, add Brave Search if needed and choose it in `about:preferences#search`. No machine-wide policy is installed.
9. Test browsing, security updates, DNS, video calling and extension behaviour. Strict DoH can disrupt network access.

If the launcher accidentally opens the wrong profile, close Firefox and use the correct **Root Directory** from `about:profiles`. The CLI `-profile <path>` targets that directory specifically.

## Roll back

Close Firefox, remove the copied `user.js` from the newly created profile, or restore the timestamped backup created by the installer. Restart Firefox. Preferences already written to `prefs.js` might remain; reset the affected prefs through `about:config` or delete the test profile if it contains no data.
