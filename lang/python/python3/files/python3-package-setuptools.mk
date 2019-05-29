#
# Copyright (C) 2017 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Package/python3-setuptools
$(call Package/python3/Default)
  TITLE:=Python $(PYTHON3_VERSION) setuptools module
  VERSION:=$(PYTHON3_SETUPTOOLS_VERSION)-$(PYTHON3_SETUPTOOLS_PKG_RELEASE)
  LICENSE:=MIT
  LICENSE_FILES:=LICENSE
#  CPE_ID:=cpe:/a:python:setuptools # not currently handled this way by uscan
  DEPENDS:=+python3
endef

define Py3Package/python3-setuptools/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages
	$(CP) $(PKG_BUILD_DIR)/install-setuptools/usr/bin/easy_install-* $(1)/usr/bin
	$(LN) easy_install-$(PYTHON3_VERSION) $(1)/usr/bin/easy_install-3
	$(CP) \
		$(PKG_BUILD_DIR)/install-setuptools/usr/lib/python$(PYTHON3_VERSION)/site-packages/pkg_resources \
		$(PKG_BUILD_DIR)/install-setuptools/usr/lib/python$(PYTHON3_VERSION)/site-packages/setuptools \
		$(PKG_BUILD_DIR)/install-setuptools/usr/lib/python$(PYTHON3_VERSION)/site-packages/setuptools-$(PYTHON3_SETUPTOOLS_VERSION).dist-info \
		$(PKG_BUILD_DIR)/install-setuptools/usr/lib/python$(PYTHON3_VERSION)/site-packages/easy_install.py \
		$(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages
	for _ in \$(seq 1 10) ; do \
		find $(1)/usr/lib/python$(PYTHON3_VERSION)/site-packages/ -name __pycache__ -exec rm -rf {} \; || continue ; \
		break ; \
	done
endef

$(eval $(call Py3BasePackage,python3-setuptools, \
	, \
	DO_NOT_ADD_TO_PACKAGE_DEPENDS \
))
