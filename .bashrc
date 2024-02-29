export GH_USERNAME='LandonTClipp'

gitrbm() {
    local current_branch=$(git branch --show-current)
    git stash
    git fetch --all
    git checkout master
    git rebase upstream/master
    git push --force
    git checkout $current_branch
    git rebase master
    git push --force
    git stash
}

gitba() {
    git branch -a
}

gitnb() {  
    git checkout -b $GH_USERNAME/$1
    git push -u origin $GH_USERNAME/$1
}

git_main_branch_name() {
    echo "$(git rev-parse --abbrev-ref origin/HEAD | awk -F '/' '{print $2 }')"
}

gitc() {
    main_name="$(git_main_branch_name)"
    git branch --merged | grep -v "^[ *]*${main_name}$" | awk '{ print $NF }' | xargs git branch -d
}
