FROM nginx
ADD start.sh /start.sh
RUN chmod +x /start.sh

RUN apt-get update
RUN apt-get install -y openssh-server git make gcc
RUN apt-get install -y rubygems
RUN apt-get install -y ruby-dev
RUN gem install jekyll

RUN mkdir /root/.ssh
ADD id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 700 /root/.ssh
RUN chmod 644 /root/.ssh/id_rsa.pub
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

RUN mkdir /site_repo.git
WORKDIR "/site_repo.git"
RUN git --bare init
ADD post-receive /site_repo.git/hooks/post-receive

EXPOSE 80 443 22

CMD ["/start.sh"]


