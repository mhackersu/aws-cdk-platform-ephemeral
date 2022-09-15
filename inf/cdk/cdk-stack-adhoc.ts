// cdk-stack-adhoc.ts

import * as cdk from 'aws-cdk-lib';
import { aws_s3 as s3 } from 'aws-cdk-lib';

export class CdkStackAdhoc extends cdk.Stack {
  constructor(scope: cdk.App, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, 'AdhocBucket', {
      versioned: true
    });
  }
}