################################################################################
#
# rtl8723ds
#
################################################################################

RTL8723DS_VERSION = 1.0
RTL8723DS_SITE = "https://gitee.com/chrithon_official/rtl8723ds-linux/attach_files/957021/download/rtl8723ds.tar.gz"
RTL8723DS_LICENSE = GPL-2.0

RTL8723DS_MODULE_MAKE_OPTS = \
	CONFIG_RTL8723DS=m \
	KVER=$(LINUX_VERSION_PROBED) \
	KSRC=$(LINUX_DIR)

$(eval $(kernel-module))
$(eval $(generic-package))
