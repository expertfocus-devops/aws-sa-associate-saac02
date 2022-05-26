# IAM Policy Document

```json
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Sid":"statement1", <--- Sid=Statement ID (optional)
         "Effect":"Allow",   <--- Effect=Allow/Deny 
         "Action":[          <--- Action=Resource actions 
            "s3:*"
         ],
         "Resource":[        <--- Resource=Object that exists within a service (Ec2,IAM,S3..)
            "arn:aws:s3:::*"
         ]
       },
       {
         "Effect": "Deny",
         "Action": "s3:*",
         "Resource": [
           "arn:aws:s3:::<bucketname>", "arn:aws:s3:::<bucketname>/*"
         ]
       }
    ]
}
```
* A policy consists of one or more statements.

* A statement is a combination of two main things, the resource and the action.

* Action can be an individual action, a list of actions or wildcard(every action).

* In resoruces also it be a specific single resource, a lsit of resources or wildcard(every resource). For an individual resource or a lsit of resources you have to use [**AWS ARN**](https://github.com/expertfocus-devops/aws-sa-associate-saac02/blob/pre-prod/AWS%20Identity%20and%20Access%20Management/Amazon%20Resource%20Names.md) of the resource.

* Effect controlls what AWS does if the action and resoruce part of the statement match to what action you are attempting to perform.     


