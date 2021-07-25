module.exports = {
  reactStrictMode: true,
  env: {
    customKey: 'my-value',
    aws: {
      Auth: {
        // REQUIRED only for Federated Authentication - Amazon Cognito Identity Pool ID
        identityPoolId: 'us-east-1:7a9e6baf-fac7-4e6a-b1cf-948d4d53f004',

        // REQUIRED - Amazon Cognito Region
        region: 'us-east-1',

        // OPTIONAL - Amazon Cognito User Pool ID
        userPoolId: 'us-east-1_YoRcteZei',

        // OPTIONAL - Amazon Cognito Web Client ID (26-char alphanumeric string)
        userPoolWebClientId: '2dc2q8d6eek0ggdghmrdnk9v89',

        // OPTIONAL - Enforce user authentication prior to accessing AWS resources or not
        mandatorySignIn: false,

        // OPTIONAL - Configuration for cookie storage
        // Note: if the secure flag is set to true, then the cookie transmission requires a secure protocol
        // cookieStorage: {
        //   // REQUIRED - Cookie domain (only required if cookieStorage is provided)
        //   domain: '.yourdomain.com',
        //   // OPTIONAL - Cookie path
        //   path: '/',
        //   // OPTIONAL - Cookie expiration in days
        //   expires: 365,
        //   // OPTIONAL - See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie/SameSite
        //   sameSite: 'strict',
        //   // OPTIONAL - Cookie secure flag
        //   // Either true or false, indicating if the cookie transmission requires a secure protocol (https).
        //   secure: true,
        // },

        // OPTIONAL - Manually set the authentication flow type. Default is 'USER_SRP_AUTH'
        authenticationFlowType: 'USER_PASSWORD_AUTH',
      },
    },
  },
}
