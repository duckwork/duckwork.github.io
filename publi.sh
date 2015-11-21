#!/usr/bin/env bash
# Small script to publish a new post.

force="${1:-n}"

if ! make -q; then
  make
elif [[ "$force" == "-f" ]]; then
  make again
fi

newest_post="$(ls -1 --sort=time p/*.txt | head -n1)" # TODO: something better
newest_title="$(head -n1 "${newest_post}" | tr -d '%')"

git commit -a -e -m "Publish ${newest_title}" && git push
