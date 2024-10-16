#!/bin/sh
echo "coucou"
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - server --cluster-init

