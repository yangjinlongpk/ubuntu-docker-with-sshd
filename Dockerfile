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
RUN echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAgEAxtXN0fxe8ehVvYJGpT1Zv14VHcLYnKs1L/rz3292HV97Tvw/x7r4ehe9txn8GP6TKqxX2QK53u2HQZDRlvxTtayHd0NbUoj/EaJgKVrZLC1Y/Ygs/IbUXmlKoC3LpjcfcGP9wekJeHOwLprYOgTUPAyLeYdFN0uBldku7GaNrUuCB8xj/BrJyEHUKcQcR3+k+58lGIdsDh+hkGgz0b63iMhDKXwaWmPOYzHvnc0DgutBvdTNWJHn+eBZWNsrzt3nzqvJayaFgHhJSwdomGGoZ2rBad75u0Edcd2ZABq9lh8LRA+Ay6WJdieqiUDfDntKuyPIOalyhNPbvq1UnmMBVI7V4CKz09LEqm+MPkMWC8oFd1rblHsuagfkh6yqkHOCLVwAgcFKmIdHvvoBLwQFfiiqfL13ogBAxKzs9HKzX3QDMpVEoQ0TKf/kcM8/yBFBjYvZajW2HkIzcVHi7xIKXqp2QXysp/K8uY9p8dxiPIa9EpBZGsyibJ4MBVb7AWsVY0JCQFgGdmZff4xLZWL909U8R+dpklIl46Hu4Yo8S8BHpoGoCJyzsLLphwY0pIH2hwX0Mr699/RwUjJOygsP41+osdNzIewD3L+KLGZAPkfvK9/7sNwX21I27lZKqhfg3/3hNF1Byr4TmP3AoIZO20OV+aIj35EMPO2ZOTaBrrM= rsa 4096-031819" >> /root/.ssh/authorized_keys

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
