class Report < ApplicationRecord
	
	def self.set_color date
		# byebug
		green = '32CD32'
		yellow = 'FFFF00'
		orange = 'FF4500'
		red = 'FF0000'
		white = 'FFFFFF'

		return 	white if date.blank?
		return white if date == 'code'
		return white if date == 'file'
		return white if date == 'fullname'
		return white if date == '---'
		return red if date == 'No cargado'
		return green if date == 'Cargado'

		today = Date.today
		# expire_date = Date.parse(date)
		expire_date = Date.strptime(date, '%d-%m-%y')
		diff = expire_date - today

		if diff < 1
			return red
		end

		if diff >= 1 && diff <= 15
			return orange
		end

		if diff >= 16 && diff <= 30
			return yellow
		end

		if diff > 30
			return green
		end

	end

	def self.email_report
		NotifyMailer.vehicles_report().deliver_later
	end
end
