FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:arduino = " \
    file://0001-ucm2-Arduino-Monza-fix-headset-microphone-capture.patch \
"
