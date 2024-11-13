minikube start
minikube addons enable ingress
kubectl create configmap app1-index --from-file=app1/staticfiles/index.html
kubectl create configmap app1-static-content --from-file=app1/staticfiles/dead.gif
kubectl apply -f app1/deployment.yaml
kubectl apply -f app1/service.yaml

kubectl create configmap app2-index --from-file=app2/staticfiles/index.html
kubectl create configmap app2-static-content --from-file=app2/staticfiles/burn.gif
kubectl apply -f app2/deployment.yaml
kubectl apply -f app2/service.yaml

kubectl create configmap app3-index --from-file=app3/staticfiles/index.html
kubectl create configmap app3-static-content --from-file=app3/staticfiles/crying.gif
kubectl apply -f app3/deployment.yaml
kubectl apply -f app3/service.yaml

sleep 10

kubectl apply -f ingress.yaml
minikube ip
