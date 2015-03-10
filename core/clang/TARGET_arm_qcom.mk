#define toolchain
LLVM_PREBUILTS_PATH_QCOM := prebuilts/clang/linux-x86/host/llvm-Snapdragon_LLVM_for_Android_3.5/prebuilt/linux-x86_64/bin
LLVM_PREBUILTS_HEADER_PATH_QCOM := $(LLVM_PREBUILTS_PATH_QCOM)/../lib/clang/3.5.0/include/

CLANG_QCOM := $(LLVM_PREBUILTS_PATH_QCOM)/clang
CLANG_QCOM_CXX := $(LLVM_PREBUILTS_PATH_QCOM)/clang++

LLVM_AS := $(LLVM_PREBUILTS_PATH_QCOM)/llvm-as
LLVM_LINK := $(LLVM_PREBUILTS_PATH_QCOM)/llvm-link

CLANG_QCOM_CONFIG_EXTRA_TARGET_C_INCLUDES := $(LLVM_PREBUILTS_HEADER_PATH_QCOM)

COMPILER_RT_CONFIG_EXTRA_STATIC_LIBRARIES := libcompiler_rt-extras libclang_rt.optlibc-krait2 libclang_rt.builtins-arm_android libclang_rt.profile-armv7 libclang_rt.translib libclang_rt.translib32

#when NOT to use CLANG_QCOM
DONT_USE_CLANG_QCOM_MODULES :=

#https://android-review.googlesource.com/#/c/110170/
DONT_USE_CLANG_QCOM_AS_MODULES := \
  libc++abi

#modules for language mode c++11
CLANG_QCOM_C11 := \
  libjni_latinime_common_static \
  libjni_latinime

#define compile flags
CLANG_QCOM_CONFIG_arm_TARGET_TRIPLE := armv7a-linux-androideabi

CLANG_QCOM_CONFIG_arm_TARGET_TOOLCHAIN_PREFIX := \
  $(TARGET_TOOLCHAIN_ROOT)/arm-linux-androideabi/bin

CLANG_QCOM_CONFIG_EXTRA_LLVM_FLAGS := \
  -Qunused-arguments -Wno-unknown-warning-option -D__compiler_offsetof=__builtin_offsetof \
  -Wno-tautological-constant-out-of-range-compare \
  -fcolor-diagnostics \
  -fstrict-aliasing \
  -Wstrict-aliasing=3 \
  -fuse-ld=gold
  #-Wno-unused-parameter -Wno-unused-variable -Wunused-but-set-variable

ifeq ($(TARGET_CPU_VARIANT),krait)
  mcpu_clang_qcom := -mcpu=krait2 -muse-optlibc
else ifeq ($(TARGET_CPU_VARIANT),scorpion)
  mcpu_clang_qcom := -mcpu=scorpion
else
 # $(info  )
 # $(info QCOM_CLANG: warning no supported cpu detected. Only Krait and Scorpion supported!!)
 # $(info  )
endif


#see documentation especialy 3.4.21 Math optimization.
CLANG_QCOM_CONFIG_EXTRA_KRAIT_FLAGS := \
  -Ofast $(mcpu_clang_qcom) -mfpu=neon  -mfloat-abi=softfp -fvectorize-loops \
  -fno-fast-math \
  -fomit-frame-pointer \
  -ffinite-math-only \
  -ffunction-sections \
  -foptimize-sibling-calls \
  -fmerge-functions \
  -fvectorize-loops \
  -funsafe-math-optimizations
  #-falign-os -falign-functions -falign-labels -falign-loops


#TODO:
#-fparallel where to use? see 3.6.4
#-falign-os #only for -Os
#-falign-functions -falign-labels #only for -Ofast
#-fdata-sections -finline-functions ?
#-ffp-contract=fast maybe too dangerous?

ifeq ($(USE_CLANG_QCOM_LTO),true)
  #CLANG_QCOM_CONFIG_EXTRA_KRAIT_FLAGS += -c-lto -flto
endif

CLANG_QCOM_CONFIG_EXTRA_FLAGS := \
  -Qunused-arguments -Wno-unknown-warning-option -D__compiler_offsetof=__builtin_offsetof \
  $(CLANG_QCOM_CONFIG_EXTRA_LLVM_FLAGS) \
  $(CLANG_QCOM_CONFIG_EXTRA_KRAIT_FLAGS)

CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_CFLAGS := \
  -nostdlibinc \
  $(CLANG_QCOM_CONFIG_EXTRA_FLAGS) \
  -target $(CLANG_QCOM_CONFIG_arm_TARGET_TRIPLE) \
  -B$(CLANG_QCOM_CONFIG_arm_TARGET_TOOLCHAIN_PREFIX)

CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_CPPFLAGS := \
  -nostdlibinc \
  $(CLANG_QCOM_CONFIG_EXTRA_FLAGS) \
  -target $(CLANG_QCOM_CONFIG_arm_TARGET_TRIPLE)

CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_LDFLAGS := \
  -target $(CLANG_QCOM_CONFIG_arm_TARGET_TRIPLE) \
  -B$(CLANG_QCOM_CONFIG_arm_TARGET_TOOLCHAIN_PREFIX)

define convert-to-clang-qcom-flags
  $(strip \
  $(call subst-clang-qcom-incompatible-arm-flags,\
  $(filter-out $(CLANG_CONFIG_arm_UNKNOWN_CFLAGS),\
  $(1))))
endef

CLANG_QCOM_TARGET_GLOBAL_CFLAGS := \
  $(call convert-to-clang-qcom-flags,$(TARGET_GLOBAL_CFLAGS)) \
  $(CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_CFLAGS)

CLANG_QCOM_TARGET_GLOBAL_CPPFLAGS := \
  $(call convert-to-clang-qcom-flags,$(TARGET_GLOBAL_CPPFLAGS)) \
  $(CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_CPPFLAGS)

$(clang_2nd_arch_prefix)CLANG_QCOM_TARGET_GLOBAL_LDFLAGS := \
  $(call convert-to-clang-qcom-flags,$(TARGET_GLOBAL_LDFLAGS)) \
  $(CLANG_QCOM_CONFIG_arm_TARGET_EXTRA_LDFLAGS)

CLANG_QCOM_MODULES := 
  #use grep
