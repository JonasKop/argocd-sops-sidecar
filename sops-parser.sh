#!/bin/bash

set -e

agePublicKey=$(cat ~/.config/sops/age/keys.txt | sed -n 's/^.*public key: //p')

cat >.sops.yaml <<EOF
creation_rules:
  - age: $agePublicKey
EOF

if test -f all.yaml; then
    all=$(cat all.yaml)
fi

if test -f secrets.yaml; then
    secrets=$(sops -d secrets.yaml)
fi

cat <<EOF
$secrets
---
$all
EOF
