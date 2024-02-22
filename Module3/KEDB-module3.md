Docker:
Error in Ex4 when buiding admin image due to permission issue on /tmp - added command to give permissions tp /tmp in Dockerfile
Error in Ex4 when running admin container due to the DB_USERNAME reference missing - Hardocded the username to fix this
Error in Ex4 when running admin container due to werkzeug version incomptibility with flask version - update the requirements file to install flask 3.0.2 instead of 2.2.2

Kubernetes:

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