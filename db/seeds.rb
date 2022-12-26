document_categories = [ 'General', 'Liquidación de haberes', 'Otros', 'Seguro', 'Sindicato' ]

document_categories.each do |category|
	DocumentCategory.create( name: category )
end

expiration_types = {
	'Semanal': 7,
	'Quincenal': 14,
	'Mensual': 30, 
	'Semestral': 180,
	'Anual': 365,
	'Otro': 0
}

ExpirationType.create( name: 'No vence', days: 0, active: false )
expiration_types.each do |expiration|
	ExpirationType.create( name: expiration[0], days: expiration[1] )
end