#!/bin/sh

vagrant up

# Wait for the VMs to boot
sleep 60

# Copy kubeconfig from the server to the host
if [ ! -d "$HOME/.kube" ]; then
  mkdir $HOME/.kube
fi
vagrant ssh vvioviS -c "cat /etc/rancher/k3s/k3s.yaml" > $HOME/.kube/config
sed -i 's/127\.0\.0\.1/192\.168\.56\.110/g' $HOME/.kube/config

kubectl create configmap app1-index --from-file=apps/app1/staticfiles/index.html
kubectl create configmap app1-static-content --from-file=apps/app1/staticfiles/dead.gif
kubectl apply -f apps/app1/deployment.yaml
kubectl apply -f apps/app1/service.yaml

kubectl create configmap app2-index --from-file=apps/app2/staticfiles/index.html
kubectl create configmap app2-static-content --from-file=apps/app2/staticfiles/burn.gif
kubectl apply -f apps/app2/deployment.yaml
kubectl apply -f apps/app2/service.yaml

kubectl create configmap app3-index --from-file=apps/app3/staticfiles/index.html
kubectl create configmap app3-static-content --from-file=apps/app3/staticfiles/crying.gif
kubectl apply -f apps/app3/deployment.yaml
kubectl apply -f apps/app3/service.yaml

sleep 10

kubectl apply -f apps/ingress.yaml
