kubectl exec -it $(kubectl get pods -l app=mongodb -n xconnected -o jsonpath="{.items[0].metadata.name}") -n xconnected -- /bin/bash -c "/tmp/back_mongo_script.sh"
