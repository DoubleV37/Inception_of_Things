minikube start
minikube addons enable ingress
kubectl create configmap nginx-index --from-file=staticfiles/index.html
kubectl create configmap nginx-static-content --from-file=staticfiles/dead.gif
kubectl apply -f configfiles/deployment.yaml
kubectl apply -f configfiles/service.yaml
sleep 10
kubectl apply -f configfiles/ingress.yaml
minikube ip
