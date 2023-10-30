#
# Copyright (C) 2023 Date Huang
#
# This is free software, licensed under the GNU General Public License v3
# See /LICENSE for more informantion.

include $(TOPDIR)/rules.mk

PKG_NAME:=cpusched
PKG_VERSION:=1
PKG_RELEASE:=1
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/cpusched
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=CPU Sched
endef

define Package/cpusched/description
  CPU sched will enable/disable CPU core
endef

define Package/cpusched/compile
endef

define Package/cpusched/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		./files/cpusched.sh \
		$(1)/usr/bin/cpusched.sh

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/cpusched.init $(1)/etc/init.d/cpusched
endef

$(eval $(call BuildPackage,cpusched))
