#!/bin/sh
helm repo add argo https://argoproj.github.io/argo-helm
helm repo add gitlab https://charts.gitlab.io/
helm repo update

k3d cluster create --agents 2 --servers 1

sleep 10

helm upgrade --install argo-cd argo/argo-cd --namespace argocd --create-namespace

helm upgrade --install gitlab gitlab/gitlab --namespace gitlab --create-namespace -f values-gitlab.yaml

kubectl apply -f ingress-gitlab.yaml -n gitlab

echo "=============================================================="
echo "Mot de passe initial pour le user admin "
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode; echo

echo "Mot de passe initial pour le user root de gitlab"
kubectl get secret gitlab-gitlab-initial-root-password -o jsonpath="{.data.password}" -n gitlab | base64 --decode ; echo

echo "172.18.0.2 gitlab.172.18.0.2.nip.io" | sudo tee -a /etc/hosts
echo "172.18.0.2 dev-app.com" | sudo tee -a /etc/hosts
echo "=============================================================="
git config --global http.sslVerify false

kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443

# modifier le fichier app.yaml avec l'url de gitlab custom
#kubectl apply -f ../app/app.yaml -n argocd
