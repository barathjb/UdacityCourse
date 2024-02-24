###Docker:

Error in Ex4 when buiding admin image due to permission issue on /tmp - added command to give permissions to /tmp in Dockerfile

Error in Ex4 when running admin container due to the DB_USERNAME reference missing - Hardocded the username to fix this

Error in Ex4 when running admin container due to werkzeug version incomptibility with flask version - update the requirements file to install flask 3.0.2 instead of 2.2.2

------------------------------------------------------

###Kubernetes:

# Error1: 
Below error was seen when connecting to the EKS Cluster

greymatter@greymatter:/mnt/d/Udacity/Module3$ kubectl cluster-info
E0217 12:40:10.939192    1561 memcache.go:265] couldn't get current server API group list: the server has asked for the client to provide credentials

# Reason:
This was due to the difference in the IAM user used to create the cluster and the IAM user used in the CLI.

# Fix:
Given console access to the IAM user that was used for CLI.
Logged into the AWS console and created EKS cluster using that user.


# Error2:
An error occurred (SignatureDoesNotMatch) when calling the GetCallerIdentity operation: Signature expired: 20240217T171323Z is now earlier than 20240217T173539Z (20240217T175039Z - 15 min.)

# Reason
System time and server time are non sync.

# Fix:
sudo ntpdate pool.ntp.org

# Error3:
greymatter@greymatter:/mnt/d/Udacity/Module3$ kubectl get pods

NAME                      READY   STATUS             RESTARTS         AGE

app-db-6854d755c6-d6m62   0/1     CrashLoopBackOff   93 (3m20s ago)   7h34m

# Fix:
Increased the EC2 instance type to a larger size


# Error 4:
After installing postgres using helm charts, the postgres pod shows pending.
        greymatter@greymatter:/mnt/d/Udacity/Module3$ kubectl get pods
        NAME                      READY   STATUS    RESTARTS   AGE
        coworks-db-postgresql-0   0/1     Pending   0          22m
On checking the postgres pod resource in the console, the following error is seen
    Warning	FailedScheduling	12 minutes ago	default-scheduler	running PreBind plugin "VolumeBinding": binding volumes: context deadline exceeded

kubectl describe pvc - shows that the EBS volume is not bound to the EC2 nodes.
     Waiting for a volume to be created either by the external provisioner 'ebs.csi.aws.com' or manually by the system administrator. If volume creation is delayed, please verify that the provisioner is running and correctly registered.

# Fix & Reason
https://stackoverflow.com/questions/75758115/persistentvolumeclaim-is-stuck-waiting-for-a-volume-to-be-created-either-by-ex



# Error 5;
exec user process caused "exec format error" in pod status
# Reason:
Non sync in architecture type between container image and EKS node instance type. In this case, container was x86 and node was ARM64.
# Fix:
Use the same architecture type.
