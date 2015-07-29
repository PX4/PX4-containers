#!/bin/bash
#
# Install video tools
# > Ubuntu setup
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

# Install gstreamer
sudo sh -c 'echo "deb http://ppa.launchpad.net/ddalex/gstreamer/ubuntu trusty main" > /etc/apt/sources.list.d/ddalex-gstreamer.list'
echo "-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.5
Comment: Hostname: keyserver.ubuntu.com

mQINBFROQeQBEADDiGVbWv7+7OTS3v7/g0tz1HvvUobmk5d/bio+6+vBb9gW2U7yklamq4tV
PZx1rwpu6vJ+sLapcxHKM50vh7yyplddu1WelsstFVivyM4GIiYrEKaJ0ntmrFQ4uT3H3Lpd
eph3u4D/wfCqn5X25G1o0H1PDjy5t+1ZYGkXPITCbI4Ha8vVP2ChsJ8uE/G2zJQ2tn4ZlrtZ
AEQA4c7r77/vAseevUCZfgfXihM/ep9D/MtD3/uRnlt9FULu5oJ+Bp7h3EUgQNGEuKOjy4FE
8MyfgoBkLbRTYY+/EXkB34qnGGaCnxqFGjQDZtbo8x6lRGy/5AN0qx2PrIJ/tqJOYPt3oRMo
JRZ/iXiLGnun3es4ptEC5wM2SzZNn8z7uVcKXtyw5a7yuBzatrOwnvp7Sc5i9pxth43kSNGu
67jMDeCvJp5CtZAXojBpmwoivZgczxB18hamZrG+x9dT0nDTRsBb3iMzeR2DPTAhfzftXUuO
QN0ervCSW7qfR0N0i4C7BzK896JYEjSjwjRsCbHI47DjB5eFn3kf+G1/yWo/eQAeyK+RSV2C
jdHVacTkR3TobHiKVQ1RnlknhxJO/F8fZzq+o2GDklZslE3QiIWpiItxVkR7Q+wdydSHx+je
epUSRLP/018cVXt+GVXIkSYG2zrgz0hJo0Ox30wfoDzsY/0JdwARAQABtBhMYXVuY2hwYWQg
UFBBIGZvciBkZGFsZXiJAjgEEwECACIFAlROQeQCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4B
AheAAAoJEBZuyDtLvI9/RMgQAKcOdttrFrAsbRhPpHtEmMk5Eg05MrlTcvCUTQdZah6lGHmg
jSDfvWeS8mMXDHJFxFfYnlzAog8I6Vf7pJ2vcETS6nnhRT7olNVMVCaAqCtzN5obpLJ/XeYh
vOh3pop0GRxpvxtVXTeywdZtECCDucqQikp/ymRGqrX3cVNUoZjmRXRDVusz0wjriN4TT4gc
511CCHxrc320qWZbWXI/JCp084Dah3exweF92s7/lfAuZJAckijTmtfk/Oh/mKw7rL/NyVwV
Z34gpL5iBMSp5LMWVP1qqutvCFF/0n2qE89mUCvK+lH1XDVxuHcxQyC8dgFCTPIdM9bHTF3x
ifFdR2VXh7xJd/LLG8RMhBhXZCsHIgGM7ceeq2BF/xADMAcBvbyIZDx7bmS5QJRd7TwZxc2U
nmVCa/LGcW46aPvlEfFDhlH0ugCkTldrTzBobvAQm9yu+miMu5u0+D606zwii57bsyjPlypk
GdV2CnkNKKudsiIkcEs9tFD57J5yHqj4NY8Pi1Btai1DFGak47pvMsEEJG1z6hoo9f1UInTG
z12jEegMmvlVWpsiI/8gaIXkOgMhdzrdWbS/Fudc0+iX94tUA5lDyJPH5hFKDTbl/69Ikzhu
WQT5KkEjhqyVqbQMN2BWPq1IY5orNQnAdi8TH4d0IMh/8jZT4VyLzMbQQ5UR
=X2eW
-----END PGP PUBLIC KEY BLOCK-----" | sudo apt-key add -;

sudo apt-get update
sudo apt-get -y install gstreamer1.0* libmjpegutils-2.1-0 libmpeg2encpp-2.1-0 libmplex2-2.1-0 libnettle4

# Install v4l tools for C920 support
sudo apt-get -y install libv4l-dev v4l-utils
