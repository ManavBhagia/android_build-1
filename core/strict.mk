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

ifneq (1,$(words $(filter $(LOCAL_DISABLE_STRICT), $(LOCAL_MODULE))))
ifdef  LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += \
	-fstrict-aliasing \
	-Werror=strict-aliasing
else
LOCAL_CONLYFLAGS := \
	-fstrict-aliasing \
	-Werror=strict-aliasing
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += \
	-fstrict-aliasing \
	-Werror=strict-aliasing
else
LOCAL_CPPFLAGS := \
	-fstrict-aliasing \
	-Werror=strict-aliasing
endif
ifndef LOCAL_CLANG
LOCAL_CONLYFLAGS += \
	-Wstrict-aliasing=3
LOCAL_CPPFLAGS += \
	-Wstrict-aliasing=3
else
LOCAL_CONLYFLAGS += \
	-Wstrict-aliasing=2
LOCAL_CPPFLAGS += \
	-Wstrict-aliasing=2
endif
endif
#####
