# Jekyll hosting using docker

This project is a Jekyll static site hosting server using docker.
It is a Dockerized implementation of
[this](http://jekyllrb.com/docs/deployment-methods/#git-post-receive-hook)
deployment method, described on Jekyll documentation.

The Dockerfile will create an image which is both an nginx server and
a bare git repository.


# How to use

- Clone this repository.
- Create a pair of SSH keys. Your public key should be named id_rsa.pub and
must exist in the same directory with Dockerfile.
- Build the image with the following command:

```
  docker build -t static_site_hosting_docker .
```

- If the image was built succesully, start a container from that image:


```
  docker run -d static_site_hosting_docker
  
```

- Add an entry in your ```~/.ssh/config``` file to use the matching private
key for the container's IP. Something like this should do the trick (replace
with the path of the private key and the container's IP):


```
  Host the_containers_ip_goes_here
  User root
  Port 22
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes
```

- Now go to your Jekyll site repo and add the container as a remote:


```
  git remote add deploy root@the_containers_ip_goes_here:/site_repo.git
```

- You should now be able to push the repo to the container. The container
should build the static site and host it. Check if everything worked correctly
by visiting the container's IP on the browser.

