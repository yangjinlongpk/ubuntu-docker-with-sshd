FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y vim wget curl openssh-server openssl supervisor
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication no/g' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTmRn2jUguS4uRBFNR8vOCwLh5FBjW5uQHCJQEV3vMv ed25519 pipidocker" >> /root/.ssh/authorized_keys

RUN touch /etc/supervisor/conf.d/sshd.conf
RUN echo "[program:SSHD]" >> /etc/supervisor/conf.d/sshd.conf
RUN echo "command=/usr/sbin/sshd -D" >> /etc/supervisor/conf.d/sshd.conf
RUN echo "autostart=true" >> /etc/supervisor/conf.d/sshd.conf
RUN echo "autorestart=true" >> /etc/supervisor/conf.d/sshd.conf
RUN echo "user=root" >> /etc/supervisor/conf.d/sshd.conf

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
