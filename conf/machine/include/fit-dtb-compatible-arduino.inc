# FIT_DTB_COMPATIBLE entries for the Arduino boards in this layer.
#
# Machines using the FIT image for DTB selection append this file to
# LINUX_QCOM_FIT_DTB_COMPATIBLE, so it is required by dtb-fit-image.bbclass
# after the meta-qcom fit-dtb-compatible include selected for the kernel.
# Entries here can add new keys and override keys from meta-qcom (BitBake
# flags are last-write-wins). Only entries whose DTB/DTBO files are all listed
# in KERNEL_DEVICETREE end up in the FIT image, so entries for other boards
# are ignored.
#
# Syntax and key encoding are the same as in meta-qcom's
# conf/machine/include/fit-dtb-compatible.inc. The compatible strings must
# match the configurations in qcom-dtb-metadata's qcom-next-fitimage.its.

# ---------- ventuno-q (monza) ----------
FIT_DTB_COMPATIBLE[qcom_qcs8275-iot-subtype4] = "monaco-arduino-monza monaco-el2"
