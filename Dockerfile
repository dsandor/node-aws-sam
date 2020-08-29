FROM amazon/aws-cli:latest
# Set the version of node to use.
ENV NODE_VERSION 12.18.3
WORKDIR /root
ENV HOME /root
ENV NVM_DIR /root/.nvm
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules 
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:/home/linuxbrew/.linuxbrew/Homebrew/bin:$PATH

# install yarn yum repo
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg

RUN yum -y update \
	&& yum install -y git-core ca-certificates tar jq sudo which ruby perl-devel \
	&& yum groupinstall 'Development Tools' -y

RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -

RUN yum install -y yarn \
 && yum clean all \
 && rm -rf /var/cache/yum

RUN sh -c "$(curl -fsSL https://gist.githubusercontent.com/dsandor/741cd08bd22e7634134d05cdbe93af61/raw/b9014ad41eebdc24de8d5ce503b4e1f32eea4541/install.sh)"
RUN brew --version

RUN brew tap aws/tap && \
	brew install aws-sam-cli && \
	sam --version

RUN yum remove -y sudo which ruby perl-devel

# cleanup
RUN rm -rf /root/.cache && \
	rm -rf /home/linuxbrew/.linuxbrew/cache && \
	rm -rf /usr/src && \
	rm -rf /var/cache && \
	rm -rf /usr/share/man && \
	rm -rf /usr/share/doc && \
	rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew && \
	rm -rf /home/linuxbrew/.linuxbrew/Homebrew/Library/Homebrew/vendor



# # Install semantic release
RUN npm i -g semantic-release @semantic-release/changelog @semantic-release/gitlab @semantic-release/release-notes-generator @semantic-release/npm @semantic-release/exec

# # Dump version information
RUN echo "Node Version -------------> $(node -v)" \
	&& echo "NPM Version --------------> $(npm -v)" \
	&& echo "Semantic Release Version -> $(semantic-release --version)" \
	&& echo "SAM CLI -> $(sam --version)"
