json.data @documents do |document|
	json.document document.document.name
	json.category document.document.category.name
	json.start_date date_format(document.start_date)
	json.end_date date_format(document.end_date)
end