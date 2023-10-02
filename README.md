# Helm Chart Usage Demo
This project contains Spring Boot application, that can be deployed into Kubernetes using Helm Charts.

## Prerequisites
1. [Docker](https://docs.docker.com/engine/install/)
2. [Minikube](https://minikube.sigs.k8s.io/docs/start/)
3. [kubectl](https://kubernetes.io/docs/tasks/tools/)
4. [Helm](https://helm.sh/docs/intro/install/)

## How to run
Run following commands in the project root directory.

1. Start Minikube with appropriate VM <br/>
   `minikube start -- vm-driver=virtualbox`
2. Allow Kubernetes to read local docker repository <br/>
   `eval $(minikube docker-env) `
3. Build Docker image <br/>
   `docker compose build --no-cache`
4. Install changes with Helm <br/>
   `helm install demo-helm --namespace demo-helm --create-namespace ./helm`
5. Start tunnel for service. Now it should be opened in browser.
   Go to "http://127.0.0.1:\<port>/ping" to check that application is working. <br/>
   `minikube service demo-helm -n demo-helm`

Minikube dashboard can be opened to monitor <br/>
`minikube dashboard`

## Other scenarios to try
Note: if other options are tried, resources have to be deleted <br/>
`kubectl delete namespace demo-helm`

### Deploy service without Helm
1. Run steps 1-3 from "How to run" section
2. Create Kubernetes resources
```
kubectl apply -f ./k8s/namespace.yaml
kubectl apply -f ./k8s/deployment.yaml
kubectl apply -f ./k8s/service.yaml
```
3. Start tunnel for service. Now it should be opened in browser.
   Go to "http://127.0.0.1:\<port>/ping" to check that application is working. <br/>
   `minikube service demo-helm -n demo-helm`

### Access service via node IP and port
1. Run steps 1-4 from "How to run" section
2. Retrieve node IP and port
```
kubectl get --namespace demo-helm -o jsonpath="{.spec.ports[0].nodePort}" services demo-helm
kubectl get nodes --namespace demo-helm -o jsonpath="{.items[0].status.addresses[0].address}"
```
3. Send the request to the IP
`curl http://<IP>:<port>/ping`

## Useful

* [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
