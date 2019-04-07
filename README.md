# ubuntu-docker-with-sshd
> this is a Dockerfile to build an image depend on ubuntu 18.04 with ssh running, so you can login into the container from outside.

> the container login with secret key file, instead of password.
1. save Dockerfile in your directory
2. ```docker build -t {docker-image-name}:{docker-image-tag} .```
3. ```docker run -v /home/:/home/ --name {docker-container-name} --restart always -d {docker-image-name}:{docker-image-tag}```
4. ```curl -LSs https://raw.githubusercontent.com/yangjinlongpk/ubuntu-docker-with-sshd/master/sshkey > id_rsa_insecure```
5. ```chmod 400 id_rsa_insecure```
6. ```ssh -i id_rsa_insecure root@{docker-host-ip}```
