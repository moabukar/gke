terraform output  -json | jq '.client_key.value' | tr -d '"' > key
terraform output  -json | jq '.client_certificate.value'| tr -d '"' > cer
terraform output  -json | jq '.ca.value' | tr -d '"' > ca
ENDPOINT=$(terraform output  -json | jq '.endpoint.value' | tr -d '"')

kubectl config set-cluster gke \
    --certificate-authority=ca \
    --embed-certs=true \
    --server=https://$ENDPOINT \
    --kubeconfig=gke.kubeconfig

kubectl config set-credentials gke-user \
    --client-certificate=cer \
    --client-key=key \
    --embed-certs=true \
    --kubeconfig=gke.kubeconfig

kubectl config set-context default \
    --cluster=gke \
    --user=gke-user \
    --kubeconfig=gke.kubeconfig

kubectl config use-context default --kubeconfig=gke.kubeconfig

