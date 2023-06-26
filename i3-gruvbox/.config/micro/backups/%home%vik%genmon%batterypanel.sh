#!/usr/bin/env bash

#genmon script for the battery icon
readonly DIR="/home/vik/.icons"
readonly ICON_0="${DIR}/Fluent-dark/symbolic/status/battery-caution-symbolic.svg"
readonly ICON_1="${DIR}/Fluent-dark/symbolic/status/battery-level-20-symbolic.svg"
readonly ICON_2="${DIR}/Fluent-dark/symbolic/status/battery-level-50-symbolic.svg"
readonly ICON_3="${DIR}/Fluent-dark/symbolic/status/battery-level-70-symbolic.svg"
readonly ICON_4="${DIR}/Fluent-dark/symbolic/status/battery-full-symbolic.svg"
readonly ICON_5="${DIR}/Fluent-dark/symbolic/status/battery-empty-charging-symbolic.svg"
readonly ICON_6="${DIR}/Fluent-dark/symbolic/status/battery-low-charging-symbolic.svg"
readonly ICON_7="${DIR}/Fluent-dark/symbolic/status/battery-medium-charging-symbolic.svg"
readonly ICON_8="${DIR}/Fluent-dark/symbolic/status/battery-level-70-charging-symbolic.svg"
readonly ICON_9="${DIR}/Fluent-dark/symbolic/status/battery-full-charging-symbolic.svg"

readonly VOLTAGE=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/voltage_now)
readonly BATTERY=$(awk '{print $1}' /sys/class/power_supply/BAT*/capacity)
readonly TIME_UNTIL=$(acpi | awk '{print $5}' | awk 'NR==2')

#Set your custom low_battery level
LOW_BATTERY=15;

if acpi -a | grep -i "off-line" &> /dev/null; then                   # if AC adapter is online
  INFO=
    if [ "${BATTERY}" -lt "${LOW_BATTERY}" ]; then                  # battery is too low ; don't make me appear ; charge it before reaching this condition
        batteryIcon="<img>${ICON_0}</img>"
    elif [ "${BATTERY}" -ge 15 ] && [ "${BATTERY}" -lt 45 ]; then   # if battery is charged between 25 and 50
        batteryIcon="<img>${ICON_1}</img>"
    elif [ "${BATTERY}" -ge 45 ] && [ "${BATTERY}" -lt 60 ]; then   # if battery is half charged
        batteryIcon="<img>${ICON_2}</img>"
    elif [ "${BATTERY}" -ge 60 ] && [ "${BATTERY}" -lt 90 ]; then   # if battery is charged more than 60%
        batteryIcon="<img>${ICON_3}</img>"
    else                                                            # if battery is full charged
        batteryIcon="<img>${ICON_4}</img>"
    fi
else
  INFO=
    if [ "${BATTERY}" -lt "${LOW_BATTERY}" ]; then                  # battery is too low ; don't make me appear ; charge it before reaching this condition
        batteryIcon="<img>${ICON_5}</img>"
    elif [ "${BATTERY}" -ge 15 ] && [ "${BATTERY}" -lt 45 ]; then   # if battery is charged between 25 and 50
        batteryIcon="<img>${ICON_6}</img>"
    elif [ "${BATTERY}" -ge 45 ] && [ "${BATTERY}" -lt 60 ]; then   # if battery is half charged
        batteryIcon="<img>${ICON_7}</img>"
    elif [ "${BATTERY}" -ge 60 ] && [ "${BATTERY}" -lt 90 ]; then   # if battery is charged more than 60%
        batteryIcon="<img>${ICON_8}</img>"
    else                                                            # if battery is full charged
        batteryIcon="<img>${ICON_9}</img>"
    fi
fi

INFO+="${batteryIcon} "
if hash xfce4-power-manager-settings &> /dev/null; then
  INFO+="<click>xfce4-power-manager-settings</click>"     # clicking on the icon opens XFCE power manager
fi

# INFO+="<txt>"
# INFO+="<span weight='Regular' fgcolor='#fbf1c7'>"
# INFO+="${BATTERY}%"
# INFO+="</span>"
# INFO+="</txt>"

# Tooltip
MORE_INFO="<tool>"

if acpi -a | grep -i "off-line" &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else
    MORE_INFO+="└─ Remaining Time: ${TIME_UNTIL}"      # shows the remaining time on battery
  fi
elif acpi -a | grep -i "on-line" &> /dev/null; then # if AC adapter is online
  if [ "${BATTERY}" -eq 100 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else 
    MORE_INFO+="└─ Time to fully charge: ${TIME_UNTIL}"    # shows remaining time to charge
  fi
else # if battery is in unknown state (no battery at all, throttling, etc.)
  MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
fi
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
