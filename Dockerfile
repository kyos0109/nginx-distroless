FROM nginx:1.14.0 as base

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /opt/lib && \
    find / -type d -iname "nginx" -exec cp -a --parents {} /opt \; && \
    cp -a /usr/sbin/nginx /opt/. && \
    cp -a --parents /lib/x86_64-linux-gnu/libpcre.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libz.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libc.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libdl.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libpthread.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libcrypt.so.* /opt && \
    cp -a --parents /usr/lib/x86_64-linux-gnu/libssl.so.* /opt && \
    cp -a --parents /usr/lib/x86_64-linux-gnu/libcrypto.so.* /opt

FROM gcr.io/distroless/base

COPY --from=base /opt /

EXPOSE 80

ENTRYPOINT ["/nginx", "-g", "daemon off;"]