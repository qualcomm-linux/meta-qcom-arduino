FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-next:"

# Replace the v1 MPM series carried by qcom-next, which leaves the UNO Q
# without CPU idle and stuck at boot, with v3. Drop these once qcom-next
# carries the fix: https://github.com/qualcomm-linux/kernel/issues/1371
SRC_URI:append:uno-q = " \
    file://0001-Revert-FROMLIST-arm64-dts-qcom-shikra-Add-CPU-idle-s.patch \
    file://0002-Revert-FROMLIST-irqchip-irq-qcom-mpm-Program-wakeup-.patch \
    file://0003-Revert-FROMLIST-irqchip-irq-qcom-mpm-Prepare-common-.patch \
    file://0004-Revert-FROMLIST-irqchip-irq-qcom-mpm-Register-MPM-un.patch \
    file://0005-Revert-FROMLIST-dt-bindings-interrupt-controller-mpm.patch \
    file://0006-FROMLIST-irqchip-irq-qcom-mpm-Register-MPM-with-cpu_.patch \
    file://0007-FROMLIST-arm64-dts-qcom-shikra-Add-CPU-idle-states.patch \
"
