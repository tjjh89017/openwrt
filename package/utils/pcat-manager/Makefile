include $(TOPDIR)/rules.mk

PKG_NAME:=pcat-manager
PKG_VERSION:=1.0.16
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tjjh89017/rockchip_rk3568_pcat_manager.git
PKG_SOURCE_DATE:=2022-11-17
PKG_SOURCE_VERSION:=6e6f6820be0c4c69a302a447e9480f5bc07b8c05

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE

PKG_INSTALL:=1
PKG_USE_MIPS16:=0
PKG_BUILD_DEPENDS:=meson/host

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk
#include ../../devel/meson/meson.mk
include $(INCLUDE_DIR)/meson.mk

define Package/pcat-manager
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+glib2 +libgpiod +libjson-c +libusb-1.0
  TITLE:=PCat System Manager
  URL:=https://git.g77k.com
  PROVIDES:=pcat-manager
endef

define Package/pcat-manager/description
  PCat Manager is a system service for power management and modem controlling.
endef

define Package/pcat-manager/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) \
		$(PKG_INSTALL_DIR)/usr/bin/pcat-manager \
		$(1)/usr/bin/pcat-manager

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/pcat-manager.conf $(1)/etc

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/pcat-manager.init $(1)/etc/init.d/pcat-manager
endef


$(eval $(call BuildPackage,pcat-manager))
