FILESEXTRAPATHS:prepend := "${THISDIR}/linux-qcom-6.18:"

SRC_URI:append:ventuno-q = " \
    file://0001-arm64-dts-qcom-qcs8300-Add-qref-and-refgen-supply-for-PCIe-.patch \
    file://0002-Revert-FROMLIST-Bluetooth-hci_qca-Set-bt_en_available-based-.patch \
    file://0003-power-sequencing-pcie-m2-Add-QCA2066-QCNFA765-BT-serdev-ID.patch \
    file://0004-power-sequencing-Add-pwrseq_is_controllable-API.patch \
    file://0005-power-sequencing-pcie-m2-Report-power-controllability.patch \
    file://0006-power-sequencing-qcom-wcn-Report-power-controllability.patch \
    file://0007-Bluetooth-hci_qca-Set-bt_en_available-based-on-pwrseq-power.patch \
    file://0008-Bluetooth-hci_qca-Embed-bt_power-in-struct-qca_serdev.patch \
    file://0009-Bluetooth-hci_qca-Support-QCA2066-on-M.2-connector-via-pwrs.patch \
    file://0010-Bluetooth-hci_qca-Flatten-struct-qca_power-into-struct-qca_.patch \
    file://0011-dt-bindings-connector-pcie-m2-e-Add-vendor-LGA-connector-co.patch \
    file://0012-arm64-dts-qcom-monaco-arduino-monza-Add-QCA2066-M.2-WiFi-BT.patch \
"
