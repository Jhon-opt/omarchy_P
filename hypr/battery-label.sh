#!/bin/bash
b=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
s=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)
if [ -z "$b" ]; then
    echo "<span foreground='#ffffff'>Sin batería</span>"
    exit
fi
if [ "$s" = "Charging" ] || [ "$s" = "Full" ]; then
    if [ "$s" = "Full" ]; then
        echo "<span foreground='#82FB9C'>⚡ 100% · Llena</span>"
    else
        echo "<span foreground='#82FB9C'>⚡ $b% · Cargando</span>"
    fi
    exit
fi
if [ "$b" -ge 80 ]; then
    icon=
elif [ "$b" -ge 60 ]; then
    icon=
elif [ "$b" -ge 40 ]; then
    icon=
elif [ "$b" -ge 20 ]; then
    icon=
else
    icon=
fi
if [ "$b" -ge 50 ]; then
    echo "<span foreground='#ffffff'>$icon $b%</span>"
elif [ "$b" -ge 20 ]; then
    echo "<span foreground='#ffd166'>$icon $b%</span>"
else
    echo "<span foreground='#ff5555'>$icon $b% · ¡Cargar!</span>"
fi