kubectl apply -f node-reader.yaml \
	--kubeconfig=eks.kubeconfig
SECRET_NAME=$(
        kubectl get serviceaccount user-id-ksa \
	     -o jsonpath='{$.secrets[0].name}' \
             --kubeconfig=eks.kubeconfig \
             )
kubectl get secret ${SECRET_NAME} \
	-o jsonpath='{$.data.token}' \
	--kubeconfig=aks.kubeconfig \ 
	| base64 -d 
