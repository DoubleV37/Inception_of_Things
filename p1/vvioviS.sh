#!/bin/sh
curl -sfL https://get.k3s.io | K3S_TOKEN=my-cluster-token sh -s - server --write-kubeconfig-mode 644 --node-ip 192.168.56.110 --flannel-iface eth1
