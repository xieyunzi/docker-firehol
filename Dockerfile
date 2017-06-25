FROM buildpack-deps:stretch

RUN echo "\
deb http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free\n\
deb-src http://mirrors.ustc.edu.cn/debian/ stretch main contrib non-free\n\
\n\
deb http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free\n\
deb-src http://mirrors.ustc.edu.cn/debian/ stretch-updates main contrib non-free\n\
\n\
deb http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free\n\
deb-src http://mirrors.ustc.edu.cn/debian-security/ stretch/updates main contrib non-free\n\
" > /etc/apt/sources.list

RUN apt update
RUN yes | apt install kmod libxml2-utils iptables iprange traceroute ipset

WORKDIR /code/firehol
RUN git clone --depth 1 https://github.com/firehol/firehol .
RUN ./autogen.sh &&\
    ./configure --disable-doc --disable-man &&\
    make &&\
    make install

CMD ["/bin/bash"]
