module ApplicationHelper
	def active_class(link_path)
	    current_page?(link_path) ? "active" : ""
	end

	def date_format date
		(date) ? date.strftime('%d-%m-%y') : ''
	end

	def status_format status
		( status ) ? '<p class="u-tags-v1 g-color-green g-brd-around g-brd-green g-bg-green-opacity-0_1 g-bg-green--hover g-color-white--hover g-py-2 g-px-5">Activo</p>' 
		: '<p class="u-tags-v1 g-color-pink g-brd-around g-brd-pink g-bg-pink-opacity-0_1 g-bg-pink--hover g-color-white--hover g-py-2 g-px-5">Inactivo</p>'
	end
end
