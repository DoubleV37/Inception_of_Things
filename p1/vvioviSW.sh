#!/bin/sh
curl -sfL https://get.k3s.io | K3S_TOKEN=my-cluster-token sh -s - agent --server https://192.168.56.110:6443 --node-ip 192.168.56.111
