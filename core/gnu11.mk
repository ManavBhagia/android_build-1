	

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
     
    # gnu11 checks more for invalid conversions.
    # It can be disabled here or fixed locally.
     
    # GCC and CLANG
    # Don't override the list being genereated once it's been set.
    # Shared libraries may be added and will remain in the list throughout
    # the entire course of a ROM build.
    ifndef LOCAL_DISABLE_GNU11
    LOCAL_DISABLE_GNU11 := \
            libcutils \
            libbinder \
            idmap \
            libpac \
            libstagefright_id3 \
            libnativehelper \
            libandroid_runtime\
            libaudioresampler \
            libjni_pacprocessor \
            libaudioflinger \
            mediaserver \
            libaapt \
            libandroidfw \
            libhwui \
            libcameraservice \
            aapt
    endif

    # Test for modules that are disabled.
    ifeq (1,$(words $(filter $(LOCAL_DISABLE_GNU11),$(LOCAL_MODULE))))

    # Add any local ld libraries to be disabled.
    # This list only gets cleared with clear_vars
    ifdef LOCAL_LDLIBS
    ifndef LOCAL_DISABLE_GNU11_LDLIBS
    LOCAL_DISABLE_GNU11_LDLIBS := $(LOCAL_LDLIBS)
    else
    LOCAL_DISABLE_GNU11_LDLIBS += $(LOCAL_LDLIBS)
    endif
    endif
    endif
     
    # Test to disable for local ldlibs.
    ifeq ($(filter $(LOCAL_DISABLE_GNU11_LDLIBS),$(LOCAL_LDLIBS)),)
     
    # Test to disable for local module.
    ifneq (1,$(words $(filter $(LOCAL_DISABLE_GNU11),$(LOCAL_MODULE))))
     
    # Made it passed all the bs :)
    ifdef LOCAL_CONLYFLAGS
    LOCAL_CONLYFLAGS += -std=gnu11
    else
    LOCAL_CONLYFLAGS := -std=gnu11
    endif
     
    ifdef LOCAL_CPPFLAGS
    LOCAL_CPPFLAGS += -std=gnu++11
    else
    LOCAL_CPPFLAGS := -std=gnu++11
    endif
     
    endif
    endif
     
    #####
