import os, osproc, strutils
import notify

type Status = enum
  Discharging, Charging, Full

const
  timeout_round          = 4
  timeout_round_charging = 30
  timeout_round_full     = 60
  timeout_suspension     = 90
  notification_timeout   = 6000
  bat_level_critical     = 10
  bat_level_low          = 15
  icon_level_critical = "/usr/share/icons/Sardi-Ghost-Flexible-Viking/scalable/status/battery-010.svg"
  icon_level_low = "/usr/share/icons/Sardi-Ghost-Flexible-Viking/scalable/status/battery-030.svg"
  sound = "/home/ykitten/.sounds/GW150914_template_shifted.wav"
  bat_level_info_filename  = "/sys/class/power_supply/BAT1/capacity"
  bat_status_info_filename = "/sys/class/power_supply/BAT1/status"

var
  already_notified_critical, already_notified_low = false
  bat_level: uint
  bat_status: string

proc makeSound() =
  discard execCmd "mpv " & sound & " &>/dev/null &"

proc timeout(secs: int) =
  sleep(secs*1000)

while true:
  timeout timeout_round
  bat_level  = parseUInt(readFile(bat_level_info_filename).strip)
  bat_status = readFile(bat_status_info_filename).strip
  if bat_status == $Status.Discharging and bat_level <= bat_level_critical and not already_notified_critical:
    already_notified_critical = true
    already_notified_low = true
    makeSound()
    var note = newNotification("Critical battery level: " & $bat_level & "%", "Suspending in " & $timeout_suspension & " seconds", icon_level_critical)
    note.timeout = notification_timeout
    discard note.show()
    timeout timeout_suspension
    bat_status = readFile(bat_status_info_filename).strip
    if bat_status == $Status.Discharging:
      discard execCmd "systemctl suspend-then-hibernate"
  elif bat_status == $Status.Discharging and bat_level <= bat_level_low and not already_notified_low:
    already_notified_low = true
    makeSound()
    var note = newNotification("Low battery level: " & $bat_level & "%", "", icon_level_low)
    note.timeout = notification_timeout
    discard note.show()
  elif bat_status == $Status.Full:
    already_notified_critical = false
    already_notified_low      = false
    timeout timeout_round_full
  elif bat_status == $Status.Charging or bat_level > bat_level_low:
    already_notified_critical = false
    already_notified_low      = false
    timeout timeout_round_charging

