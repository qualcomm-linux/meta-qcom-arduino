SUMMARY = "Additional device trees for Arduino UNO Q"

inherit devicetree

COMPATIBLE_MACHINE = "uno-q"

SRC_URI = "file://qrb2210-arduino-imola-usbhost.dts"

IMOLA_USBC_OVERLAY = "${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/qcom/qrb2210-arduino-imola-video_sound-usbc.dtso"

# linux-arduino builds qrb2210-arduino-imola.dtb from the base DTB and the
# USB-C video / sound overlay, apply the same overlay here.
python do_compile:append() {
    import subprocess

    overlay = d.getVar("IMOLA_USBC_OVERLAY")
    if os.path.exists(overlay):
        dtb = "qrb2210-arduino-imola-usbhost.dtb"
        dtbo = os.path.splitext(os.path.basename(overlay))[0] + ".dtbo"
        devicetree_compile(overlay, expand_includes("DT_INCLUDE", d), d)
        subprocess.run(["fdtoverlay", "-i", dtb, "-o", dtb + ".tmp", dtbo], check=True)
        os.rename(dtb + ".tmp", dtb)
        os.remove(dtbo)
}
