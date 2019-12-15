eval $(minikube docker-env bash)
docker build -t auth_k8s ../app/auth_svc
docker build -t gateway_k8s ../app/gateway_svc
docker build -t books_k8s ../app/books_svc
