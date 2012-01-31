LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

# measurements show that the ARM version of ZLib is about x1.17 faster
# than the thumb one...
LOCAL_ARM_MODE := arm

zlib_files := \
	adler32.c \
	compress.c \
	crc32.c \
	deflate.c \
	gzclose.c \
	gzlib.c \
	gzread.c \
	gzwrite.c \
	infback.c \
	inflate.c \
	inftrees.c \
	inffast.c \
	trees.c \
	uncompr.c \
	zutil.c

LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -O3 -DUSE_MMAP
LOCAL_SRC_FILES := $(zlib_files)
ifneq ($(TARGET_ARCH),x86)
  LOCAL_NDK_VERSION := 5
  LOCAL_SDK_VERSION := 9
endif
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -O3 -DUSE_MMAP
LOCAL_SRC_FILES := $(zlib_files)
ifneq ($(TARGET_ARCH),x86)
  LOCAL_NDK_VERSION := 5
  LOCAL_SDK_VERSION := 9
endif
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_ARM_MODE := arm
LOCAL_MODULE := libz
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS += -O3 -DUSE_MMAP
LOCAL_SRC_FILES := $(zlib_files)
include $(BUILD_HOST_STATIC_LIBRARY)



# libunz used to be an unzip-only subset of libz. Only host-side tools were
# taking advantage of it, though, and it's not a notion supported by zlib
# itself. This caused trouble during the 1.2.6 upgrade because libunz ended
# up needing to drag in most of the other files anyway. So this is a first
# step towards killing libunz. If you're reading this in the K release or
# later, please see if you can get a bit further in removing libunz...

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(zlib_files)
LOCAL_MODULE:= libunz
LOCAL_ARM_MODE := arm
include $(BUILD_HOST_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(zlib_files)
LOCAL_MODULE:= libunz
LOCAL_ARM_MODE := arm
ifneq ($(TARGET_ARCH),x86)
  LOCAL_NDK_VERSION := 5
  LOCAL_SDK_VERSION := 9
endif
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=        \
	minigzip.c

LOCAL_MODULE:= gzip

LOCAL_SHARED_LIBRARIES := libz

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=        \
	minigzip.c

LOCAL_MODULE:= minigzip

LOCAL_STATIC_LIBRARIES := libz

include $(BUILD_HOST_EXECUTABLE)
