DESCRIPTION = "Linux ${PV} kernel for QCOM-based Arduino devices"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"
SECTION = "kernel"

inherit kernel cml1

COMPATIBLE_MACHINE = "(arduino)"

LINUX_VERSION ?= "7.2.11"

PV = "${LINUX_VERSION}"

# branch: qcom-v7.2.11-arduino
SRCREV ?= "f56a3e0c99c68925a954778910129f3ee6371849"
SRCBRANCH ?= "nobranch=1"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = "\
    git://github.com/arduino/linux-qcom.git;${SRCBRANCH};protocol=https \
    file://configs/arduino.cfg \
"

# Board options, shared with the linux-qcom kernels
SRC_URI:append:uno-q = " file://configs/uno-q.cfg"
SRC_URI:append:ventuno-q = " file://configs/ventuno-q.cfg"

# Build the DTBs with __symbols__, so the boot firmware can apply the DTB
# overlays listed in the FIT image
KERNEL_DTC_FLAGS:append:ventuno-q = " -@"

S = "${UNPACKDIR}/${BP}"

KBUILD_DEFCONFIG ?= "defconfig"

do_configure:prepend() {
    # Use a copy of the 'defconfig' from the actual repo to merge fragments
    cp ${S}/arch/${ARCH}/configs/${KBUILD_DEFCONFIG} ${B}/.config

    # Merge fragment for QCOM value add features
    ${S}/scripts/kconfig/merge_config.sh -m -O ${B} ${B}/.config ${@" ".join(find_cfgs(d))}
}
