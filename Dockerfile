# Reproduction package project for Reproduction Engenieering lecture
# JSON Schema Discovery Reproduction

FROM ubuntu:20.04

MAINTAINER Ilnaz Tayebi <tayebi01@ads.uni-passau.de>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

#ca-certificates allow git clone access
#npm #Node Package Manager
RUN apt update && apt install -y --no-install-recommends \
	ca-certificates \
	git \
	# texlive-base \
	# texlive-bibtex-extra \
	# texlive-fonts-recommended \
	# texlive-generic-extra \
	# texlive-latex-extra \
	# texlive-publishers\
	sudo

# Install Mongodb
# Import MongoDB public GPG key AND create a MongoDB list file
# RUN apt-get update && apt-get install -y gnupg
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
# RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
# Update apt-get sources AND install MongoDB
# RUN apt-get update && apt-get install -y mongodb
# RUN mkdir -p /data/db
#  EXPOSE 27017
#  ENTRYPOINT ["/usr/bin/mongod"]

# Install Node.js
# RUN apt update
# RUN printf 'y\n1\n\1n' | apt install nodejs
#####************************************
# RUN apt-get update && \
#  apt-get install -y \
#     nodejs npm

RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
 apt-get install -y nodejs \
    nodejs npm
# Prepare directory structure
## git-repos/       - for external git repositories
## build/           - temporary directory for out-of-tree builds
## bin/             - for generated binary executables
RUN mkdir -p $HOME/git-repos $HOME/build $HOME/bin

# Obtain JSONSchemaDiscovery sources from a git repository
WORKDIR /home/repro/git-repos
RUN git clone https://github.com/gbd-ufsc/JSONSchemaDiscovery.git
WORKDIR /home/repro/git-repos/JSONSchemaDiscovery

# # Setting up development environment:
# ##Install global dependencies:
# ## Angular CLI **npm install -g @angular/cli
# ## Typescript **npm install -g typescript
# # install and cache app dependencies

RUN apt install -y npm
RUN npm install -g @angular/cli
RUN npm install -g typescript
RUN npm install
RUN ng build
EXPOSE 3000
#RUN npm run dev
# CMD ["npm","start"]


