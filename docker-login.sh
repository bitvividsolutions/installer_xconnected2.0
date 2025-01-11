#! /bin/bash

echo "your_pat" | docker login -u xconnected --password-stdin

kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=/home/$USER/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson -n xconnected

kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "regcred"}]}' -n xconnected

