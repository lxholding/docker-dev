FROM lxholding/linux
MAINTAINER lixin "lxholding@163.com"

ADD nginx.conf vhosts tengine-2.2.0.tar.gz jemalloc-3.6.0.tar.bz2 ngx_log_if.tar.gz /root/tmp/

RUN adduser -DHS -g www -s /sbin/nologin www
&& buildDeps='gcc g++ make autoconf automake' \
&& runDeps='pcre-dev openssl-dev' \
&& sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
&& apk add --no-cache --update-cache $buildDeps $runDeps \
&& cd /root/tmp/tengine-2.2.0 && ./configure --with-jemalloc=/root/tmp/jemalloc-3.6.0 --with-http_ssl_module --with-http_v2_module && make && make install && mv -f /root/tmp/nginx.conf /usr/local/nginx/ && mv /root/tmp/vhosts /usr/local/nginx/conf/ \
&& apk del --purge $buildDeps \
&& rm -rf /root/tmp

CMD ["/bin/sh"] 
