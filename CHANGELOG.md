# Changelog

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](https://semver.org/) and
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

Raises the ansible-core floor to 2.19.

### Breaking Changes
- Require ansible-core 2.19 or newer [`00f9428`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/00f9428)

### Fixed
- `ensure-wiki`: render the custom Dockerfile in one step. It was re-rendered and appended on every run, so the wiki image was rebuilt on every ensure [`34a5965`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/34a5965)
- `ensure-wiki`: run `update-ca-certificates` only when the LDAP CA certificate changed [`5e8938f`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/5e8938f)
- `ensure-wiki`: no longer abort when `WIKI_USES_EXTRA_CERT` is not set [`523b837`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/523b837)
- `destroy-wiki`: no longer fail when the installation folder is already gone [`fdd4951`](https://github.com/gesinn-it-pub/ansible-role-manage-wiki/commit/fdd4951)

### Security
- `restart-wiki` handler: pass the GitHub token and the sysop password on stdin and censor the tasks, so that they do not appear in the process list or the Ansible output

[Unreleased]: https://github.com/gesinn-it-pub/ansible-role-manage-wiki/compare/2.5.1...HEAD
