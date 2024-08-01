#!/bin/sh
set -e

echo "Activating feature 'p10k'"

CONFIG='./.p10k.zsh'
PLUGINS=${PLUGINS:-undefined}

# The 'install.sh' entrypoint script is always executed as the root user.
#
# These following environment variables are passed in by the dev container CLI.
# These may be useful in instances where the context of the final 
# remoteUser or containerUser is useful.
# For more details, see https://containers.dev/implementors/features#user-env-var
echo "The effective dev container remoteUser is '$_REMOTE_USER'"
echo "The effective dev container remoteUser's home directory is '$_REMOTE_USER_HOME'"

echo "The effective dev container containerUser is '$_CONTAINER_USER'"
echo "The effective dev container containerUser's home directory is '$_CONTAINER_USER_HOME'"

chsh -s $(which zsh)
apt-get update && apt-get install -y fonts-powerline
ZSH_CUSTOM=${ZSH_CUSTOM:-$_REMOTE_USER_HOME/.oh-my-zsh/custom}
ZSHRC=$_REMOTE_USER_HOME/.zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/zsh-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git $_REMOTE_USER_HOME/.fzf
$_REMOTE_USER_HOME/.fzf/install
echo "source $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $ZSHRC
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
sed -i -E 's/^(ZSH_THEME)="(.+)"/\1="powerlevel10k\/powerlevel10k"/' $ZSHRC
sed -i -E "s/^(plugins)=(.+)/\1=(${PLUGINS})/" $ZSHRC
P10K_ZSH=$_REMOTE_USER_HOME/.p10k.zsh
cp $CONFIG $P10K_ZSH
echo "[[ ! -f $P10K_ZSH ]] || source $P10K_ZSH" >> $ZSHRC