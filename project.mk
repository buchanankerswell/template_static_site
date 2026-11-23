PROJECT_ROOT := $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/.)

CONDA_ENV_ID := mysite
CONDA_ENV_YML := environment.yml
HOST := 127.0.0.1
SERVE_PORT := 8811
SITE := $(PROJECT_ROOT)/docs
PIPELINE := $(PROJECT_ROOT)/pipeline
CONDA_PYTHON = $$(conda run -n $(CONDA_ENV_ID) which python)
CLEAN := $(PROJECT_ROOT)/.pytest_cache
DEEP_CLEAN := $(PROJECT_ROOT)/.log

DATE := $(shell date +"%d-%m-%Y")
LOG_FILE := $(PROJECT_ROOT)/.log/log-$(DATE).log
LOGGER := 2>&1 | tee -a $(LOG_FILE)

define SAFE_RM
	if [ -e "$(1)" ]; then \
	  ABS_PATH=$$(realpath "$(1)"); \
	  case "$$ABS_PATH" in \
	    $(PROJECT_ROOT)*) \
	      echo " xx $$ABS_PATH"; \
	      rm -rf "$$ABS_PATH";; \
	  esac; \
	fi
endef

define SAFE_RM_LIST
	for item in $(1); do $(call SAFE_RM,$$item); done
endef
