ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = BaconSingleBypass
BaconSingleBypass_FILES = BaconSingleBypass.m
BaconSingleBypass_FRAMEWORKS = UIKit WebKit
BaconSingleBypass_CFLAGS = -fobjc-arc
BaconSingleBypass_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS_MAKE_PATH)/library.mk
