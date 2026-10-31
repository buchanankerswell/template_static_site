CONDA_ENV_ID := mysite
CONDA_ENV_YML := environment.yml
HOST := 127.0.0.1
SERVE_PORT := 8811

include project.mk

.DEFAULT_GOAL := help

SITE := $(PROJECT_ROOT)/docs
CONDA_PYTHON = $$(conda run -n $(CONDA_ENV_ID) which python)
CLEAN := $(PROJECT_ROOT)/.pytest_cache
DEEP_CLEAN :=

.PHONY: all build run test format environment clean deep-clean help

build: environment test

all: build run

run:
	@$(CONDA_PYTHON) -m http.server $(SERVE_PORT) --directory $(SITE)

test:
	@$(CONDA_PYTHON) $(PROJECT_ROOT)/pipeline/check.py $(SITE)

format:
	@$(CONDA_PYTHON) -m ruff format .
	@npx --yes prettier --write "docs/*.js" "docs/*.css"

environment: $(CONDA_ENV_YML) $(LOG_FILE)
	@if ! conda info --envs | awk '{print $$1}' | grep -qx "$(CONDA_ENV_ID)"; then \
		conda env create -n "$(CONDA_ENV_ID)" -f "$(CONDA_ENV_YML)" $(LOGGER); \
	fi

clean:
	@echo "    --------------------------------------------------"
	@echo "    Cleaning ..."
	@echo "    --------------------------------------------------"
	@$(call SAFE_RM_LIST,$(CLEAN))
	@find $(PROJECT_ROOT)/pipeline -name "__pycache__" -exec echo " xx {}" \; -exec rm -rf {} +
	@find . -name ".DS_Store" -type f -delete

deep-clean: clean
	@echo "    --------------------------------------------------"
	@echo "    Deep cleaning ..."
	@echo "    --------------------------------------------------"
	@$(call SAFE_RM_LIST,$(DEEP_CLEAN))

$(LOG_FILE):
	@mkdir -p $(dir $(LOG_FILE))
	@touch $(LOG_FILE)

help:
	@echo "    --------------------------------------------------"
	@echo "    Available targets:"
	@echo "    --------------------------------------------------"
	@echo "    build        Build mysite from scratch (environment + test)"
	@echo "    all          Build then serve the site locally"
	@echo "    run          Serve the site locally"
	@echo "    test         Validate the site and its referenced assets"
	@echo "    format       Format code to 150 columns (ruff + prettier)"
	@echo "    environment  Create Conda environment"
	@echo "    clean        Cleanup unnecessary files and directories (safe)"
	@echo "    deep-clean   Deep clean generated files and logs (use with caution!)"
	@echo "    help         Show this help message"
