FROM ubuntu

WORKDIR /home/shu
ENV ZDOTDIR /home/shu
ENV HOME /home/shu
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && apt install -y wget curl zsh tmux make git-all exuberant-ctags fzf locales language-pack-en
RUN locale-gen en_US.UTF-8

RUN curl -o- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash && \
  curl https://gist.githubusercontent.com/yoshioka-s/d834fd2ebac0286aae7c145c31b6e05b/raw/43d6befda0a55127902c0e1993e88354606e3315/.zshrc >> /home/shu/.zshrc

RUN git clone https://github.com/gpakosz/.tmux.git && \
  ln -s -f .tmux/.tmux.conf && \
  cp .tmux/.tmux.conf.local .
 
RUN wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && tar xzvf nvim-linux64.tar.gz && \
  echo "alias vi='/home/shu/nvim-linux64/bin/nvim'\n" >> /home/shu/.zshrc && \
  rm nvim-linux64.tar.gz

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
  tar xf lazygit.tar.gz lazygit && \
  install lazygit /usr/local/bin && \
  rm lazygit.tar.gz

RUN curl https://gist.githubusercontent.com/yoshioka-s/9b29158baf049258b128dcb589860659/raw/e282fd978432109996a412c11b44ab7ccf7095b1/gistfile1.txt >> .tmux.conf.local
RUN git clone https://github.com/yoshioka-s/nvim.git /home/shu/.config

RUN curl https://gist.githubusercontent.com/yoshioka-s/8029e38077ce31abf512a8d7c9c41576/raw/4d6782d303e5a8ee4d5e54f01e7f3916bba1b28f/gistfile1.txt >> ~/.gitconfig

RUN /bin/zsh /home/shu/.zshrc
