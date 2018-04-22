echo "begin"
rm -rf ~/.ssh
mkdir ~/.ssh
echo $BLOGDEPLOYKEY > ~/.ssh/id_rsa
cat > ~/.ssh/config << EOF
Host github.com
  User git
  StrictHostKeyChecking no
  IdentityFile ~/.ssh/id_rsa
  IdentitiesOnly yes
EOF
chmod 600 ~/.ssh/id_rsa
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa
git config --global user.name 'travis-ci'
git config --global user.email abc@abc.com
npm install hexo-cli -g
npm install
hexo clean
hexo g -d

echo "done"