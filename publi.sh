#!/usr/bin/env bash
# Small script to publish a new post.

arg="${1:-n}"

# TODO: add switches to enable different commit message; no-web option

if ! make -q; then
  make
elif [[ "$arg" == "-f" ]]; then
  make again
fi

newest_post="$(ls -1 --sort=time p/*.txt | head -n1)" # TODO: something better
newest_title="$(head -n1 "${newest_post}" | tr -d '%')"

git add .
git commit -m "Publish:${newest_title}" && git push
