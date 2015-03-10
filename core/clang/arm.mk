# Clang flags for arm arch, target or host.

CLANG_CONFIG_arm_EXTRA_ASFLAGS := \
  -no-integrated-as

CLANG_CONFIG_arm_EXTRA_CFLAGS := \
  -no-integrated-as

ifneq (,$(filter krait,$(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)))
  # Android's clang support's krait as a CPU whereas GCC doesn't. Specify
  # -mcpu here rather than the more normal core/combo/arch/arm/armv7-a-neon.mk.
  CLANG_CONFIG_arm_EXTRA_CFLAGS += $(call cc-option,-mcpu=swift,-mcpu=cortex-a15)
endif

CLANG_CONFIG_arm_EXTRA_CPPFLAGS := \
  -no-integrated-as

CLANG_CONFIG_arm_EXTRA_LDFLAGS := \
  -no-integrated-as

# Include common unknown flags
CLANG_CONFIG_arm_UNKNOWN_CFLAGS := \
  $(CLANG_CONFIG_UNKNOWN_CFLAGS) \
  -mthumb-interwork \
  -fgcse-after-reload \
  -frerun-cse-after-loop \
  -frename-registers \
  -fno-builtin-sin \
  -fno-strict-volatile-bitfields \
  -fno-align-jumps \
  -Wa,--noexecstack \
  -Wno-unused-local-typedefs \
  -fpredictive-commoning \
  -ftree-loop-distribute-patterns \
  -fvect-cost-model \
  -ftree-partial-pre \
  -fipa-cp-clone \
  -mvectorize-with-neon-quad \
  -fno-if-conversion

define subst-clang-incompatible-arm-flags
  $(subst -march=armv5te,-march=armv5t,\
  $(subst -march=armv5e,-march=armv5,\
  $(subst -mfpu=neon-vfpv3,-mfpu=neon,\
  $(subst -mfpu=neon-vfpv4,-mfpu=neon,\
  $(1)))))
endef


#CLANG QCOM
define subst-clang-qcom-incompatible-arm-flags
  $(subst -march=armv5te,-mcpu=krait2,\
  $(subst -march=armv5e,-mcpu=krait2,\
  $(subst -march=armv7,-mcpu=krait2,\
  $(subst -march=armv7-a,-mcpu=krait2,\
  $(subst -mcpu=cortex-a15,-mcpu=krait2,\
  $(subst -mfpu=cortex-a8,-mcpu=scorpion,\
  $(subst -mfpu=neon-vfpv3,-mfpu=neon,\
  $(subst -mfpu=neon-vfpv4,-mfpu=neon,\
  $(subst -O3,-Ofast -fno-fast-math,\
  $(1))))))))))
endef
