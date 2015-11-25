#!/usr/bin/env bash
# Small script to publish a new post.

force=false; promptMsg=false; editMsg=false; offline=false; dryrun=false;
while (( "$#" > 0 )); do
  case "$1" in
    -f ) force=true     ;;
    -m ) promptMsg=true ;;
    -M ) editMsg=true   ;;
    -n ) offline=true   ;;
  esac
  shift;
done

if ! make -q; then
  echo "Making..."
  make
elif $force; then
  echo "Making again..."
  make again
fi

echo "Collating..."
newest_post="$(ls -1 --sort=time p/*.txt | head -n1)" # TODO: something better
newest_title="$(head -n1 "${newest_post}" | tr -d '%')"

echo "Committing..."
git add .
if ! $promptMsg; then
  git commit -m "Publish:${newest_title}"
elif ! $editMsg; then
  echo -n "Commit message: "; read msg
  git commit -m "$msg"
else
  git commit
fi
if ! $offline && (( $? == 0 )); then
  git push
fi
