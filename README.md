# ubuntu-docker-with-sshd
> this is a Dockerfile to build an image depend on ubuntu 18.04 with ssh running, so you can login into the container from outside.

> the container login with secret key file, instead of password.
1. save Dockerfile in your directory
2. ```docker build -t "image name":"image tag"```
3. ```docker run -v /home/:/home/ --name "container name" --restart always -d "image name":"image tag"```
4. ```wget -O ssh-docker.key https://gist.githubusercontent.com/yangjinlongpk/8639a318744ab486d0df6193cc2d9491/raw/ae90f2ad74f63a74179d305c6cd409e1b93bc14c/ssh-docker```
or ```curl -o ssh-docker.key https://gist.githubusercontent.com/yangjinlongpk/8639a318744ab486d0df6193cc2d9491/raw/ae90f2ad74f63a74179d305c6cd409e1b93bc14c/ssh-docker```
5. ```chmod 400 ssh-docker.key```
6. ```ssh -i ssh-docker.key root@ip```
