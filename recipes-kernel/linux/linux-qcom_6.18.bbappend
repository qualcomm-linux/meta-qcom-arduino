FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-6.18:"

SRC_URI:append:ventuno-q = " \
    file://0001-arm64-dts-qcom-qcs8300-Add-qref-and-refgen-supply-for-PCIe-.patch \
"
