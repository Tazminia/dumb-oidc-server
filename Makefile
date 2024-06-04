include tools/mk/common.mk
include tools/mk/python.mk
include tools/mk/kubernetes.mk

.PHONY: install-tools ➤
install-tools:
	@echo "Installing tools..."
	@bash tools/shell/install_required_tools.sh