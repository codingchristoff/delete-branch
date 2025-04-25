#!/bin/bash
#####
# V0.1.4
#####
set -m

declare gitDeleteLocal="git branch -D"
declare gitDeleteOrigin="git push origin --delete"
declare deleteLocalBranch=false
declare deleteRemoteBranch=false

deleteBranch() {
	if [[ "$1" == "" ]]; then
		echo "Please provide a branch to delete."
		exit
	fi

	if [[ "$deleteLocalBranch" = true && "$deleteRemoteBranch" = true ]]; then
		deleteLocal "$1"
		deleteOrigin "$1"
		exit
	fi

	if [[ "$deleteRemoteBranch" = true ]]; then
		deleteOrigin "$1"
		exit
	fi	
		deleteLocal "$1"
		exit
}

deleteLocal() {
	$gitDeleteLocal "$1"
}

deleteOrigin() {
	$gitDeleteOrigin "$1"
}

# ********** START ********** #
# //Process options
while getopts ":br" opt; do
	case $opt in
	b) 
		deleteLocalBranch=true
		deleteRemoteBranch=true
	;;
	r) 
		deleteRemoteBranch=true
	;;
	\?)
		echo "Please select an option:"
		echo "-r delete remote only"
		echo "-b delete remote and origin"
		echo "no args to delete local only"
		exit 1
	;;
	esac
done
shift $((OPTIND - 1))

deleteBranch "$1"