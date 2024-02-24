# Install postgres using helm
	helm repo add bitnami-repo  https://charts.bitnami.com/bitnami
	helm install coworking-db bitnami-repo/postgresql

# Retreive the password:
	export POSTGRES_PASSWORD=$(kubectl get secret --namespace default coworking-db-postgresql -o jsonpath="{.data.postgres-password}" | base64 -d)

	echo $POSTGRES_PASSWORD

		default username: postgres
		password: wFomvhjHcl


# Install CSI drivers: (one time activity to install OIDC and CSI drivers to allow EC2 to claim EBS volumes)
	kubectl describe pvc
	curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
	sudo mv /tmp/eksctl /usr/local/bin
	eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=coworkscluster --approve
	eksctl create iamserviceaccount --region us-east-1 --name ebs-csi-controller-sa --namespace kube-system --cluster coworkscluster --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy --approve --role-only --role-name AmazonEKS_EBS_CSI_DriverRole
	eksctl create addon --name aws-ebs-csi-driver --cluster coworkscluster --service-account-role-arn arn:aws:iam::250640364340:role/AmazonEKS_EBS_CSI_DriverRole --force


# Connect to the postgres pod via bash:
	kubectl cp db/*.sql coworking-db-postgresql-0:/tmp -c postgresql #copy files to container
	kubectl exec -it coworking-db-postgresql-0 bash
	/opt/bitnami/scripts/postgresql/entrypoint.sh /bin/bash #to avoid psql does not exist errors
	
	
#Execute the sqls to seed data
	PGPASSWORD=wFomvhjHcl psql postgres://postgres@coworking-db-postgresql:5432/postgres -c "select * from users;"
	PGPASSWORD=wFomvhjHcl psql postgres://postgres@coworking-db-postgresql:5432/postgres < /tmp/1_create_tables.sql
	PGPASSWORD=wFomvhjHcl psql postgres://postgres@coworking-db-postgresql:5432/postgres < 2_seed_users.sql
	PGPASSWORD=wFomvhjHcl psql postgres://postgres@coworking-db-postgresql:5432/postgres -c "select * from tokens;"


#Port forwarding
	kubectl port-forward --namespace default svc/coworking-db-postgresql 5432:5432 &
	PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432 #to check connection manually

#Locally testing python app
	DB_USERNAME="postgres" DB_PASSWORD="wFomvhjHcl" python3 app.py




