# Sidekiq::Web monitor powered by AWS lambda

<p align="center">
  <img src="https://raw.githubusercontent.com/hoshinotsuyoshi/serverless-sidekiq-web/master/image.jpg" alt="site image"/>
</p>

----

<p align="center">
  <img src="https://raw.githubusercontent.com/hoshinotsuyoshi/serverless-sidekiq-web/master/stack.png" alt="stack image"/>
</p>

----

Sidekiq::Web monitor powered by AWS lambda. 

Based on [lambda.rb](https://github.com/aws-samples/serverless-sinatra-sample/blob/6f4fe27/lambda.rb) by [aws-samples/serverless-sinatra-sample](https://github.com/aws-samples/serverless-sinatra-sample)

## System Requirements

* ruby(this repository is tested by 2.5.1)
* bundler gem
* redis(for local only)

## Getting Started

### Install Ruby dependencies for this service

```sh
$ bundle install
```

### Download the Gems to the local vendor directory

```sh
$ bundle install --deployment
```

## Deployment

### Upload lambda code to S3 & Create CloudFormation template

(if you don't have a S3 bucket, you need to create one)

```sh
$ aws cloudformation package \
    --template-file template.yaml \
    --output-template-file serverless-output.yaml \
    --s3-bucket { your bucket name }
```

### Deploy

```sh
$ aws cloudformation deploy --template-file serverless-output.yaml \
    --stack-name { your-stack-name } \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
      SecurityGroupIds="{ your security group ids which can access to redis(comma separated) }" \
      VpcSubnetIds="{ your subnet ids which can access to redis(comma separated) }" \
      RedisHost="{ your redis host name }"
```

example

```sh
$ aws cloudformation deploy --template-file serverless-output.yaml \
    --stack-name=hoshino-20181201-sidekiq-web \
    --capabilities CAPABILITY_IAM \
    --parameter-overrides \
      SecurityGroupIds="sg-7a48c603" \
      VpcSubnetIds="subnet-7edf1e29" \
      RedisHost="hoshino-redis.wb790t.ng.0001.apne1.cache.amazonaws.com"
```
