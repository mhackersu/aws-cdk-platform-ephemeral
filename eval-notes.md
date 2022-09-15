<!-- eval.md -->

# Challange

- [x] Using the tools and language of your choice, write code that deploys the application provided in `app/` using a single command.
- [x] The single command from the user can (and likely will) call a longer shell script, or other configuration management code.
- [ ] The script will make the backend service available via https over the public internet.
- [ ] Set the script to output the `backend` api address.
- [ ] Set the script to trigger the checkin event handler once per 60s.
- [ ] Admin creds in csv; Use region `us-east-1`.
- [ ] No direct EC2; Fargate with EC2 is allowed.
- [ ] Make no changes to existing application code. 

# NFR

  * Budget - 3 hours
  * Timely commits
  * Document approach, assumptions, and reasoning

# Criteria

  * Quality of your code and configuration
  * Clarity of your written communication and documentation
  * Communicating how your code works in our review session.
  * Communicating how the app runs in our review session.
  * Project presentation.

# Approach

According to the experiment, work is not to exceed 3 total hours, therefore I have sub-divided the total budget into 30 minute micro-sprints, with a total of 5 micro-sprints to complete the work on budget, upon which, the project will be submitted.

# Assumptions

- Our roadmap is not cloud agnostic.
- We lean towards CDK over Terraform.
- It's really important to control this process thru an entry script, in comparision to, some hosted CI Saas tooling (eg. GitHub Actions).
- Assuming bash shell scripts are appropriate selection (_as per TS, node, etc._).
- Adhoc/sandbox creds are throw away credentials but they should be approached programmatically as if they actually are sensitive values, as, ultimatly, they become patterns that are developed over time as containers are bootstrapped in the beginning phases of Day 0 Ops.

# Reasoning

- Upon implementation and evalaution of the following environmental variables, we can validate that the secrets are being passed into the ephermeral environment. When the secrets are being passed into the query string, this is acceptable for a development environment with short-lived credentials, but we would not want this approach for production as per [CWE-598](https://cwe.mitre.org/data/definitions/598.html), and in those scenerios, we would be pulling from a vault within in an air-gapped build and deploy environment, but for sandbox purposes, this approach is fine for a POC with throw-away creds established for short-lived purposes, such as technical evalautions.

# Timeline

#### Sprint 0

Reading readme.md, reading over the Dockerfiles, validating access, etc.

#### Sprint 1

  * Re-reading readme.md, installing some tooling such as CDK and AWS CLI; prepping environment, validating non-UI access with API keys, etc, testing provisioned sandbox account with some basic commands.

  * Researching `youyo/aws-cdk-github-actions@v2.1.1`, deciding not to go the GitHub Actions route (_which actually might be way less code overall and a bit more integrated into a GitOps flow_), and instead lean into the single script approach mentioned in the challenge.

#### Sprint 2

###### Notes

- Main branch protected, continuing work on `chore/shell-scripts`. Setting up Dockerfile for ephermeral environment (build dependencies, etc).

- In favor of the single script approach, A little `x-www-browser` function has been used to instanciate the ephermeral environment (using Gitpod, which is a hosted Dockerfile with the IDE integration thru VS Code).

- We'll need to pass some environmental variables to our new environment.

- Following the query string reference provided on GitPod.io 
```
https://gitpod.io/#/n
un=__username,pw=__password,aki=__access__key__id,sak=__secret__access__key//n
https://github.com/mhackersu/aws-platform-assessment
```
```
un="User name"
pw="Password"
aki="Access key ID"
sak="Secret access key"
```

- Miller, which is being used to read the csv with the supplied creds, is being piped to JQ which gives us nicely formatted JSON which we can easily query.

>`mlr --c2j --jlistwrap cat ../../mike-creds.csv | jq`

- The script will provide us with an assembled URL in which we may reference our new ephermeral environment and in which credentials from outside the repository in a csv, may be read into the new envrionment and set as environmental variables that are also secrets.

- Adding a little dove-tailing for future prd things. ```(:```

- Should have everything ready to start serving up some backend over https on the public 0.0.0.0 *

#### Sprint 3

#### Sprint 4

#### Sprint 5

# Research

- [Some nice CDK/ECR Docker publish patterns](https://github.com/pahud/gitpod-workspace/blob/main/.github/workflows/docker-image-publish.yml)

# Hypothesis

# Experiments

- GitHub Actions
- Gitpod
- Localstack

# Demo

Clone this repo

`git clone git@github.com:mhackersu/aws-platform-assessment.git`

## Env Init Script

This script installs `jq` and `miller` that's it. You can install those manually as well if preferred.

```
./inf/.ci-init.sh
```

## Env Launch Script

After dependancies have been loaded, this is the "easy-button" single script that kicks off the build and release processes.

`cd inf && ./.ci_start.sh`

-or-

Follow these steps to launch the environment

- Navigate to the command line
- From the command line, make sure you are at the root directory of this project. You can type `pwd` on a linux terminal to display the current working directory which is a handy way of looking up where you are.
- Navigate to the inf directory. This can be done by typing `cd inf`
- Next, type the following (not including the command substitution $)

`$ .ci-start.sh`

This command will read the credentials from the file supplied and launch a web-browser with a web-version VS Code IDE environment.

In this instance, this project is housed within in a directory above this project directory which contains this project and a csv file with the supplied credentials.

Note: If testing this configuration, as is, it will be important to validate that a csv file is in the directory above this project directoy on a workstation you are running the script from. If this is the case, update the following lines:

- line 4 in `./inf/.ci-start.sh` will need to reflect the proper relational position along with the matching name of the csv file being provided.

## Alternative Launch Button (Experimental)

[![Open in Gitpod](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](http://gitpod.io/#/https://github.com/mhackersu/aws-platform-assessment)

Once your environment has fully launched, within the shell, issue the following to set your credentials.

```
export USERNAME = <username> && \n
export PASSWORD = <password> && \n
export ACCESS_KEY_ID = <access-key-id> && \n
export SECRET_ACCESS_KEY = <secret-access-key>
```

Where the values incapsulated in left and right arrows <> are replaced with your properly intended AWS credentials.
