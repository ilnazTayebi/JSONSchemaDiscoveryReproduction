# Reproduction package project for Reproduction Engenieering lecture
# JSON Schema Discovery Reproduction

FROM ubuntu:22.04

MAINTAINER Ilnaz Tayebi <tayebi01@ads.uni-passau.de>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"
ENV PYTHON=/usr/bin/python2.7

RUN apt update && apt install -y \
	ca-certificates \
	git \
	curl \
	python2.7 \
	r-cran-ggplot2 \
	r-cran-reshape2 \
	r-cran-knitr 
	# sudo\
	# texlive-base 
	# texlive-bibtex-extra \
	# texlive-fonts-recommended \
	# texlive-generic-extra \
	# texlive-latex-extra \
	# texlive-publishers



# Install Node.js
# RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
#	apt-get install -y nodejs=6.11.2

RUN mkdir -p /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
# IMPORTANT: set the exact version
ENV NODE_VERSION v6.11.2
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
# add node and npm to the PATH
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH
RUN npm -v
RUN node -v

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
RUN npm install -g node-gyp@3.8.0
RUN npm install
RUN npm install -g @angular/cli@1.4.3
RUN npm install -g typescript@2.3.3
RUN ng build
EXPOSE 4200
CMD [ "ng", "serve" ]

