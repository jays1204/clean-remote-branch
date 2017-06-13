#!/usr/bin/env bash

################ CONFIG_LIST ##########################
REPOSITORY_NAME_LIST=""
REPOSITORY_ROOT_DIR="" 
#######################################################

function visitRepository() {
  for repo in ${REPOSITORY_NAME_LIST[@]}
  do
    relativePath="${REPOSITORY_ROOT_DIR}${repo}"
    echo "target repository : ${repo}"
    (cd ${relativePath};
    cleanUpMergedBranch
    )
  done
}

function cleanUpMergedBranch() {
  # update repository info
  git fetch -p
  git fetch --all

  CRITERIA_BRANCH="develop master"

  for criteria in ${CRITERIA_BRANCH[@]}
  do
    branchList=`git branch -r --merged=$criteria | egrep -v "(^\*|master|develop)" | sed s:origin/::`

    for branchName in ${branchList[@]}
    do
      deleteRemoteBranch ${branchName}
    done
  done

  # 삭제된 리모트 브랜치에 대한 로컬 트래킹 정보 삭제
  # update remote tracking info
  git remote prune origin
}

# delete remote(origin) branch 
function deleteRemoteBranch() {
  branchName=$1

  if [ -z ${branchName} ];
  then
    echo "Specify branch Name!"
  fi


  if [ ${branchName} == "master" ] || [ ${branchName} == "develop" ];
  then
    echo "Don't delete ${branchName}! "
    exit 0
  fi

  if [ -n ${branchName} ];
  then
    echo "delete remote branch:${branchName}"
    git push origin :${branchName}
  else
    echo "Specify branch Name!"
  fi
}

# check whether existing git respotisory given by REPOSITORY_NAME_LIST
function checkGitRepositoryExist() {
  for repo in ${REPOSITORY_NAME_LIST[@]}
  do
    relativePath="${REPOSITORY_ROOT_DIR}${repo}"

    if [ -d ${relativePath} ];
    then
      echo "exist: ${relativePath}"
    else
      echo "no exist repository: ${relativePath}"
      echo "exit script"
      exit 0
    fi
  done
}

# run main!
function main() {
  checkGitRepositoryExist
  visitRepository
}

main
