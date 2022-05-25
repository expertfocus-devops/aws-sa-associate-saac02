# What is IAM  <Image src="images/iam.png" alt="drawing" width="50"/>

AWS Identity and Access Management (IAM) is a web service that helps you securely control access to AWS resources.

IAM control who is authenticated (signed in) and authorized (has permissions) to use resources.

When you first create an AWS account, you begin with a single sign-in identity that has complete access to all AWS services and resources in the account. This identity is called the AWS account root user and is accessed by signing in with the email address and password that you used to create the account.

### Lock away your AWS account root user access keys

You use an access key (an access key ID and secret access key) to make programmatic requests to AWS.

However, do not use your AWS account root user access key. The access key for your AWS account root user gives full access to all your resources for all AWS services, including your billing information. **You cannot reduce the permissions associated with your AWS account root user access key.**

Therefore, protect your root user access key like  any other sensitive secret.

Here are some ways to do that:

* Its strongly recommend that you do not use the root user for your everyday tasks, even the administrative ones. Instead, use your root user credentials only to create your IAM admin user. Then securely lock away the root user credentials and use them to perform only a few account and service management tasks. For everyday tasks, do not use your IAM admin user. Instead, use roles to delegate permissions.
* If you do have an access key for your AWS account root user, delete it. If you must keep it, rotate (change) the access key regularly. To delete or rotate your root user access keys, go to the [My Security Credentials](https://console.aws.amazon.com/iam/home?#security_credential) page in the AWS Management Console and sign in with your account's email address and password. You can manage your access keys in the Access keys section.
* Use a strong password to help protect account-level access to the AWS Management Console