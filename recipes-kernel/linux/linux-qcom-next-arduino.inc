FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-next:"

# On the UNO Q the PSCI CPU PM domains probe before MPM, their parent
# domain, so psci_cpuidle_domain_probe() removes them and defers. The genpd
# core then frees them while the device link removals queued by device_del()
# still use genpd->dev. Drop once qcom-next carries the upstream fix.
SRC_URI:append:uno-q = " \
    file://0001-pmdomain-core-Wait-for-device-link-removals-before-d.patch \
"
