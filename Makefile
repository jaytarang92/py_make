# ============================ VARIABLES =======================================
PYTHON_VERSION ?= 3.8.0
# SUB_VERSION is mostly for pre-release stuff like 3.8.0a1
PYTHON_SUB_VERSION ?=
PYTHON_DOWNLOAD_URL = 'https://www.python.org/ftp/python/$(PYTHON_VERSION)/Python-$(PYTHON_VERSION)$(PYTHON_SUB_VERSION).tgz'
PYTHON_MAKE_DIR = /tmp/py_make
PYTHON_TAR_FILE_NAME = $(notdir $(PYTHON_DOWNLOAD_URL:'=))
PYTHON_TAR_FILE_PATH = $(PYTHON_MAKE_DIR)/$(PYTHON_TAR_FILE_NAME)
PYTHON_SOURCE_PATH = $(PYTHON_TAR_FILE_PATH:.tgz=)
PYTHON_INSTALL_PATH ?= $(shell echo /home/`whoami`/py_$(PYTHON_VERSION)$(PYTHON_SUB_VERSION))

# =========================== DEFAULT BEHAVIOUR ================================
all: download_and_extract configure_and_install clean

# ================================ RULES =======================================
.PHONY: download_and_extract
download_and_extract:
	-rm -fr $(PYTHON_MAKE_DIR)
	mkdir -p $(PYTHON_MAKE_DIR)
	cd $(PYTHON_MAKE_DIR) && curl -O $(PYTHON_DOWNLOAD_URL)
	cd $(PYTHON_MAKE_DIR) && tar -xvf $(PYTHON_TAR_FILE_PATH)

.PHONY: configure_and_install
configure_and_install:
	cd $(PYTHON_SOURCE_PATH) && ./configure --prefix=$(PYTHON_INSTALL_PATH) --enable-optimizations
	cd $(PYTHON_SOURCE_PATH) && make
	# even if `test` fails keep going
	-cd $(PYTHON_SOURCE_PATH) && make test
	cd $(PYTHON_SOURCE_PATH) && make install

.PHONY: clean
clean:
	rm -r $(PYTHON_MAKE_DIR)
	# removes all the tmp files created by python | recursive just to be safe
	-rm -r /tmp/tmp* /tmp/py*
