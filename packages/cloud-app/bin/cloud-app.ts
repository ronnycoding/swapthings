#!/usr/bin/env node
import * as cdk from "@aws-cdk/core";
import { CloudAppStack } from "../lib/cloud-app-stack";

const app = new cdk.App();
new CloudAppStack(app, "CloudAppStack");
