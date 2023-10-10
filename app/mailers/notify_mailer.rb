class NotifyMailer < ApplicationMailer
	default :from => 'alertasvencimientos@transportesetap.com.ar'

	#  def vehicles_report
  # 	attachments['reporte_vehiculos.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"))
  #   attachments['reporte_personas.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_personas.xlsx"))
  #   mail( :to => ['karinasinches@transportesetap.com.ar',
  #                 'orlandoalfieri@transportesetap.com.ar',
  #                 'marinadiazvega@transportesetap.com.ar',
  #                 'sebastianmoreno@transportesetap.com.ar',
  #                 'adminlogistica@transportesetap.com.ar',
  #                 'logistica@transportesetap.com.ar',
  #                 'nestorpierguidi@transportesetap.com.ar',
  #                 'jaimevelasquez@transportesetap.com.ar',
  #                 'nestorpretzsch@transportesetap.com.ar',
  #                 'rrhhneuquen@transportesetap.com.ar',
  #                 'gerencianeuquen@transportesetap.com.ar',
  #                 'jefeoperacionesnqn@transportesetap.com.ar',
  #                 'nestornohra@transportesetap.com.ar',
  #                 'florenciabarreiro@transportesetap.com.ar',
  #                 'delfincurapil@yahoo.com.ar',
  #                 'andrearamos@transportesetap.com.ar',
  #                 'etap@transportesetap.com.ar',
  #                 'marianalemus@transportesetap.com.ar',
  #                 'mdavid.almiron@gmail.com'],
  #   :subject => 'Informe semanal' )
  # end

  def vehicles_report
    attachments['reporte_vehiculos.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_vehiculos.xlsx"))
    attachments['reporte_personas.xlsx'] = File.read( Rails.root.join("app/assets/reports/reporte_personas.xlsx"))
    mail( :to => ['mdavid.almiron@gmail.com', 'sistema.etap@maurosampaoli.com.ar'],
    :subject => 'Informe semanal' )
  end
  
end


