export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="aussiegeek"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export GH_USERNAME='LandonTClipp'
export REQUESTS_CA_BUNDLE="/Users/landon/.ca-certificates.crt"
export PATH="/opt/homebrew/bin:$PATH"

gitnb() {
    git checkout -b $GH_USERNAME/$1
    git push -u origin $GH_USERNAME/$1
}

export CLOUDFLARE_PROFILE='tunnel-orchestrator'

git_main_branch_name() {
    echo "$(git rev-parse --abbrev-ref origin/HEAD | awk -F '/' '{print $2 }')"
}

gitc() {
        gfa
        gbda
        main_name="$(git_main_branch_name)"
        git checkout "$main_name"
        git pull
        # npm install -g git-removed-branches
        git removed-branches --prune
}


gitcf() {
        gfa
        gbda
        # npm install -g git-removed-branches
        git removed-branches --force --prune
}
