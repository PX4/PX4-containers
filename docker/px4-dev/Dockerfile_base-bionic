#
# PX4 base development environment
#

FROM ubuntu:18.04
LABEL maintainer="Daniel Agar <daniel@agar.ca>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y --quiet --no-install-recommends install \
		bzip2 \
		ca-certificates \
		ccache \
		cmake \
		cppcheck \
		curl \
		dirmngr \
		doxygen \
		file \
		g++ \
		gcc \
		gdb \
		git \
		gnupg \
		gosu \
		lcov \
		libfreetype6-dev \
		libgtest-dev \
		libpng-dev \
		lsb-release \
		make \
		ninja-build \
		openjdk-8-jdk \
		openjdk-8-jre \
		openssh-client \
		pkg-config \
		python-pip \
		python-pygments \
		python-setuptools \
		rsync \
		shellcheck \
		tzdata \
		unzip \
		wget \
		xsltproc \
		zip \
	&& apt-get -y autoremove \
	&& apt-get clean autoclean \
	&& rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

# gtest
RUN cd /usr/src/gtest \
	&& mkdir build && cd build \
	&& cmake .. && make \
	&& cp *.a /usr/lib \
	&& cd .. && rm -rf build

RUN python -m pip install --upgrade pip \
	&& pip install setuptools pkgconfig wheel \
	&& pip install argparse argcomplete coverage jinja2 empy numpy requests serial toml pyyaml cerberus

# manual ccache setup
RUN ln -s /usr/bin/ccache /usr/lib/ccache/cc \
	&& ln -s /usr/bin/ccache /usr/lib/ccache/c++

# astyle v2.06
RUN wget -q https://downloads.sourceforge.net/project/astyle/astyle/astyle%202.06/astyle_2.06_linux.tar.gz -O /tmp/astyle.tar.gz \
	&& cd /tmp && tar zxf astyle.tar.gz && cd astyle/src \
	&& make -f ../build/gcc/Makefile && cp bin/astyle /usr/local/bin \
	&& rm -rf /tmp/*

# Gradle (Required to build Fast-RTPS)
RUN wget -q "https://services.gradle.org/distributions/gradle-5.4.1-bin.zip" -O /tmp/gradle-5.4.1-bin.zip \
	&& mkdir /opt/gradle \
	&& cd /tmp \
	&& unzip -d /opt/gradle gradle-5.4.1-bin.zip \
	&& rm -rf /tmp/*

ENV PATH "/opt/gradle/gradle-5.4.1/bin:$PATH"

# Fast-RTPS
RUN git clone --recursive https://github.com/eProsima/Fast-RTPS.git -b release/1.7.2 /tmp/Fast-RTPS-1.7.2 \
	&& cd /tmp/Fast-RTPS-1.7.2 \
	&& mkdir build && cd build \
	&& cmake -DTHIRDPARTY=ON -DBUILD_JAVA=ON .. \
	&& make && make install \
	&& rm -rf /tmp/*

# create user with id 1001 (jenkins docker workflow default)
RUN useradd --shell /bin/bash -u 1001 -c "" -m user && usermod -a -G dialout user

# setup virtual X server
RUN mkdir /tmp/.X11-unix && \
	chmod 1777 /tmp/.X11-unix && \
	chown -R root:root /tmp/.X11-unix
ENV DISPLAY :99

ENV CCACHE_UMASK=000
ENV FASTRTPSGEN_DIR="/usr/local/bin/"
ENV PATH="/usr/lib/ccache:$PATH"
ENV TERM=xterm
ENV TZ=UTC

# SITL UDP PORTS
EXPOSE 14556/udp
EXPOSE 14557/udp

# create and start as LOCAL_USER_ID
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
