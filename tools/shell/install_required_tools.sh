#!/usr/bin/env bash

while read -r tool; do
  if ! asdf plugin-list | grep -q "$tool"; then
    echo "INFO -  ${tool} plugin is not installed. Installing it now"
    asdf plugin-add "$tool"
  fi
done < <(awk '{print $1}' .tool-versions)

echo "INFO - Installing tools"
asdf install