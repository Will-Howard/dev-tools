echo "loading bash_profile"
export "PATH=/opt/homebrew/bin/:$PATH"
. ~/.nvm/nvm.sh

# path to code directory on CEA laptop
export CODE_PATH="~/Documents/code"
export FORUM_CRED_PATH="/Users/wh/Documents/code/ForumCredentials"
export FORUM_PATH="~/Documents/code/ForumMagnum"

alias gsafepull="git pull origin master --no-ff --no-commit"
alias gpull="git pull origin master"
alias gpush="git push origin -u HEAD"
alias gstat="git status"
alias glog="git log"
alias gdifffiles="git diff --name-only"
alias gdiff="git diff"
alias gdiffmaster="git fetch && gdiff origin/master"
alias gco="git checkout"
alias gcom="git commit -a -m"
alias ghardsquash="~/scripts/hardsquash.sh"
alias gdebug="git apply debug.diff"
alias gcleardebug="git fetch && gco origin/master .vscode/launch.json build.js packages/lesswrong/server/apolloServer.ts"
alias gforcelogin="git apply forcelogin.diff"
alias gclearforcelogin="git fetch && gco origin/master packages/lesswrong/components/users/UsersMenu.tsx packages/lesswrong/components/users/WrappedLoginForm.tsx packages/lesswrong/server/vulcan-lib/apollo-server/authentication.tsx"
function gcopaste {
  gco $(pbpaste) || gco -b $(pbpaste)
}
function gcpush {
    gcom $@ && gpush
}
function gpr() {
    branch_name=$1
    commit_message=$2

    # Switch to a new branch
    git switch -c $branch_name

    # Commit all tracked files
    git commit -a -m "$commit_message"

    # Push the branch to the remote
    git push -u origin $branch_name
}
# alias gcobranch="gco \`git branch -a | fzf\`" # simpler version of gcobranch
function gcobranch() {
  # Get the most recent branches with checkout time and swap the positions
  local recent_branches=$(git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | awk -F' ~ HEAD@{' '{printf("%s ~ %s\n", substr($2, 1, length($2)-1), $1)}' | awk -F' ~ ' '{printf("%s ~ (%s)\n", $2, $1)}')

  # Get all branches and remove the leading spaces or '*'
  local all_branches=$(git branch -a | sed 's/remotes\///' | sed 's/origin\///' | sed 's/^[ *]*//')

  # Remove the recent branches (without checkout time) from all branches
  local recent_branches_without_time=$(echo "$recent_branches" | awk -F' ~ ' '{print $1}')
  local other_branches=$(comm -23 <(echo "$all_branches" | sort) <(echo "$recent_branches_without_time" | sort))

  # Combine recent branches and other branches
  local combined_branches=$(echo -e "${recent_branches}\n${other_branches}")

  # Use fzf for interactive selection
  local selected_branch=$(echo "$combined_branches" | fzf)

  # Extract the branch name if it includes checkout time
  if [[ "$selected_branch" == *"~"* ]]; then
    selected_branch=$(echo "$selected_branch" | awk -F' ~ ' '{print $1}')
  fi

  # Checkout to the selected branch
  git checkout $selected_branch
}


alias djrun="./manage.py runserver"
alias djnotebook="./manage.py shell_plus --notebook"
alias djshowmig="./manage.py showmigrations"
alias djmakemig="./manage.py makemigrations"
alias djmig="./manage.py migrate"
alias djsuperuser="python manage.py shell -c \"from django.contrib.auth import get_user_model; get_user_model().objects.create_superuser(email='admin@admin.com', password='admin', organization_id=1)\""

alias ,ymig="yarn makemigrations"
alias ,yaccmig="yarn acceptmigrations"
alias ,ygen="yarn generate"

# alias jrmyissues="jira issue list -q \"(status=Backlog OR status=\\\"Ready to spec\\\" OR status=\\\"Ready for dev\\\" OR status=\\\"In Progress\\\" OR status=\\\"Ready for Review\\\") AND assignee=\\\"$(jira me)\\\"\""

alias celerybeat="pipenv run celery -A ncm beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler"
alias celeryworker="pipenv run celery -A ncm worker -l info"

alias dd-agent-start="launchctl start com.datadoghq.agent"
alias dd-agent-stop="launchctl stop com.datadoghq.agent"

alias k=kubectl

alias ,opencov="open htmlcov/index.html"

alias rrelay="npm run relay"
alias ,intl="npm run extract-intl"

alias dcom="docker-compose"
alias ,cdb8="cd ~/Documents/coding/B8-project/"

alias ,edit_profile="vim ~/.bash_profile && . ~/.bash_profile"
alias ,merge_profile="cp ~/.bash_profile bash_profile"

alias ,cdapi="cd ~/waybridge/api"
alias ,cdui="cd ~/waybridge/ui"
alias ,cdforum="cd $FORUM_PATH"
alias ,cdforumcred="cd $FORUM_CRED_PATH"

function cmdty-pgcli {
    pgcli -h localhost -p 5432 -U ncm -d "$DB_NAME" $@
}
