# Evidence and Screenshots

Save your **own screenshots** in `evidence/screenshots/`. Do not use sample images or screenshots from another person's lab as proof of your work. Keep terminal text readable and avoid showing passwords or other secrets.

Suggested filenames and evidence:

1. `01-user-created.png` — `id forensic01`, `getent passwd forensic01`, and home directory verification.
2. `02-log-file-created.png` — `wc -l` showing at least 20 lines and `ls -l` for `sys_events.log`.
3. `03-grep-error-results.png` — output of `grep "ERROR" sys_events.log`.
4. `04-grep-user-root-results.png` — output of `grep -E "root|user01" sys_events.log`.
5. `05-report-head-tail.png` — report creation and/or `head -n 5` and `tail -n 5` results.
6. `06-confidential-permissions.png` — `ls -l confidential.txt` showing mode `-rw-------`.
7. `07-root-ownership-denied.png` — `ls -l` after `chown` and denied read/write attempts as `forensic01`.
8. `08-user-management.png` — `id guest1` and verification that `guest2` was removed.

If one screenshot cannot clearly show everything, take separate screenshots. Use your operating system's screenshot shortcut or screenshot tool. This directory intentionally contains a `.gitkeep` placeholder until you add images.
