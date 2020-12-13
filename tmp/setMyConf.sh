#/bin/sh -c


cd $(cd $(dirname $0) && pwd)

alias cp="/bin/cp -f"

#alias ln="/bin/ln -s"
#alias ln="/bin/ln"

#ln -s ../bashrc ~/.bashrc
#ln -s ../gitignore ~/.gitignore
#ln -s ../vimrc ~/.vimrc
#ln -s ../zshrc ~/.zshrc
#ln -s ../config.fish ~/.config/fish/config.fish
#ln -s ../tmux.conf ~/.tmux.conf

mkdir -p ~/.config/fish/
mkdir -p ~/.config/nvim/rc
mkdir -p ~/.config/nvim/dein
mkdir -p ~/.config/git
mkdir -p ~/.ssh


cp ../bashrc ~/.bashrc
cp ../gitignore ~/.config/git/ignore
cp ../gitignore ../.gitignore
cp ../vimrc ~/.vimrc
cp ../zshrc ~/.zshrc
cp ../config.fish ~/.config/fish/config.fish
cp ../tmux.conf ~/.tmux.conf

cp ../ssh/config ~/.ssh/config
chmod 600 ~/.ssh/config

cp -r ../nvim/* ~/.config/nvim

#source ~/.zshrc
#echo "reload .zshrc"
tmux source-file ~/.tmux.conf
echo "reload .tmux.conf"
