# bit.ly URL Shortener
# Dependencies:
# * BITLY_ACCESS_TOKEN
# * BITLY_USER_NAME
# * jq command
function bitly {

  short_url=$(curl -s --request GET \
    --url "https://api-ssl.bitly.com/v3/shorten?access_token=$BITLY_ACCESS_TOKEN&login=$BITLY_USER_NAME&longUrl=$@" \
    | jq -r .data.url ;)

  echo "URL Copied to Clipboard! :"
  echo $short_url;
  echo -n $short_url | pbcopy
}

# List of Makefile targets
function print_make_targets { cat Makefile|egrep "^.+: ?+"|egrep "^[a-z_]+:"|cut -d: -f1 ; }

# Git Ignore Request
function gi { curl -s https://www.gitignore.io/api/$@ ; }

# License file
# apache, artistic, cc0, eclipse, affero, gpl2, gpl3, lgpl2, lgpl3, isc, mit, mozilla, nbsd, unlicense, sbsd
function li { curl -s https://licensedownload.herokuapp.com/$@ ; }

# Rails i18n locale xx.yml
function lo { curl -s https://cdn.rawgit.com/svenfuchs/rails-i18n/master/rails/locale//$@.yml ;}

function heroku_app_name { git remote -v| grep heroku | head -n 1 | egrep -o "\w+-\w+-[0-9]+"; }

# Print some docker containers IP address
function printip {
 id="$*" # container id
 sudo docker container inspect $id |grep IPAddress|sed -e "s/^[ \t ]*\"IPAddress\":\s\"//g"|sed -e "s/\",$//g"
}

function mkcd {
 dir="$*";
 mkdir -p "$dir" && cd "$dir";
}

function mvcd {
  file_name="$1";
  file_path="$2";

  if [ $# -gt 2 ]; then
    echo 'Err: the parameter is too much.';
    return 1;
  fi
  mv "$file_name" "$file_path" && cd "$file_path";
}

function gitsb {
  exp="$*";

  git br|egrep $exp|cut -c 3-100|xargs git show-branch

}

function check_home_local_bin {
  DIR="$(env | sed 's/:/\n/g' | grep '$HOME/.local/bin' | head -n 1)"

  if [[ -z "$DIR" ]]; then
    echo "Please add '\$HOME/.local/bin' to your \$PATH"
  else
    # Nothing to do
    echo ''
  fi
}

function install_terraform {
  ARCH="linux_amd64"
  VERSION="${1:-0.11.7}"
  FILE_NAME="terraform_${VERSION}_$ARCH.zip"
  PREVIOUS_WORK_DIR="$(pwd)"

  URL="https://releases.hashicorp.com/terraform/$VERSION/$FILE_NAME"

  cd /tmp
  wget --quiet "$URL" -O "$FILE_NAME"
  unzip -fq "$FILE_NAME" -d ~/.local/bin
  cd $PREVIOUS_WORK_DIR

  check_home_local_bin
}

function update_terraform {
  # terraform knows own latest version
  VERSION="$(terraform -v | tail -n 1 | egrep -o '[0-9]{1,2}\.[0-9]{1,2}\.[0-9]{1,2}')"

  if [[ -z "$VERSION" ]]; then
    echo "Nothing to do."
  else
    install_terraform $VERSION
  fi
}

function switch_git_config {
  name=$1
  email=$2
  gpg_pub_sign=$3

  git config --global user.name $name
  git config --global user.email $email
  git config --global user.signingkey $gpg_pub_sign
  echo "Configuration has changed:"
  echo "git config user.name: $(git config user.name)"
  echo "git config user.email: $(git config user.email)"
  echo "git config user.signingkey: $(git config user.signingkey)"
}

function gouf {
  switch_git_config "gouf" "innocent.zero@gmail.com" "84CCC1E2F06E544C"
}

function git_whoami {
  git config user.name
  git config user.email
}

function init_plane_java_project {
  mkdir -p src/{main,test}/{resorces,java}
  touch src/{main,test}/{resorces,java}/.gitkeep
  gradle init
}

function wp_install {
  wp core download --path=$1;
  cd $1;
  read -p 'name the database:' dbname;
  wp config create --dbname=$dbname --dbuser=root --dbpass=root --dbhost=localhost;
  wp db create;
  wp core install --prompt
}

function github_today {
  hub compare $(git log --reverse --no-merges --branches=* --date=local --since=midnight --oneline --author="$(git config --get user.name)"|(head -n 1;tail -n 1)|cut -d\  -f 1|sed 'N;s/\n/\.\.\./' -)
}

function init_tachikoma_ruby {
  echo 'strategy: 'bundler'' > .tachikoma.yml
}

function ctags_javascript {
  ctags -R --languages=javascript --exclude=.git --exclude=log .
}

function ctags_ruby {
  ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)
}

function weather {
  curl "https://wttr.in/$1?lang=ja"
}

function cheat {
  curl "https://cheat.sh/$1"
}

function list_aws_regions {
  aws ec2 describe-regions | jq '.Regions[].RegionName' | cut -d\" -f2
}

function list_my_functions {
  cat ~/.bash_functions|grep function|cut -d\  -f2
}

peco-select-history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}
