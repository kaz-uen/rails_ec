# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_FROM', 'postmaster@sandbox0bf65d00c19f473986582bf32e38923e.mailgun.org')
  layout 'mailer'
end
