# IAM Policy Document

```json
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Sid":"statement1", <--- Sid=Statement ID**
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
### Statement Fields


