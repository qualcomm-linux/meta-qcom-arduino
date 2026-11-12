FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:arduino = " \
    file://0001-ucm2-add-Arduino-monza-support.patch \
    file://0002-ucm2-Arduino-Monza-add-display-port-audio.patch \
"
