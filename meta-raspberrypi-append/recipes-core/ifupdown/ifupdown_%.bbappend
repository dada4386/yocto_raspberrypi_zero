FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://network-wireless@.service"
SYSTEMD_SERVICE_${PN} += " network-wireless@wlan0.service"

do_install_append() {
    install -d ${D}/${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/network-wireless@.service \
        ${D}/${systemd_system_unitdir}/network-wireless@.service
    install -d ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/
    ln -sf ${systemd_system_unitdir}/network-wireless@.service \
        ${D}/${sysconfdir}/systemd/system/multi-user.target.wants/network-wireless@wlan0.service
}

FILES_${PN} += "/lib/systemd/system"

REQUIRED_DISTRO_FEATURES= "systemd"
