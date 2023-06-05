class NotifyMailer < ApplicationMailer
	default :from => 'alertasvencimientos@transportesetap.com.ar'

	 def vehicles_report
  	attachments['reporte_vehiculos.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"))
    mail( :to => ['mdavid.almiron@gmail.com', 'soporte@maurosampaoli.com.ar', 'marianalemus@transportesetap.com.ar'],
    :subject => 'Informe vehicular' )
  end
end
