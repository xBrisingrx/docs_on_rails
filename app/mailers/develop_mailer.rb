class DevelopMailer < ApplicationMailer
	default from: 'soporte@maurosampaoli.com.ar'

  def welcome_email
    file = Rails.root.join("app/assets/reports/ejemplo_matriz.xlsx")
    attachments["ejemplo_matriz.xlsx"] = File.read(file)
    mail(to: 'soporte@maurosampaoli.com.ar', subject: 'Welcome to My Awesome Site')
  end
end
