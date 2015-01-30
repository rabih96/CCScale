TARGET = iphone:clang:7.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.1
export ARCHS = armv7 armv7s arm64
export THEOS_DEVICE_IP=192.168.1.65
export THEOS_PACKAGE_DIR_NAME=debs

include theos/makefiles/common.mk

BUNDLE_NAME = CCScale
CCScale_FILES = CCScale.mm HeaderCellCCS.mm
CCScale_INSTALL_PATH = /Library/PreferenceBundles
CCScale_FRAMEWORKS = UIKit
CCScale_PRIVATE_FRAMEWORKS = Preferences
CCScale_CFLAGS = -w

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/CCScale.plist$(ECHO_END)
