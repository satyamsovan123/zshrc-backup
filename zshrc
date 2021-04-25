
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/userName/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/userName/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/userName/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/userName/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda deactivate

clear 

#ASCII ARTS
SOURCE_DIR=ascii-arts
files=(
   "$SOURCE_DIR"/*.txt
)
length=${#files[@]}

random_no=$(($RANDOM%length))
# echo $random_no
random_file=${files[random_no]}
# echo $random_file

# file_name=logo${random_no}.txt
# echo $file_name

input="ascii-arts/logo2.txt"
twidth=$(tput cols)
indent=$(awk -v twidth=$twidth '    {
                                     w=length();
                                     if (w > fwidth) fwidth=w;
                                    }
                                END {
                                     indent=int((twidth-fwidth)/2);
                                     print (indent > 0 ? indent : 0);
                                    }' < "$input")
awk -v indent=$indent '{ printf("%*s", indent, " "); print; }' < "$input"

notebook(){
  conda activate
  jupyter notebook
  conda deactivate
}

autoload -U colors && colors

right="[%D{%f/%m/%y} | %@]"
spaces="$(( $(tput cols) - ${#left} - ${#right} ))"

# PS1=$'\e[1;36m%(?.✔.✘) %# %n\e[m \e[0;35m➔\e[m '
PS1=$'%(?.\e[1;34m✔\e[m.\e[1;39m✘\e[m) \e[1;36m%# %n\e[m \e[0;35m➔\e[m '

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)               # Include hidden files.

# Load aliases and shortcuts if existent.
[ -f "$HOME/zsh/aliasrc" ] && source "$HOME/zsh/aliasrc"

#Sublime Shortcuts
alias subl_op="open -a Sublime\ Text.app"

subl() {
  if [[ -f "$FILE" ]]; then
    subl_op $1
  else
    touch $1
    subl_op $1
  fi
}
# alias subl_op="open -a Sublime\ Text.app"

#GitHub
# gitupload() {
#     git add .
#     git commit -m "$*"
#     git pull
#     git push
# }
# gitupdate() {
#     eval "$(ssh-agent -s)"
#     ssh-add ~/.ssh/github
#     ssh -T git@github.com
# }

#YouTube Downloader
youtube() {
  python3 /Users/userName/youtube-dl $1
}

#Makes a front end folder with required dependencies
frontend(){
  if [ $# -eq 0 ]
    then
      echo "Enter name for the repo"
    else
      cd ~/Desktop;
      mkdir $1;
      cd $1;
      touch index.html;
      cp ~/boiler-plate.html index.html;
      touch styles.css;
      touch index.js;
      open -a "Google Chrome" index.html;
      atom .

  fi
}

#exports MySQL
export PATH=${PATH}:/usr/local/mysql/bin
#automate mysql startup
rdb(){
  #mysql -u root -p
  mysql --user="userName" --password="password"
}

#exports MongoDB
export PATH=$PATH:/usr/local/mongodb/bin
#automate mongodb startup
nrdb(){
  mongod --dbpath /usr/local/mongodb/var --logpath /usr/local/mongodb/var/log/mongodb/mongo.log --fork
  mongo
}

#to automate sudo without entering password
#echo "password" | sudo -S ls

source ~/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null