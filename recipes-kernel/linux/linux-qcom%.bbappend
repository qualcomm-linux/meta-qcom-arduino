FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:uno-q = " file://configs/uno-q.cfg"
SRC_URI:append:ventuno-q = " file://configs/ventuno-q.cfg"

# Build the DTBs with __symbols__, so the boot firmware can apply the DTB
# overlays listed in the FIT image
KERNEL_DTC_FLAGS:append:ventuno-q = " -@"
