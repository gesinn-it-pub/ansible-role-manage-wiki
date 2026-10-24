# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/) and
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

Raises the ansible-core floor to 2.19 and restarts Ofelia after changes to the wiki containers.

On the first rollout every wiki restart (and every `destroy-wiki.yml`) restarts the shared Ofelia container once. Set
`manage_wiki_restart_ofelia: false` to keep the old behaviour.

### Breaking Changes
- Require ansible-core 2.19 or newer [`00f9428`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/00f9428)

### Added
- `tasks/restart-ofelia.yml`: restart the shared Ofelia container, for callers that stop, destroy or restore wikis themselves
- The variables `manage_wiki_restart_ofelia`, `manage_wiki_ofelia_container` and `manage_wiki_ofelia_wait_seconds`

### Changed
- The restart handler restarts Ofelia after the wiki is up, because Ofelia 0.3.x reads the job labels only at its start; without this the jobs of a recreated wiki never ran. A running `run-jobs.sh` is awaited for up to 30 seconds first
- `destroy-wiki.yml` restarts Ofelia afterwards, so that it stops failing on the jobs of the removed containers
- The restart handler has six steps instead of four: the changePassword.php call is a step of its own

### Fixed
- `ensure-wiki`: render the custom Dockerfile in one step. It was re-rendered and appended on every run, so the wiki image was rebuilt on every ensure [`34a5965`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/34a5965)
- `ensure-wiki`: run `update-ca-certificates` only when the LDAP CA certificate changed [`5e8938f`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/5e8938f)
- `ensure-wiki`: no longer abort when `WIKI_USES_EXTRA_CERT` is not set [`523b837`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/523b837)
- `destroy-wiki`: no longer fail when the installation folder is already gone [`fdd4951`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/fdd4951)

### Security
- `restart-wiki` handler: pass the GitHub token and the sysop password on stdin and censor the tasks, so that they do not appear in the process list or the Ansible output

[Unreleased]: https://github.com/gesinn-it-pub/ansible-role-manage-wiki/compare/2.5.1...HEAD
