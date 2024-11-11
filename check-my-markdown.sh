#! /bin/bash

# check-my-markdown.sh
# Run tools on a set of Markdown files to find fussy problems
# Decide whether to fix or not

# Usage: 
# 
#   sh ./check-my-markdown.sh path-to-top-level-directory

# Use "find" to recursively discover all the *.md files and pipe
# them to the tools

DIR=`pwd`
DICT="$DIR/dictionary.txt"
# echo ' --- "$DICT" --- '

echo ""
echo "=== markdownlint ==="
echo ""
find "$1" -name \*.md -print0 | xargs -0 -n1 markdownlint

echo ""
echo "=== markdown-link-check ==="
echo ""
find "$1" -name \*.md -print0 | xargs -0 -n1 markdown-link-check -q

echo ""
echo "=== spellchecker ==="
echo ""

cd "$1"
spellchecker -q --files "**/*.md" -d "$DICT"
