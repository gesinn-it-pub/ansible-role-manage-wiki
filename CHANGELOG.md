# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/) and
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

## [3.0.1] - 2026-10-27

Fixes the LDAP CA step on hosts that are not Debian or Ubuntu, e.g. Rocky Linux.

### Fixed
- Skip `update-ca-certificates` on hosts outside the Debian family, where the command does not exist and the LDAP CA step failed. The certificate is still written to the bind-mounted path [`2e00ca0`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/2e00ca0)

## [3.0.0] - 2026-10-24

Requires ansible-core 2.19 and restarts the shared Ofelia container whenever a wiki is restarted or destroyed. Read the
Breaking Changes before you update. The release also fixes the custom Dockerfile rebuilding the wiki on every run and keeps
the GitHub token and the sysop password out of logs and the process list.

### Breaking Changes
- Require ansible-core 2.19 or newer; 2.18 is no longer supported [`aa5df5b`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/aa5df5b)
- Restart the shared Ofelia container after every wiki restart and every `destroy-wiki.yml`. The first rollout restarts Ofelia once per wiki restart. Set `manage_wiki_restart_ofelia: false` to keep the old behaviour [`606bae5`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/606bae5)

### Added
- Add `tasks/restart-ofelia.yml`, so that your own stop and restore flows can restart Ofelia as well. Ofelia 0.3.x reads the job labels of the wiki containers only at its start, so without it the jobs of a recreated wiki never ran [`606bae5`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/606bae5)
- Add the variables `manage_wiki_restart_ofelia` (default `true`), `manage_wiki_ofelia_container` (default `ofelia`) and `manage_wiki_ofelia_wait_seconds` (default `30`) [`606bae5`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/606bae5)
- Skip the restart when no Ofelia container runs, fail with a clear message when the restart fails, and wait up to 30 seconds for a running `run-jobs.sh` first [`606bae5`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/606bae5)

### Changed
- Document the task files, variables, templates and the restart handler in the README [`62156d7`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/62156d7)
- Document the Ofelia restart and its variables [`d4f66b7`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/d4f66b7)

### Fixed
- Stop rebuilding the wiki image on every `ensure-wiki` run when `Dockerfile.Custom.j2` exists [`9461751`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/9461751)
- Run `update-ca-certificates` only when the LDAP CA certificate changed [`9f23ba3`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/9f23ba3)
- Do not abort `ensure-wiki` when `WIKI_USES_EXTRA_CERT` is not set [`b89b6d5`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/b89b6d5)
- Do not fail `destroy-wiki` when the installation folder is already gone [`2a3d83b`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/2a3d83b)
- Keep the GitHub token and the sysop password out of the process list and the Ansible output [`3d1cc67`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/3d1cc67)

[Unreleased]: https://github.com/gesinn-it-pub/ansible-role-manage-wiki/compare/3.0.1...HEAD
[3.0.1]: https://github.com/gesinn-it-pub/ansible-role-manage-wiki/compare/3.0.0...3.0.1
[3.0.0]: https://github.com/gesinn-it-pub/ansible-role-manage-wiki/compare/2.5.1...3.0.0
