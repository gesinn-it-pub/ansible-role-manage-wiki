ANSIBLE_LINT_IMAGE := ghcr.io/ansible/community-ansible-dev-tools:26.4.0

docker-run := docker run --rm \
	-v "$(CURDIR):/workspace:ro" \
	-w /workspace \
	$(ANSIBLE_LINT_IMAGE)

# molecule needs write access (scenario cache, tmp files)
docker-run-rw := docker run --rm \
	-v "$(CURDIR):/workspace" \
	-w /workspace \
	$(ANSIBLE_LINT_IMAGE)

.PHONY: lint molecule ci

lint:
	$(docker-run) bash -c "ansible-lint"

molecule:
	$(docker-run-rw) bash -c "mkdir -p /tmp/roles \
		 && ln -s /workspace /tmp/roles/ansible-role-manage-wiki \
		 && ANSIBLE_ROLES_PATH=/tmp/roles molecule test -s default"

ci: lint molecule
