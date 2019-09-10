1) create a new repo on github

2) add my-scripts dir

cd meta-buildutils

echo "# meta-buildutils fork" >> README.md

git init

git add .

git commit -m "first commit"

git remote add origin git@github.com:RobertBerger/meta-buildutils.git

git push -u origin master

3) use my repo

mv meta-buildutils meta-buildutils.ori
git clone git@github.com:RobertBerger/meta-buildutils.git

4) add upstream

cd meta-buildutils

git remote add official-upstream git://github.com/priv-kweihmann/meta-buildutils

git fetch official-upstream

git branch -a

6) Update from upstream:
git co master
>> git remote -v

official-upstream       git://github.com/priv-kweihmann/meta-buildutils (fetch)
official-upstream       git://github.com/priv-kweihmann/meta-buildutils (push)
origin  git@github.com:RobertBerger/meta-buildutils.git (fetch)
origin  git@github.com:RobertBerger/meta-buildutils.git (push)

>> git fetch official-upstream
---

7) My own branch:
git co master
git co official-upstream/master
git checkout -b 2019-09-10-warrior
git co master
./my-scripts/push-all-to-github.sh

8) apply patches

cd meta-clang

git co 2019-09-10-warrior 

stg init

stg series

stg import --mail ../meta-buildutils-patches/2019-09-10-warrior/0001-use-systemd-as-cgroup-manager-for-docker-While-it-s-.patch

import all patches

...

stg series 

stg commit --all

git log

git co master

9) push to my upstream

my-scripts/push-all-to-github.sh

