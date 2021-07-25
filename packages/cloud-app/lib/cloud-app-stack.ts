import * as cdk from "@aws-cdk/core";
import * as cognito from "@aws-cdk/aws-cognito";

const stackName = "SwapThings";

export class CloudAppStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here

    // Add the cognito identity pool
    const userPool = new cognito.UserPool(this, "userPool", {
      accountRecovery: cognito.AccountRecovery.EMAIL_ONLY,
      emailSettings: {
        // from: "noreply@ronnyiscoding.io",
        replyTo: "noreply@ronnyiscoding.io",
      },
      passwordPolicy: {
        minLength: 8,
        requireUppercase: true,
        requireLowercase: true,
      },
      selfSignUpEnabled: true,
      signInCaseSensitive: true,
      userPoolName: `${stackName}-user-pool`,
      userVerification: {
        emailBody:
          "{username}, your account has been created. Please verify it by clicking the link below. {##Verify Email##}",
        emailStyle: cognito.VerificationEmailStyle.LINK,
        emailSubject: "Verify your account",
      },
    });

    // Add the user pool client
    const userPoolClient = new cognito.UserPoolClient(this, "UserPoolClient", {
      userPool,
      accessTokenValidity: cdk.Duration.hours(1),
      authFlows: {
        userPassword: true,
      },
      refreshTokenValidity: cdk.Duration.days(1),
      userPoolClientName: `${stackName}-user-pool-client`,
    });

    const identityPool = new cognito.CfnIdentityPool(this, "IdentityPool", {
      allowUnauthenticatedIdentities: false, // Don't allow unathenticated users
      cognitoIdentityProviders: [
        {
          clientId: userPoolClient.userPoolClientId,
          providerName: userPool.userPoolProviderName,
        },
      ],
    });

    // Export values
    new cdk.CfnOutput(this, "UserPoolId", {
      value: userPool.userPoolId,
    });
    new cdk.CfnOutput(this, "UserPoolClientId", {
      value: userPoolClient.userPoolClientId,
    });
    new cdk.CfnOutput(this, "IdentityPoolId", {
      value: identityPool.ref,
    });
  }
}
