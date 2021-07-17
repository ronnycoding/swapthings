const forgotPasswordTemplate = require("./email-templates/forgot-password");

module.exports = ({ env }) => ({
  host: env("HOST", "0.0.0.0"),
  port: env.int("PORT", 1337),
  admin: {
    auth: {
      secret: env("ADMIN_JWT_SECRET", "cf37b981bfece203855bd44cdd0fadfa"),
    },
    forgotPassword: {
      from: env("MAIL_FROM"),
      replyTo: env("MAIL_REPLY_TO"),
      emailTemplate: forgotPasswordTemplate,
    },
  },
});
