FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    ansible \
    sudo \
    && mkdir /var/run/sshd \
    && echo "root:root" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && apt-get clean

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]