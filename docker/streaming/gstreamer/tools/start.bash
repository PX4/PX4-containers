#!/bin/bash
# don't quit on errors, v4l or vcgencmd might exit > 0 which is sometimes expected
set +e

WIDTH=1920
HEIGHT=1080
FPS=24
BITRATE=2000000
TARGET_HOST=
TARGET_PORT=
DEV=

if [ $# -eq 6 ] || [ $# -eq 7 ]; then
	TARGET_HOST=$1
	TARGET_PORT=$2
	WIDTH=$3
	HEIGHT=$4
	FPS=$5
	BITRATE=$6

	if [ $# -eq 7 ]; then
		DEV=$7
	fi
elif [ $# -eq 2 ]; then
	TARGET_HOST=$1
	TARGET_PORT=$2
else
	echo "Require at least 2 arguments: TARGET_HOST TARGET_PORT"
	echo "This will stream with default settings (1920x1080, 24 fps, 2000000 bit/s)."
	echo "Specify stream parameters: TARGET_HOST TARGET_PORT WIDTH HEIGHT FPS BITRATE [VIDEO_DEVICE]"
	echo "Use VIDEO_DEVICE to specify a V4L device to use if needed. Or specify 'RPI' to force checking for RPI camera."
	exit 1
fi

# Check for V4L device (C920)
if [ -z "$DEV" ]; then
	DEV=/dev/video0
fi
if [ -e "$DEV" ] && [ "$DEV" != "RPI" ]; then
	v4l2-ctl -d $DEV --set-fmt-video=width=$WIDTH,height=$HEIGHT,pixelformat=1
	v4l2-ctl -d $DEV --set-parm=$FPS
	# C920 settings best for flying
	v4l2-ctl -d $DEV --set-ctrl=exposure_auto=3 # auto
	v4l2-ctl -d $DEV --set-ctrl=focus_auto=0 # manual
	v4l2-ctl -d $DEV --set-ctrl=focus_absolute=0 # infinite
	exec gst-launch-1.0 uvch264src initial-bitrate=$BITRATE average-bitrate=$BITRATE iframe-period=1000 device=$DEV name=src auto-start=true src.vidsrc ! video/x-h264,width=$WIDTH,height=$HEIGHT,framerate=$FPS/1 ! h264parse ! rtph264pay ! udpsink host=$TARGET_HOST port=$TARGET_PORT
elif [ ! -e "$DEV" ] && [ "$DEV" != "RPI" ]; then
	echo "Info: V4L device $DEV not found"
fi

# Check for RPI camera
string=$(vcgencmd get_camera)
substring="detected=1"
if [ "${string#*$substring}" != "$string" ]; then
	exec raspivid -t 0 -h $HEIGHT -w $WIDTH -fps $FPS -b $BITRATE -o - | gst-launch-1.0 -v fdsrc ! h264parse ! rtph264pay ! udpsink host=$TARGET_HOST port=$TARGET_PORT
else
	echo "Info: RPI camera not found"
fi


echo No camera detected
exit 1
