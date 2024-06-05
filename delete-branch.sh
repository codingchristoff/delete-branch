#!/bin/bash
#####
# V0.1.2
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
		echo "1"
		deleteLocal "$1"
		deleteOrigin "$1"
		exit
	fi

	if [[ "$deleteRemoteBranch" = true ]]; then
		echo "2"
		deleteOrigin "$1"
		exit
	fi	
		echo "3"
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
while getopts "rb:" opt; do
	case $opt in
	b) 
		deleteLocalBranch=true
		deleteRemoteBranch=true
	;;
	r) 
		deleteRemoteBranch=true
	;;
	\?)
		echo "Invalid option: -$OPTARG" >&2
		exit 1
	;;
	esac
done
shift $((OPTIND - 1))

deleteBranch "$1"