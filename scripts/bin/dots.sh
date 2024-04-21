#!/usr/bin/env sh

cp ~/.zshrc ~/git/personal/zshrc
cp -r ~/org ~/git/personal/org
cp ~/.newsboat/urls ~/git/personal/newsboaturls
cp -r ~/bin/ ~/git/personal/scripts

cd ~/git/personal
git add .
git commit -m "dotfiles"
git push -u https://SafriXV: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@github.com/SafriXV/Personal tracking
