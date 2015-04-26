TARGET = iphone:clang:7.1
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.1
export ARCHS = armv7 armv7s arm64
export THEOS_PACKAGE_DIR_NAME=debs

GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = CCScale
CCScale_FILES = Tweak.xm
CCScale_FRAMEWORKS = Foundation UIKit CoreGraphics QuartzCore
CCScale_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += ccscale
include $(THEOS_MAKE_PATH)/aggregate.mk
