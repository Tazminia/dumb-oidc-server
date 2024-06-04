define INSTALL_TOOL_MSG
	
Please, run 'make install-tools' or install manually
endef

.PHONY: install-tools ➤
install-tools:
	@echo "Installing tools..."
	@bash tools/shell/install_required_tools.sh

include tools/mk/python.mk
include tools/mk/kubernetes.mk

## This will list all the targets in the Makefile and allow user to select the one to run
.DEFAULT_GOAL := find-target
.PHONY: find-target
find-target:
	@grep --no-filename -E '.PHONY:[[:space:]].*➤' $(MAKEFILE_LIST) \
	| sed -n -E "s/[[:space:]]+➤//p" \
	| sed -n -E "s/.PHONY:[[:space:]]+//p" \
	| fzf \
	| xargs -I '{}' make {}