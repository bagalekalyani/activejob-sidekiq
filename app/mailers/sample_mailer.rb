class SampleMailer < ActionMailer::Base
  default from: "info@drnowmobile.com"

  def sample_email(email)
    mail(to: email, subject: 'Test New Email')
  end
end
