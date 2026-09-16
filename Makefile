ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BaconSingleBypass
BaconSingleBypass_FILES = BaconSingleBypass.xm
BaconSingleBypass_FRAMEWORKS = UIKit WebKit
BaconSingleBypass_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
