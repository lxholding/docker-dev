FROM lxholding/linux
MAINTAINER lixin "lxholding@163.com"

ADD nginx.conf dirs tengine-2.2.0.tar.gz jemalloc-3.6.0.tar.bz2 ngx_log_if.tar.gz /root/tmp/

RUN adduser -DHS -g www -s /sbin/nologin www \
&& buildDeps='gcc g++ make autoconf automake' \
&& runDeps='pcre-dev openssl-dev' \
&& apk update \
&& apk add $buildDeps $runDeps \
&& cd /root/tmp/tengine-2.2.0 && ./configure --with-jemalloc=/root/tmp/jemalloc-3.6.0 --with-http_ssl_module --with-http_v2_module \
&& make && make install \
&& /usr/local/nginx/sbin/dso_tool --add-module=/root/tmp/ngx_log_if \
&& mv -f /root/tmp/nginx.conf /usr/local/nginx/ && mv /root/tmp/vhosts /usr/local/nginx/conf/ \
&& apk del --purge $buildDeps && rm -rf /var/cache/apk/* \
&& rm -rf /root/tmp

EXPOSE 80

CMD ["/usr/local/nginx/sbin/nginx", "-g", "'daemom off;'"] 
