PYTHON_BINARY := python
PYTHON_GUARD  := $(shell command -v ${PYTHON_BINARY} 2> /dev/null)
POETRY_BINARY  := poetry
POETRY_GUARD   := $(shell command -v ${POETRY_BINARY} 2> /dev/null)

.PHONY: check-python
check-python: ## Check that python is available
	@echo "+ $@"
ifndef PYTHON_GUARD
	$(error "${PYTHON_BINARY} is not available please install it")
endif
	@echo "Found ${PYTHON_BINARY} (and that's a good news)"

.PHONY: check-poetry
check-poetry: ## Check that poetry is available
	@echo "+ $@"
ifndef POETRY_GUARD
	$(error "${POETRY_BINARY} is not available please install it")
endif
	@echo "Found ${POETRY_BINARY} (and that's a good news)"

.PHONY: install-dependencies
install-dependencies: check-python check-poetry
	${POETRY_BINARY} install --sync 

.PHONY: lint
lint: check-python check-poetry install-dependencies
	${POETRY_BINARY} run isort .
	${POETRY_BINARY} run black .

.PHONY: tests
tests: check-python check-poetry lint
	${POETRY_BINARY} run pytest tests