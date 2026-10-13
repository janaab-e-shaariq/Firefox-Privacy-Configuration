#!/usr/bin/env python3
"""Copy reviewed user.js into an explicitly selected Firefox profile and open add-on page.
No profile creation, background downloads or silent extension installs.
"""
import argparse
import pathlib
import shutil
import subprocess
import sys
import datetime

HERE = pathlib.Path(__file__).resolve().parent.parent

p = argparse.ArgumentParser(description="Apply Firefox privacy settings to a NEW profile")
p.add_argument("--profile-dir", type=pathlib.Path, required=True, help="Exact Firefox Root Directory from about:profiles")
p.add_argument("--firefox", default="firefox", help="Firefox executable path; on Windows provide firefox.exe path")
p.add_argument("--launch", action="store_true", help="Open the extension installer in that profile after copying")
a = p.parse_args()
target = a.profile_dir.expanduser().resolve()
if not target.is_dir(): p.error("Profile directory does not exist; create it with about:profiles first")
if not (target/'prefs.js').exists() and not (target/'times.json').exists():
    print("Warning: target doesn't look initialised. Check the Root Directory shown in about:profiles.")
    if input("Continue? [y/N] ").strip().lower() != 'y': sys.exit(2)
source = HERE/'config'/'user.js'
output = target/'user.js'
if output.exists():
    stamp = datetime.datetime.now().strftime('%Y%m%d-%H%M%S')
    backup = target/('user.js.backup-'+stamp)
    shutil.copy2(output, backup)
    print('Backed up existing user.js:', backup)
shutil.copy2(source, output)
print('Installed:', output)
print('Restart this Firefox profile to apply settings.')
if a.launch:
    url=(HERE/'extensions'/'install.html').resolve().as_uri()
    cmd=[a.firefox,'-new-instance','-profile',str(target),url]
    print('Opening Firefox extension installation guide:', url)
    try: subprocess.Popen(cmd)
    except OSError as exc:
        print('Could not launch Firefox:',exc)
        print('Manually open:',url)
        sys.exit(1)
else:
    print('Open extensions/install.html in the new profile or repeat with --launch.')
