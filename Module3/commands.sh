#to update cluster details to config file
aws eks update-kubeconfig --name ekscluster

#to get cluster info
kubectl cluster-info

# to get user configured in AWS CLI
aws sts get-caller-identity

# deploy to EKS
kubectl apply -f database.yml

kubectl get pods
kubectl get services
kubectl logs <pod name>

#get containers in a pod
kubectl get pods <pod name> -o jsonpath='{.spec.containers[*].name}'

#get logs from a container
kubectl logs <pod name> -c <container name>

#copy file to a specific container in a pod
kubectl cp file_to_copy.sh <pod name>:/tmp -c <container name>

#run a command in a pod/container
kubectl exec -it <pod> bash /tmp/file_to_copy.sh

#delete a pod
kubectl delete pod <pod name>