 export THEOS_DEVICE_IP = 10.37.1.102
 ARCHS = arm64 arm64e
 export TARGET = iphone:12.1.2:12.1.2

# TARGET = simulator:clang::7.0
# ARCHS = x86_64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PerfectTimeXS
PerfectTimeXS_FILES = Tweak.xm
PerfectTimeXS_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
	
SUBPROJECTS += perfecttimexs
include $(THEOS_MAKE_PATH)/aggregate.mk

ifneq (,$(filter x86_64,$(ARCHS)))
setup:: clean all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
	/Users/ganning/git/jailbreak/simject/bin/respring_simulator
endif