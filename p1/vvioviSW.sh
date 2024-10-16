#!/bin/sh
echo "coucouSW"
curl -sfL https://get.k3s.io | K3S_TOKEN=SECRET sh -s - agent --server https://192.168.56.110:6443
