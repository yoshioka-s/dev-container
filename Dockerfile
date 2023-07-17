FROM ubuntu

WORKDIR /home/shu
ENV ZDOTDIR /home/shu
ENV HOME /home/shu
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt install -y wget curl zsh tmux make git-all exuberant-ctags fzf locales language-pack-en software-properties-common ripgrep
RUN locale-gen en_US.UTF-8

RUN curl -o- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash && \
  curl https://gist.githubusercontent.com/yoshioka-s/d834fd2ebac0286aae7c145c31b6e05b/raw/a7e65bd857c509c7db89918956ee2960168fd594/.zshrc >> /home/shu/.zshrc

RUN git clone https://github.com/gpakosz/.tmux.git && \
  ln -s -f .tmux/.tmux.conf && \
  cp .tmux/.tmux.conf.local .
 
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && tar xzvf nvim-linux64.tar.gz && \
  rm nvim-linux64.tar.gz

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
  tar xf lazygit.tar.gz lazygit && \
  install lazygit /usr/local/bin && \
  rm lazygit.tar.gz

RUN curl https://gist.githubusercontent.com/yoshioka-s/9b29158baf049258b128dcb589860659/raw/e282fd978432109996a412c11b44ab7ccf7095b1/gistfile1.txt >> .tmux.conf.local
RUN git clone https://github.com/yoshioka-s/nvim.git /home/shu/.config

RUN curl https://gist.githubusercontent.com/yoshioka-s/8029e38077ce31abf512a8d7c9c41576/raw/4d6782d303e5a8ee4d5e54f01e7f3916bba1b28f/gistfile1.txt >> ~/.gitconfig

RUN gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
  apt-add-repository -y ppa:rael-gc/rvm && \
  apt update -y && \
  apt install -y rvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && cat /home/shu/.bashrc >> /home/shu/.zshrc

RUN /bin/zsh /home/shu/.zshrc
