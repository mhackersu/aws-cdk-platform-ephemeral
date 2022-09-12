# Inception Health Technical Challenge

## Assignment

* Using the tools and language of your choice, write code that deploys the application provided in `app/` using a single command.
* The single command from the user can (and likely will) call a longer shell script, or other configuration management code.
* The script should make the backend service available via https over the public internet.
* The script should output the address of the `backend` api.
* The script should cause the checkin event handler to be triggered regularly by an automated process.
* Your credentials are attached. You have admin access to the account. Please use region `us-east-1`.
* We ask that you not use ec2 directly for your solution. However, something like a fargate cluster in which ec2 instances are managed by aws is okay.
* You should not need to make changes to the existing application code. 

## Evaluation Criteria

* Please don't take more than 3 hours total. If you find yourself running over, write down what you didn't get to so we can discuss it in the review.
* Timekeeping is up to you and we expect your finished response in a reasonable amount of time.
* Source control is expected as well as documentation that should explain how you approached the challenge, what assumptions you've made, and reasoning behind the choices in your approach.
* You are being evaluated based on:
  * Quality of your code and configuration
  * Clarity of your written communication and documentation
  * Communicating how your code works in our review session.
  * Communicating how the app runs in our review session.
  * Project presentation.

## What's Included?

### AWS Credentials

Your AWS credentials give you admin access to a sandbox account. You may use any resources you find appropriate.

You have access to an existing hosted zone in route53. The zone id is `Z07252961CXXYMJEGGB16` and the zone name is `jake-sandbox.ihengine.com`. Please do not buy and/or register a new domain or create a new hosted zone.

### Application

There is a typescript code base in the `app/` folder in the root of this repository. It exports two functions, `checkin` and `backend` from `index.ts`. `checkin` creates a record in dynamodb that represents a patient checking in. `backend` reads the records in dynamodb and returns a JSON encoded message representing the latest checkin time for the known patients. 

The functions are fairly short and written in typescript. Please feel free to read the code to get a sense of things.

The functions can be invoked directly from lambda or using the express implementation in `express.ts`. 

There are two Dockerfiles provided for your convenience. First, `Dockerfile.lambda` is for use with lambdas. Second is `Dockerfile.express` which will startup an express server on port 3000.

You should not need to modify this code. You may use either the lambda or express based version of the app or some combination of the two.

### Runtime requirements

#### AWS Credentials

We use the aws-sdk in the application and so it expects credentials to be made available using one of the standard mechanisms provided by AWS.

`checkin` will need write access to the dynamodb table.

`backend` will need read access to the dynamodb table. It will also need to be able to describe the table.

#### Environment variables

Both functions need the same environment variables no matter how you run the application.

* `DYNAMO_TABLE_NAME` - Required. The name of the dynamodb table to read from or write to.
* `REGION` - Optional. The aws region in which the dynamodb table exists. Can be omitted if your chosen credentials provider will handle it for you.

#### Lambda handler name

Make sure that you set the correct handler name for each lambda. If you are using the provided dockerfile you need to set `CMD` in docker to `index.checkin` or `index.backend` as appropriate.

### Running Locally

You can run either the lambdas or the the express web server locally. This may be helpful for understanding how to execute the functions.

#### Lambda Handlers (Requires Docker)

Check in a patient

```
cd app/
docker build -t lambda-handler -f Dockerfile.lambda .
docker run --rm -d -p 8080:8080 \
  -e DYNAMO_TABLE_NAME=YOUR_TABLE_NAME \
  -e REGION=us-east-1 \
  -e AWS_PROFILE=$AWS_PROFILE \
  -v $HOME/.aws/:/root/.aws/:ro \
  lambda-handler index.checkin
curl -X POST http://localhost:8080/2015-03-31/functions/function/invocations -H 'Content-Type: application/json' -d '"{}"'
```

List the latest patient checkin times.

```
cd app/
docker build -t lambda-handler -f Dockerfile.lambda .
docker run --rm -d -p 8081:8080 \
  -e DYNAMO_TABLE_NAME=YOUR_TABLE_NAME \
  -e REGION=us-east-1 \
  -e AWS_PROFILE=$AWS_PROFILE \
  -v $HOME/.aws/:/root/.aws/:ro \
  lambda-handler index.backend
curl -X POST http://localhost:8081/2015-03-31/functions/function/invocations -H 'Content-Type: application/json' -d '"{}"'
```

#### Express Webserver

**With Docker**
```
cd app/
docker build -t express-app -f Dockerfile.express .
docker run --rm -d -p 3000:3000 \
  -e DYNAMO_TABLE_NAME=YOUR_TABLE_NAME \
  -e REGION=us-east-1 \
  -e AWS_PROFILE=$AWS_PROFILE \
  -v $HOME/.aws/:/root/.aws/:ro \
  express-app

# check in a patient
curl -X POST http://localhost:3000/checkin

# List the latest patient checkin times.
curl http://localhost:3000/
```

**Without Docker**
```
cd app/
npm run build-express
DYNAMO_TABLE_NAME=YOUR_TABLE_NAME REGION=us-east-1 node ./dist/express.js
```



## Closing Remarks

There are no trick questions here. We want to see you deploy something and are excited to talk to you about how you did it.

Please reach out with any questions or if something needs to be clarified. jake.gaylor@froedtert.com and nick.harris@froedtert.com are here to help.

Good Luck!
