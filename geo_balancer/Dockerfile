FROM ubuntu:22.04

# Install dependencies
RUN apt update\
  && apt install -y software-properties-common\
  && add-apt-repository ppa:maxmind/ppa\
  && apt update\
  && apt install -y wget curl gcc make build-essential git libpcre3 libpcre3-dev zlib1g-dev libmaxminddb0 libmaxminddb-dev mmdb-bin libssl-dev

# Prepare Nginx modules
WORKDIR /tmp/openresty/modules
RUN git clone https://github.com/leev/ngx_http_geoip2_module.git

# Build Nginx from source
WORKDIR /tmp/openresty
RUN wget https://openresty.org/download/openresty-1.25.3.1.tar.gz\
  && tar -xvf openresty-1.25.3.1.tar.gz\
  && cd openresty-1.25.3.1\
  && ./configure --sbin-path=/usr/local/sbin --with-http_realip_module --add-module=/tmp/openresty/modules/ngx_http_geoip2_module\
  && make\
  && make install

# Cleanup temporary files
RUN rm -rf /tmp/openresty

# Add link to OPM 
RUN ln -s /usr/local/openresty/bin/opm /usr/local/bin/opm

# Install Lua health-checker
RUN opm get openresty/lua-resty-upstream-healthcheck

# Set build-time environment variables
ARG ACCOUNT_ID
ARG LICENSE_KEY

# Set up Maxmind GeoIP2
WORKDIR /var/lib/GeoIP/
RUN curl -J -L -u $ACCOUNT_ID:$LICENSE_KEY 'https://download.maxmind.com/geoip/databases/GeoLite2-Country/download?suffix=tar.gz' -o geodb.tar.gz\
  && tar -xvf geodb.tar.gz --strip-components=1\
  && rm geodb.tar.gz

ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD utils/ /usr/local/openresty/site/lualib/resty/utils/
