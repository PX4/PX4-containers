#
# PX4 ecl build and test development environment
#

FROM px4io/px4-dev-base-bionic:2019-06-02
LABEL maintainer="Daniel Agar <daniel@agar.ca>"

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y --quiet --no-install-recommends install \
		python3-dev \
		python3-pip \
		python3-setuptools \
		swig3.0 \
	&& apt-get -y --quiet --no-install-recommends install --reinstall python3-requests \
	&& python3 -m pip uninstall pip && apt-get -y --quiet install --reinstall python3-pip  \
	&& apt-get -y autoremove \
	&& apt-get clean autoclean \
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/* \
	# python requirements
	&& wget -q https://raw.githubusercontent.com/PX4/ecl/master/EKF/tests/pytest/requirements.txt \
	&& pip3 install -r requirements.txt && rm -rf requirements.txt
