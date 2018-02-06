#!/bin/sh
echo "Check rbenv install ruby version."

RB_LATEST=`rbenv install --list | sed -r -n "s/^ *([2-9]\.[0-9].[0-9])$/\1/p" | sort | tail -1`
echo "latest version: ${RB_LATEST}"

RB_CUR=`rbenv version | sed -r -n "s/^([2-9]\.[0-9].[0-9]).*/\1/p"`
echo "current version: ${RB_CUR}"

upgrade () {
    read -r -p "Are you sure? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
    then
        rbenv install ${RB_LATEST}
        rbenv global ${RB_LATEST}
        rbenv uninstall ${RB_CUR}
        rbenv rehash
    fi
}

if [[ ${RB_LATEST} != ${RB_CUR} ]]; then
    upgrade
else
    echo "no need to upgrade"
fi

# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
