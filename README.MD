### TO INSTALL THE K3S MONITOR INSTALL THIS HELM PACKAGE SPECIFIC TO VMS
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-state-metrics prometheus-community/kube-state-metrics -n xconnected --create-namespace
```
### SOME COMMANDS THAT SHOULD BE USED TO SETUP THE MONGO & MINIO SCRIPTS 

```bash
kubectl exec -it mongodb-0 -n xconnected -- /bin/bash
kubectl cp back_mongo_script.sh mongodb-0:/tmp/back_mongo_script.sh -n xconnected
kubectl exec -it mongodb-0 -n xconnected -- /bin/bash
chmod +x /tmp/back_mongo_script.sh
kubectl exec -it mongodb-0 -n xconnected -- /bin/bash -c "/tmp/back_mongo_script.sh"
```


### CRONTAB SCRIPTS 
```bash
3 1 * * * cd /you_directory/ && sh clear_mongo_35days.sh && echo "MONGO DATA clear successfully"
5 12 * * * /usr/bin/python3 /you_directory/clean_minio.py && echo "Minio DATA CLEAR"
```