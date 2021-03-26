# Running the code
1. start `localstack` using `docker-compose up`
2. In a different console, run terraform:
   1. `terraform init`
   2. `terraform apply`

# Issue with local stack:
Runnning this in AWS returns promply the creation of the 3 resources. But against localstack, it hangs. We can see in
the logs that the rule were created correctly but terraform seems unable to understand it:

```
2021-03-26T09:38:12.074+0100 [DEBUG] plugin.terraform-provider-aws_v3.22.0_x5: 2021/03/26 09:38:12 [DEBUG] [aws-sdk-go] <DescribeSecurityGroupsResponse xmlns="http://ec2.amazonaws.com/doc/2013-10-15/"><requestId>59dbff89-35bd-4eac-99ed-be587EXAMPLE</requestId><securityGroupInfo><item><ownerId>000000000000</ownerId><groupId>sg-1cf94f40</groupId><groupName>terraform-20210326083754707700000001</groupName><groupDescription>Managed by Terraform</groupDescription><vpcId>vpc-dd000f17</vpcId><ipPermissions><item><ipProtocol>tcp</ipProtocol><fromPort>5439</fromPort><toPort>5439</toPort><groups></groups><ipRanges><item><cidrIp>0.0.0.0/0</cidrIp></item></ipRanges></item></ipPermissions><ipPermissionsEgress></ipPermissionsEgress><tagSet></tagSet></item></securityGroupInfo></DescribeSecurityGroupsResponse>
2021-03-26T09:38:12.074+0100 [DEBUG] plugin.terraform-provider-aws_v3.22.0_x5: 2021/03/26 09:38:12 [DEBUG] Unable to find matching ingress Security Group Rule (sgrule-1692235148) for Group sg-1cf94f40
2021-03-26T09:38:12.074+0100 [DEBUG] plugin.terraform-provider-aws_v3.22.0_x5: 2021/03/26 09:38:12 [TRACE] Waiting 10s before next try
2021/03/26 09:38:13 [TRACE] dag/walk: vertex "root" is waiting for "meta.count-boundary (EachMode fixup)"
2021/03/26 09:38:13 [TRACE] dag/walk: vertex "meta.count-boundary (EachMode fixup)" is waiting for "aws_security_group_rule.allow_redshift_connection"
2021/03/26 09:38:13 [TRACE] dag/walk: vertex "provider[\"registry.terraform.io/hashicorp/aws\"] (close)" is waiting for "aws_security_group_rule.allow_redshift_connection"
aws_security_group_rule.allow_redshift_connection: Still creating... [20s elapsed]
```

Removing the `aws_redshift_subnet_group` fixes the problem. Adding a `aws_redshift_cluster` that references the subnet 
group does not fix the issue.
