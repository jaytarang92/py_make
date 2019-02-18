# ============================ VARIABLES =======================================
PYTHON_VERSION ?= 3.8.0
# SUB_VERSION is mostly for pre-release stuff like 3.8.0a1
PYTHON_SUB_VERSION ?= a1
PYTHON_DOWNLOAD_URL = 'https://www.python.org/ftp/python/$(PYTHON_VERSION)/Python-$(PYTHON_VERSION)$(PYTHON_SUB_VERSION).tgz'
PYTHON_MAKE_DIR ?= /tmp/py_make
PYTHON_TAR_FILE_NAME = $(notdir $(PYTHON_DOWNLOAD_URL:'=))
PYTHON_TAR_FILE_PATH = $(PYTHON_MAKE_DIR)/$(PYTHON_TAR_FILE_NAME)
PYTHON_SOURCE_PATH = $(PYTHON_TAR_FILE_PATH:.tgz=)
PYTHON_INSTALL_PATH ?= $(shell echo /home/`whoami`/py_$(PYTHON_VERSION)$(PYTHON_SUB_VERSION))

# =========================== DEFAULT BEHAVIOUR ================================
default: pre_clean download extract configure install clean

# ================================ RULES =======================================
.PHONY: pre_clean
pre_clean:
	-rm -fr $(PYTHON_MAKE_DIR)

.PHONY: download
download:
	mkdir -p $(PYTHON_MAKE_DIR)
	cd $(PYTHON_MAKE_DIR) && curl -O $(PYTHON_DOWNLOAD_URL)
	
.PHONY: extract
extract:
	cd $(PYTHON_MAKE_DIR) && tar -xf $(PYTHON_TAR_FILE_PATH)

.PHONY: configure
configure:
	cd $(PYTHON_SOURCE_PATH) && ./configure --prefix=$(PYTHON_INSTALL_PATH) --enable-optimizations

.PHONY: install
install:
	cd $(PYTHON_SOURCE_PATH) && make
	# even if `test` fails keep going
	-cd $(PYTHON_SOURCE_PATH) && make test
	cd $(PYTHON_SOURCE_PATH) && make install

.PHONY: clean
clean:
	rm -r $(PYTHON_MAKE_DIR)
	# removes all the tmp files created by python | recursive just to be safe
	-rm -r /tmp/tmp* /tmp/py*

.PHONY: travis_ci_test
travis_ci_test: pre_clean download extract configure clean

.PHONY: circle_ci_build
travis_ci_test: pre_clean download extract configure install clean

