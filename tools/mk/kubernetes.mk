# Kubernetes
KUBERNETES_BINARY := kubectl
KUBERNETES_GUARD  := $(shell ${KUBERNETES_BINARY} version --client=true 2> /dev/null)

# Skaffold
SKAFFOLD_BINARY := skaffold
SKAFFOLD_GUARD  := $(shell ${SKAFFOLD_BINARY} version 2> /dev/null)

.PHONY: check-kubectl
check-kubectl: ## Check that terraform is available
	@echo "+ $@"
ifndef KUBERNETES_GUARD
	$(error ${KUBERNETES_BINARY} cannot be found. ${INSTALL_TOOL_MSG})
endif
	@echo "Found ${KUBERNETES_BINARY} (and that's a good news)"

.PHONY: check-skaffold
check-skaffold: ## Check that terraform is available
	@echo "+ $@"
ifndef SKAFFOLD_GUARD
	$(error ${SKAFFOLD_BINARY} cannot be found. ${INSTALL_TOOL_MSG})
endif
	@echo "Found ${SKAFFOLD_BINARY} (and that's a good news)"

.PHONY: deploy-local ➤
deploy-local: check-skaffold
	@echo "Deploy dumb-oidc-server application to local kind cluster..."
	@${SKAFFOLD_BINARY} run --profile=local

.PHONY: forward-port ➤
forward-port-for-back: check-kubectl
	@echo "Expose OIDC server from kind cluster to local machine on port 8080..."
	@${KUBERNETES_BINARY} port-forward service/dumb-oidc-server 8080:80