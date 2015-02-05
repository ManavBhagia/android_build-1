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
ifdef LOCAL_CONLYFLAGS
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
LOCAL_ENABLE_NEST := \
	art \
	libsigchain \
	libart-disassembler \
	core.art-host \
	core.art \
	cpplint-art-phony \
	libnativebridgetest \
	libarttest \
	art-run-tests \
	libart-gtest
	

ifeq (1,$(words $(filter $(LOCAL_ENABLE_NEST), $(LOCAL_MODULE))))
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
