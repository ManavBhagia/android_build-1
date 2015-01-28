# Copyright (C) 2014 The SaberMod Project
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

ifneq (1,$(words $(filter $(LOCAL_NO_LTO_SUPPORT), $(LOCAL_MODULE))))
my_cflags += $($(LOCAL_2ND_ARCH_VAR_PREFIX)TARGET_LTO_CFLAGS)
my_cppflags += $($(LOCAL_2ND_ARCH_VAR_PREFIX)TARGET_LTO_CFLAGS)
my_ldflags += $($(LOCAL_2ND_ARCH_VAR_PREFIX)TARGET_LTO_LDFLAGS)
endif

# Force disable some modules that are not compatible with LTO flags
LOCAL_NO_LTO_SUPPORT := \
             libdl \
             init \
             libjemalloc

###
