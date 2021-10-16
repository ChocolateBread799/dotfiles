#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

# Resolution
xrandr --output DP-1 --mode 1920x1080 --rate 164.97 &

# Compositor
picom &

