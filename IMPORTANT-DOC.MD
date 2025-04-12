### TO INSTALL THE K3S MONITOR INSTALL THIS HELM PACKAGE SPECIFIC TO VMS
```bash
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

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


### ADD SOME PERMISSION IF GETTING THE ERROR IN GRAFANA / PROMETHUS
```bash
sudo mkdir -p /data/prometheus
sudo chmod 777 /data/prometheus
sudo mkdir -p /data/grafana
sudo chmod 777 /data/grafana
```

### ADD MULTIPLE NODE EXPORTERS 
```yaml
- job_name: 'node-exporter'
  static_configs:
    - targets: 
        - 'node-exporter.xconnected.svc.cluster.local:9100'
        - '10.2.1.122:9100'
```

### FOR MONGODB
```yaml
- job_name: 'mongodb-exporter'
  static_configs:
    - targets:
        - 'mongodb-exporter.xconnected.svc.cluster.local:9216'
```

***MAKE SURE TO UPDATE SE IN KEYCLOAK DEPOLYMENT `KC_METRICS_ENABLED=true`***


### DOWNLOAD and INSTALL THE MC CLIENT FOR MINIO 

```bash
curl https://dl.min.io/client/mc/release/linux-amd64/mc   --create-dirs   -o $HOME/minio-binaries/mc

chmod +x $HOME/minio-binaries/mc
```

CREATE ALIAS 

```bash
mc alias set s3 10.72.5.6:9000 Mni2mST8Jefl6qnZkEFl 6AjO9Geqqf4GRUXxophcdzKvSAUSMhCXA9Dg8NK6
```


NOW GENERATE THE JOB 
```bash
mc admin prometheus generate ALIAS
```