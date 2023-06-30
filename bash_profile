echo "loading bash_profile"

alias gsafepull="git pull origin master --no-ff --no-commit"
alias gpull="git pull origin master"
alias gpush="git push origin -u HEAD"
alias gstat="git status"
alias glog="git log"
alias gdifffiles="git diff --name-only"
alias gdiff="git diff"
alias gdiffmaster="git fetch && gdiff origin/master"
alias gco="git checkout"
alias gcobranch="gco \`git branch -a | fzf\`"
alias gcom="git commit -a -m"
function gcopaste {
  gco $(pbpaste) || gco -b $(pbpaste)
}
function gcpush {
    gcom $@ && gpush
}

alias djrun="./manage.py runserver"
alias djnotebook="./manage.py shell_plus --notebook"
alias djshowmig="./manage.py showmigrations"
alias djmakemig="./manage.py makemigrations"
alias djmig="./manage.py migrate"
alias djsuperuser="python manage.py shell -c \"from django.contrib.auth import get_user_model; get_user_model().objects.create_superuser(email='admin@admin.com', password='admin', organization_id=1)\""

alias jrmyissues="jira issue list -q \"(status=Backlog OR status=\\\"Ready to spec\\\" OR status=\\\"Ready for dev\\\" OR status=\\\"In Progress\\\" OR status=\\\"Ready for Review\\\") AND assignee=\\\"$(jira me)\\\"\""

alias celerybeat="pipenv run celery -A ncm beat -l INFO --scheduler django_celery_beat.schedulers:DatabaseScheduler"
alias celeryworker="pipenv run celery -A ncm worker -l info"

alias dd-agent-start="launchctl start com.datadoghq.agent"
alias dd-agent-stop="launchctl stop com.datadoghq.agent"

alias k=kubectl

alias ,opencov="open htmlcov/index.html"

alias rrelay="npm run relay"
alias ,intl="npm run extract-intl"

alias dcom="docker-compose"
alias cdb8="cd ~/Documents/coding/B8-project/"

alias ,edit_profile="vim ~/.bash_profile && . ~/.bash_profile"

alias ,cdapi="cd ~/waybridge/api"
alias ,cdui="cd ~/waybridge/ui"


function cmdty-pgcli {
    pgcli -h localhost -p 5432 -U ncm -d "$DB_NAME" $@
}

#function ,setdb {
#    NEW_DB_NAME=`psql -h localhost -p 5432 -U ncm -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;" | sort -r | fzf | xargs`
#    sed -i -E "s/^DB_NAME=.*$/DB_NAME=$NEW_DB_NAME/g" .env
#    . ./loadenv.sh
#}
alias ,setdb=". ./scripts/set-db.sh && ./scripts/cleanup-dbs.sh"
alias ,pullstagingdb="./scripts/db-copy.sh --env=staging"
