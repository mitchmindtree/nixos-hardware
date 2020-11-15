{ lib, pkgs, ... }:
{
  imports = [
    ../../../common/cpu/intel
    ../../../common/pc/laptop
  ];

  hardware.firmware = lib.mkBefore [
    # Necessary for audio.
    # https://bbs.archlinux.org/viewtopic.php?pid=1933548#p1933548
    pkgs.sof-firmware
  ];

  # Confirmed necessary to get audio working as of 2020-11-13:
  # https://bbs.archlinux.org/viewtopic.php?pid=1933643#p1933643
  boot.extraModprobeConfig = ''
    options snd-intel-dspcfg dsp_driver=1
  '';

  # Touchpad goes over i2c.
  # Without this we get errors in dmesg on boot and hangs when shutting down.
  boot.blacklistedKernelModules = [ "psmouse" ];

  # Allows for updating firmware via `fwupdmgr`.
  # services.fwupd.enable = true;
}
