FROM nginx:1.14.0 as base

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /opt && \
    find / -type d -iname "nginx" -exec cp -a --parents {} /opt \; && \
    cp -a /usr/sbin/nginx /opt/. && \
    mkdir -p /opt/lib && \
    cp -a /lib/x86_64-linux-gnu/libpcre.so.* /opt/lib/. && \
    cp -a /lib/x86_64-linux-gnu/libz.so.* /opt/lib/.

FROM gcr.io/distroless/base

COPY --from=base /opt /

EXPOSE 80

CMD ["/nginx", "-g", "daemon off;"]
