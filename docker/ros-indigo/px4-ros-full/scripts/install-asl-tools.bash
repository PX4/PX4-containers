#!/bin/bash
#
# Install python tools used by demo and test scripts
#
# License: according to LICENSE.md in the root directory of the PX4 Firmware repository

# Prepare for automatic execution (not necessary if you execute the commands manually one by one)
set -e
export DEBIAN_FRONTEND=noninteractive

sudo sh -c 'echo "deb http://ppa.launchpad.net/ethz-asl/ros/ubuntu trusty main" > /etc/apt/sources.list.d/asl-ros.list'
echo "-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.5
Comment: Hostname: keyserver.ubuntu.com

mQINBFSRStEBEAC0t4gIO5YslqQ+zOveOMPmzW/VXTxgP3jDFu1P6Egv7vdOiAW2/0NkZ8uJ
OXHVKxx3Fv/jjNVX9fXi54fZ0/bl03UdvpaG5lhJbyvPrJEZgf7yADGlmM74vJ+ugvJTQpwK
f3YQGfQhnpfa3GgW31hl1LRm4SCh2noBjF+7XLwUdLNz/Og+ZwgwXMHURGlZhJCJRUghBbJd
siAQQ5/8Fqrwi0v+L2iyQpEun0QPaLG9ivGHdXTbucThoyAUVwAvmb1bbtnNfW8VwTKd7+xZ
zAch5rgYfvtfxTHvTv/jNPhylACCiUyK6TcaLqj0eILjXYowjFBiF/IOapUo2IQJq/b+xS/i
w49oLJp8azY9qQfkN3Ts2gxjWkSJAf75S2J3ANbXmDdGDkNnte01wTH//UF1FI1dsbk75kRu
Xz/UrTnmn94MvVysg7YYVS1Wemj2Lb9JfDF6+2nsYbYZ3ibnv9D3LiWZ6e0YpnovMKN6fcy3
QtGFeyUYqyLbrMK/V+5TJL/YHF+NYqnbCS9lB+fUdENOBwQXV4R8VAOZEz/y1+nJRMqJ8g1y
WnK0k2vtvbXIZjHuCxoN0YaNCBPXFohRfqNwnpzCi8x+d8Ka+deohZu/eP5VvyJvboXa0PPP
7vs4vE8xEvrzPDWycTL8UqC0c7/L/9KbkL054wvsOlic9A1bXwARAQABtBpMYXVuY2hwYWQg
UFBBIGZvciBFVEhaIEFTTIkCOAQTAQIAIgUCVJFK0QIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
HgECF4AACgkQ6plhO8/MDmz6WA//eb6kjw/aJGkTvSTJIevFZ4zMfMNLIsrhnFoQr6ClXmCr
2KFVEExGZZBa3QgOeGqhallT/0awyg4j/rGUUduol3RiCpB5BoKrDxC14JcOA7mE2im8vkYF
SR4IPYQZu83vOvO53AK8WV+ytFYJ3fDn2wrd28FkCk2BNUN86IaENDJyixDRcu+8AM1U1qPY
YcJd0/C2UTPqfeC4kX4Ehwgeenn1ekyKpR8mVzLzgx44DXFkS2sLWVXylREsL3bp5VqWduH3
PqkKqhIW2o2T1Npbix9/c1G+BSL720YO9Aee00SznjBul7zDXu6wL7DC5c6U+Nkf1VNAQpPI
kBTVlz1S+UAstyurq7nJ+RZ9AuksRVSptVgJTk2whZFC9MpiK8ExWiTnZXKizEuxjr1Zzu41
DBU1iubPFthqyPP+43Li5RlNxTbNPrAfqfxJ1tvoDhaSpo9Czs0H0aUyk4hHqh02yR9IdkBj
Hb3EdmuMekb89zrIn8xd4k4+7ct2kQUQM7Sy8ai8mZjPfWwJ0elDT8mjN7Eh7RO2L9unBmkC
uoohRAog67KCsCRHYcy2j8lAphQfQKuJanACOWUvgHGb7PO8KPOYlerklPdlFeJMS1cdqMKG
t43A1RL24EA9jPG+KGP730aGs3XQCrPC0I07UB4bqQcu9xjHEQX02fky08WqN5I=
=ptQO
-----END PGP PUBLIC KEY BLOCK-----" | sudo apt-key add -;

sudo apt-get install ros-indigo-system-monitor
