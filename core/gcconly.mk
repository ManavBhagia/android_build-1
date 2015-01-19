# Copyright (C) 2015 The SaberMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_DISABLE_GCCONLY := \
	bluetooth.default \
	libwebviewchromium \
	libwebviewchromium_loader \
	libwebviewchromium_plat_support

GCCONLY_FLAGS += -fira-loop-pressure \
	-fforce-addr \
	-funsafe-loop-optimizations \
	-funroll-loops \
	-ftree-loop-distribution \
	-fsection-anchors \
	-ftree-loop-im \
	-ftree-loop-ivcanon \
	-ffunction-sections \
	-fgcse-las \
	-fgcse-sm \
	-fweb \
	-ffp-contract=fast \
	-mvectorize-with-neon-quad

ifneq (1,$(words $(filter $(LOCAL_DISABLE_GCCONLY), $(LOCAL_MODULE))))
ifndef LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += $(GCCONLY_FLAGS)
else
LOCAL_CONLYFLAGS := $(GCCONLY_FLAGS)
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += $(GCCONLY_FLAGS)
else
LOCAL_CPPFLAGS := $(GCCONLY_FLAGS)
endif
endif

ifeq ($(FLOOP_NEST_OPTIMIZE),true)
LOCAL_DISABLE_NEST := \
	libunwind \
	libFFTEm \
	libicui18n \
	libskia \
	libvpx \
	libmedia_jni \
	libstagefright_mp3dec \
	libart \
	libstagefright_amrwbenc \
	libpdfium \
	libpdfiumcore \
	libwebviewchromium \
	libwebviewchromium_loader \
	libwebviewchromium_plat_support \
	libjni_filtershow_filters \
	fio \
	libselinux \
	init \
	libmincrypt \
	adbd \
	libpixelflinger_static \
	libz \
	pigz \
	libclearsilverregex \
	busybox \
	libext2fs \
	e2fsck \
	libstlport \
	libft2 \
	libjpeg_static \
	libmincrypttwrp \
	libopenaes \
	toolbox_recovery \
	libandroid_runtime \
	libicuuc \
	libwebp-encode \
	libhwui \
	libsfntly \
	libminikin \
	libbt-brcm_stack \
	bluetooth.default \
	libtinyxml2 \
	libnfc-nci \
	libxml2 \
	libunz \
	adb \
	dalvikvm \
	dnsmasq \
	toolbox \
	libart-compiler \
	hostapd \
	mdnsd \
	libsoftkeymaster \
	libaudioflinger \
	libstagefright_avc_common \
	libstagefright \
	libogg \
	libvorbisidec \
	libstagefright_aacenc \
	libstagefright_id3 \
	libFLAC \
	wpa_supplicant \
	libstagefright_amrnb_common \
	libjavacore \
	librtp_jni \
	libgsm \
	libstagefright_amrnbenc \
	libmmcamera_interface \
	camera.hammerhead \
	nfc_nci.bcm2079x.default \
	libfilterfw_jni \
	libfilterfw_native \
	libpixelflinger \
	libsqlite_jni \
	libFraunhoferAAC \
	librs_jni \
	libstagefright_amrwbdec \
	libstagefright_avcenc \
	libhevcdec \
	libstagefright_m4vh263dec \
	libstagefright_m4vh263enc \
	libwebrtc_spl \
	libwebrtc_apm_utility \
	libwebrtc_apm \
	libwebrtc_vad \
	libwebrtc_system_wrappers \
	libwebrtc_aecm \
	libreverb \
	libwifi-service \
	libstlport_static \
	libgtest \
	backtrace_test \
	libbz

ifneq (1,$(words $(filter $(LOCAL_DISABLE_NEST), $(LOCAL_MODULE))))
ifdef LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += \
	-floop-nest-optimize
else
LOCAL_CONLYFLAGS := \
	-floop-nest-optimize
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += \
	-floop-nest-optimize
else
LOCAL_CPPFLAGS := \
	-floop-nest-optimize
endif
endif
endif
#####
