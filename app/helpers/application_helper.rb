module ApplicationHelper
	def active_class(link_path)
	    current_page?(link_path) ? "active" : ""
	end

	def date_format date
		date.strftime('%d-%m-%y')
	end
end
