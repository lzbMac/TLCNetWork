#!/bin/sh

echo ">>>>>begin copy CodeSnippets!"

current=$(cd "$(dirname "$0")"; pwd)
cd ~/Library/Developer/Xcode/UserData
if [ ! -d "CodeSnippets" ]; then
	mkdir CodeSnippets
fi

cd "$current"
cp -af CodeSnippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets/
cd CodeSnippets

echo "CodeSnippets below:"
ls

echo ">>>>>All CodeSnippets are copied!"
