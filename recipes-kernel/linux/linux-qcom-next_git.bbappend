FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

LINUX_VERSION:ventuno-q = "7.1"
SRCREV:ventuno-q = "a8333ec565679efd20a9e5dfcdab8cc97e3bfcb2"
KBUILD_CONFIG_EXTRA:remove:ventuno-q = "${S}/arch/arm64/configs/prune.config ${S}/arch/arm64/configs/qcom.config"
SRCBRANCH:ventuno-q = "nobranch=1"
SRCBRANCH:class-devupstream:ventuno-q = "branch=early/hwe/arduino"
SRC_URI:remove:ventuno-q = "git://github.com/qualcomm-linux/kernel.git;${SRCBRANCH};protocol=https file://0001-PENDING-arm64-dts-qcom-talos-evk-add-QPS615-m.2-ethe.patch"
SRC_URI:append:ventuno-q = " git://github.com/qualcomm-linux/kernel-topics.git;${SRCBRANCH};protocol=https file://configs/monza.cfg"
