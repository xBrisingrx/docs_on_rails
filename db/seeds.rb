# document_categories = [ 'General', 'Liquidación de haberes', 'Otros', 'Seguro', 'Sindicato' ]

# document_categories.each do |category|
# 	DocumentCategory.create( name: category )
# end

# expiration_types = {
# 	'Semanal': 7,
# 	'Quincenal': 14,
# 	'Mensual': 30,
# 	'Cuatrimestral': 120,
# 	'Semestral': 180,
# 	'Anual': 365,
# 	'Otro': 0
# }

# ExpirationType.create( name: 'No vence', days: 0, active: false )
# expiration_types.each do |expiration|
# 	ExpirationType.create( name: expiration[0], days: expiration[1] )
# end

# User.create(name: 'David', username: 'david', email: 'david@devtester.com', password: 'asdasd', rol:1)

# reasons_to_disable = [
# 	{ reason: 'ACUERDO DE PARTES', description: 'ACUERDO DE PARTES', d_type: 1 },
# 	{ reason: 'Baja UOCRA', description: 'Despido Ley 22250', d_type: 1 },
# 	{ reason: 'Cesion de Personal', description: '', d_type: 1 },
# 	{ reason: 'Despido', description: '', d_type: 1 },
# 	{ reason: 'Despido periodo a prueba', description: 'Periodo a Prueba', d_type: 1 },
# 	{ reason: 'Enfermedad', description: '', d_type: 1 },
# 	{ reason: 'Fallecimiento', description: 'Baja por Fallecimiento', d_type: 1 },
# 	{ reason: 'Fin de Contrato', description: 'FINALIZACION DE CONTRATO A PLAZO', d_type: 1 },
# 	{ reason: 'Jubilación', description: '', d_type: 1 },
# 	{ reason: 'Renuncia', description: '', d_type: 1 },
# 	{ reason: 'Sin motivo', description: '', d_type: 1 },
# 	{ reason: 'Venta', description: '', d_type: 2 },
# 	{ reason: 'Destrucción', description: '', d_type: 2 }
# ]

# reasons_to_disable.each do |r|
# 	ReasonsToDisable.create(reason: r[:reason], d_type: r[:d_type], description: r[:description])
# end

# vehicles_types = [ 'Automóvil', 'Camión', 'Camioneta', 'Trans. de pasajeros', 'Omnibus', 'Cuatriciclo', 'Descapotable', 'Motorhome', 'Motocicleta', 'Acoplado' ]

# vehicles_types.each do |type| 
# 	VehicleType.create( name: type )
# end 

# vehicles_brands = ['Agrale','Comil','Ford','Hyundai','Iveco','Marcopolo','Mercedes Benz','Scania','Toyota','Volkswagen','Volvo','FORD A','YAMAHA','CHRYSLER','BMW','HONDA','FIAT','RUBIOLO']
# vehicles_brands.each do |brand| 
# 	VehicleBrand.create( name: brand )
# end 

# vehicle_models = [
# { name: '003-MA 8.5/PIA', vehicle_brand_id: 1},
# { name: '915', vehicle_brand_id: 1},
# { name: 'MA 8.5', vehicle_brand_id: 1},
# { name: 'MA 8.5 PIA', vehicle_brand_id: 1},
# { name: 'MA 8.5 TCA', vehicle_brand_id: 1},
# { name: '915', vehicle_brand_id: 2},
# { name: 'CARGO 1722', vehicle_brand_id: 3},
# { name: 'CARGO 1831 TRACTOR CARRETERA', vehicle_brand_id: 3},
# { name: 'F-100 4X4', vehicle_brand_id: 3},
# { name: 'Ranger CD 4x2', vehicle_brand_id: 3},
# { name: 'Ranger CD 4x4', vehicle_brand_id: 3},
# { name: 'Ranger CS 4x2', vehicle_brand_id: 3},
# { name: 'Ranger CS 4x4', vehicle_brand_id: 3},
# { name: 'H1', vehicle_brand_id: 4},
# { name: 'DAILY 50C 16 PASO 3950', vehicle_brand_id: 5},
# { name: 'VOLARE W8', vehicle_brand_id: 6},
# { name: '0-400 RSD', vehicle_brand_id: 7},
# { name: '813 - O - 500 RS', vehicle_brand_id: 7},
# { name: '814 - O-500 RSD', vehicle_brand_id: 7},
# { name: 'BMO 384 1418 52 CM', vehicle_brand_id: 7},
# { name: 'BMO 390 VS 1621 L/59', vehicle_brand_id: 7},
# { name: 'CAMPIONE', vehicle_brand_id: 7},
# { name: 'EL BUS 340', vehicle_brand_id: 7},
# { name: 'O-400 RSE', vehicle_brand_id: 7},
# { name: 'O-500 M', vehicle_brand_id: 7},
# { name: 'O-500 M 30', vehicle_brand_id: 7},
# { name: 'O-500 R3', vehicle_brand_id: 7},
# { name: 'O-500 RS', vehicle_brand_id: 7},
# { name: 'O-500 RS 1836/30', vehicle_brand_id: 7},
# { name: 'O-500 RSD', vehicle_brand_id: 7},
# { name: 'O-500 RSD 6X2', vehicle_brand_id: 7},
# { name: 'OF 1721', vehicle_brand_id: 7},
# { name: 'PIA', vehicle_brand_id: 7},
# { name: 'PIA LO 915', vehicle_brand_id: 7},
# { name: 'SPRINTER 313 CDI/C 3550', vehicle_brand_id: 7},
# { name: 'SPRINTER 413 CDI C / 4025', vehicle_brand_id: 7},
# { name: 'SPRINTER 415 CDI/C 4325', vehicle_brand_id: 7},
# { name: 'SPRINTER 515 CDI/C 4325', vehicle_brand_id: 7},
# { name: 'K94 IB', vehicle_brand_id: 8},
# { name: 'COROLLA XLI 1.8 M/T', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 C/D DX PACK 2.5 TD', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 C/D SR 3.0 TDI', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 C/D SR C/AB 3.0 TDI', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 C/D SR C/AQB 3.0 TDI', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 C/D SRV 3.0 TDI', vehicle_brand_id: 9},
# { name: 'HILUX LN 3.0 D/C 4X4 TDI', vehicle_brand_id: 9},
# { name: '17.240 OT/ ALLEGRO', vehicle_brand_id: 10},
# { name: '249 - 17220', vehicle_brand_id: 10},
# { name: '319 - 13.180', vehicle_brand_id: 10},
# { name: '9.150 OD', vehicle_brand_id: 10},
# { name: 'PIA 9.150 EOD', vehicle_brand_id: 10},
# { name: 'SPRINTER 416 CDI MICROMNIBUS', vehicle_brand_id: 7},
# { name: 'PARADISO 1800DD', vehicle_brand_id: 7},
# { name: '180 E-33', vehicle_brand_id: 5},
# { name: 'HILUX 4X4 D/C DX 2.4 TDI 6', vehicle_brand_id: 9},
# { name: 'OF 1724', vehicle_brand_id: 7},
# { name: '1517', vehicle_brand_id: 3},
# { name: '0-500 RSD 2436/30', vehicle_brand_id: 7},
# { name: 'LO 916', vehicle_brand_id: 7},
# { name: 'SAVEIRO 1.6', vehicle_brand_id: 10},
# { name: 'HILUX L/16 2.8 DC 4X4 TDI SRX', vehicle_brand_id: 9},
# { name: 'CARGO 1729-37 CD MT', vehicle_brand_id: 3},
# { name: 'HILUX 4X4 D/C SR 2.8 TDI 6', vehicle_brand_id: 9},
# { name: 'SPRINTER 515', vehicle_brand_id: 7},
# { name: 'BMO 688 VERSION 915 42.5 CM', vehicle_brand_id: 7},
# { name: 'OF 1722', vehicle_brand_id: 7},
# { name: '20-170 E22', vehicle_brand_id: 5},
# { name: 'CARGO 1517', vehicle_brand_id: 3},
# { name: '0 500 M', vehicle_brand_id: 7},
# { name: 'O 500 M 1826/30 VIAGGIO G7 1050', vehicle_brand_id: 7},
# { name: 'O 500 RSD 2436/30 / PARADISO 1800DD', vehicle_brand_id: 7},
# { name: 'DAILY 70C17 PASO 4350 SCUDATO', vehicle_brand_id: 5},
# { name: 'HILUX 4X4 D/C SRV 2.8 TDI 6 M/T', vehicle_brand_id: 9},
# { name: 'ESCOSPORT SE 1,5 L', vehicle_brand_id: 3},
# { name: 'doble piso mixto', vehicle_brand_id: 11},
# { name: 'SPRINTER 516 CDI MIDIBUS 4325', vehicle_brand_id: 7},
# { name: 'SPRINTER 415CDI-C 3665', vehicle_brand_id: 7},
# { name: 'A-1929', vehicle_brand_id: 12},
# { name: 'YFM700 FWAD', vehicle_brand_id: 13},
# { name: 'YFZ 450 R SPECIAL EDITION', vehicle_brand_id: 13},
# { name: 'MUSTANG', vehicle_brand_id: 3},
# { name: 'F150 RAPTOR 3,5L V6 ECOBOOST 4X4 AT', vehicle_brand_id: 3},
# { name: 'BRONCO SPORT BIG BEND 1,5L', vehicle_brand_id: 3},
# { name: 'DAKOTA', vehicle_brand_id: 14},
# { name: 'X5  4.8I', vehicle_brand_id: 15},
# { name: 'HONDA CR-V EXL', vehicle_brand_id: 16},
# { name: 'PALIO ADVENTURE 1,8 MPI V8', vehicle_brand_id: 17},
# { name: 'NEW BEETLE 2.0 L', vehicle_brand_id: 10},
# { name: 'COROLLA', vehicle_brand_id: 9},
# { name: 'FOX 1.6', vehicle_brand_id: 10},
# { name: 'HONDA CRV - LX', vehicle_brand_id: 16},
# { name: '325 I COUPE', vehicle_brand_id: 15},
# { name: 'K 112 6X2 S 31 (MOTORHOME)', vehicle_brand_id: 8},
# { name: 'FZ 16', vehicle_brand_id: 13},
# { name: 'ATEGO 1721', vehicle_brand_id: 7},
# { name: 'A304', vehicle_brand_id: 18},
# { name: 'CARGO 1729 - 37 CN MT', vehicle_brand_id: 3},
# { name: 'JUM BUSS 360', vehicle_brand_id: 7},
# { name: 'SPRINTER 515 CDI-C 4325 TE', vehicle_brand_id: 7},
# { name: 'DAILY 50C16 PASO 3950 VIDRIADO', vehicle_brand_id: 5},
# { name: 'SPRINTER 516 CDI 4325', vehicle_brand_id: 7},
# { name: 'SPRINTER 416 CDI 3665', vehicle_brand_id: 7},
# { name: '0170 / 55', vehicle_brand_id: 7},
# { name: 'O 400 RSD', vehicle_brand_id: 7},
# { name: 'O 500 M', vehicle_brand_id: 7},
# { name: 'ANDARE CLASE', vehicle_brand_id: 7},
# { name: 'O 500 RSD', vehicle_brand_id: 7},
# { name: 'SPRINTER 413 CDI/C 4025', vehicle_brand_id: 7},
# { name: 'SPRINTER 515 CDI/C 4325 TE', vehicle_brand_id: 7},
# { name: 'ANDARE CLASS', vehicle_brand_id: 7},
# { name: 'O 500 RS', vehicle_brand_id: 7},
# { name: 'HILUX 4X4 D/C SR 2.8 TDI 6 M/T', vehicle_brand_id: 9},
# { name: 'EL BUSS 340', vehicle_brand_id: 7},
# { name: 'HILUX 4X4 CABINA DOBLE SRV 3.0 TDI C/CUERO', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 CABINA DOBLE SRV 3.0 TDI', vehicle_brand_id: 9},
# { name: 'PIA', vehicle_brand_id: 1},
# { name: 'HILUX 4X4 CABINA DOBLE SR C/AQB 3.0 TDI', vehicle_brand_id: 9},
# { name: 'HILUX 4X4 CABINA DOBLE SR C/AB 3.0 TDI', vehicle_brand_id: 9}
# ]

# vehicle_models.each do |m|
# 	VehicleModel.create( name: m[:name], vehicle_brand_id: m[:vehicle_brand_id] )
# end
# companies = [
# 	{ id: 1, name: 'Etap SRL', d_type: 1}, 	
# 	{ id: 2, name: 'Costa', d_type: 1},
# 	{ id: 5, name: 'Alenco/Etap', d_type: 2},
# 	{ id: 6, name: 'Alenco/Etap', d_type: 2},
# 	{ id: 7, name: 'Bco. Patagonia/Etap', d_type: 2},
# 	{ id: 8, name: 'CGM Leasing/Etap', d_type: 2},
# 	{ id: 9, name: 'Chiramberro', d_type: 2},
# 	{ id: 10, name: 'DE LA COSTA', d_type: 2}, 	
# 	{ id: 11, name: 'Darbus', d_type: 2},
# 	{ id: 12, name: 'ETAP', d_type: 2}, 	
# 	{ id: 13, name: 'Giobbi', d_type: 2},
# 	{ id: 14, name: 'Leasing/Etap', d_type: 2},
# 	{ id: 15, name: 'Nacion Leasing/Etap', d_type: 2},
# 	{ id: 16, name: 'ON TTE', d_type: 2}, 	
# 	{ id: 17, name: 'Patagonia Expeditions', d_type: 2},
# 	{ id: 18, name: 'Quimey Tours', d_type: 2},
# 	{ id: 19, name: 'SOMBRERITO', d_type: 2}, 	
# 	{ id: 20, name: 'Toyota Leasing/Etap', d_type: 2},
# 	{ id: 21, name: 'Ventur', d_type: 2},
# 	{ id: 22, name: 'Agrog El Sombrerito SA', d_type: 1}, 	
# 	{ id: 23, name: 'HOTEL WAM', d_type: 1}, 	
# 	{ id: 24, name: 'TRANSAUSTRAL BUS LTDA', d_type: 1}, 	
# 	{ id: 25, name: 'TYMRUK', d_type: 2}, 	
# 	{ id: 26, name: 'Vargas Pablo', d_type: 2}, 	
# 	{ id: 27, name: 'Romero  Autos SRL', d_type: 2}, 	
# 	{ id: 28, name: 'Leasing costa', d_type: 2}, 	
# 	{ id: 29, name: 'Dallas Oil SA', d_type: 2}, 	
# 	{ id: 30, name: 'LA UNION', d_type: 1}, 	
# 	{ id: 31, name: 'CONTACTOS TRAVEL SRL', d_type: 1}, 	
# 	{ id: 32, name: 'SILVI, ANGEL ALBERTO', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 33, name: 'VIAJES Y TURISMO MENDITUR SRL', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 34, name: 'DM SERVICIO PETROLEROS SRL', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 35, name: 'SIN FRONTERAS TRAVEL', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 36, name: 'LUNA LUIS', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 37, name: 'CLAUDIO ZELARAYAN', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 38, name: 'VILLAFAÑE MARIA', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 39, name: 'SIN TRANSFERIR', d_type: 2}, 	
# 	{ id: 40, name: 'SERGIO LARREGUY', d_type: 2}, 	
# 	{ id: 41, name: 'LA UNION / LEASING', d_type: 2}, 	
# 	{ id: 42, name: 'ANGEL GIOBBI', d_type: 2}, 	
# 	{ id: 43, name: 'ARCAR', d_type: 2, description: 'UNIDADES ALQUILADAS'}, 	
# 	{ id: 44, name: 'GARCIA OSCAR DANIEL', d_type: 2}, 	
# 	{ id: 45, name: 'ORELLANA CASTILLO ONOFRE ELIZANDRO', d_type: 2}, 	
# 	{ id: 46, name: 'N/C', d_type: 2}, 	
# 	{ id: 47, name: 'IGLESIAS CARLOS JOSE', d_type: 2}, 	
# 	{ id: 48, name: 'LARREGUY CARLOS FERNANDO', d_type: 2}, 	
# 	{ id: 49, name: 'VARGAS TOLEDO PABLO ERNESTO', d_type: 2}, 	
# 	{ id: 50, name: 'STEKLI SARITA SENOBIA', d_type: 2, description: 'CONTACTOS TRAVEL'},
# 	{ id: 51, name: 'TAPITI', d_type: 2}, 	
# 	{ id: 52, name: 'LARREGUY SERGIO LAVIE', d_type: 2}, 	
# 	{ id: 53, name: 'NORMA MILONE', d_type: 2}, 	
# 	{ id: 54, name: 'SUPERSERVICIOS SRL', d_type: 2}, 	
# 	{ id: 55, name: 'VERA MARIA GABRIELA', d_type: 2}, 	
# 	{ id: 56, name: 'CONTACTOS TRAVEL SRL', d_type: 2}, 	
# 	{ id: 57, name: 'ALONSO OSCAR NELSON', d_type: 2}, 	
# ]

#  companies.each do |m|
#  	Company.create( id: m[:id],name: m[:name], d_type: m[:d_type], description: m[:description] )
#  end

# zones = [ 'Chubut', 'Santa Cruz Norte', 'Santa Cruz Sur', 'Neuquén' ]
# zones.each do |z|
# 	Zone.create( name: z )
# end

functions = [
	{ code: '01', name: 'Operaciones'},
	{ code: '02', name: 'Mantenimiento'},
	{ code: '03', name: 'Comercialización'},
	{ code: '04', name: 'Administración'},
	{ code: '05', name: 'Planeamiento'},
	{ code: '06', name: 'Gerencia general'}
]

functions.each do |r|
	Function.create(code: r[:code], name: r[:name])
end

unit_business = [
	{ code: '00', name: 'Holding'},
	{ code: '01', name: 'Transporte de personal'},
	{ code: '02', name: 'Alquiler de unidades'},
	{ code: '03', name: 'Cargas'},
	{ code: '04', name: 'Servicios a terceros'},
	{ code: '05', name: 'Linea y piquetería'},
	{ code: '06', name: 'Viajes especiales'},
	{ code: '07', name: 'Campo'},
	{ code: '08', name: 'Hotel y restó'},
	{ code: '09', name: 'Hormigon'},
	{ code: '10', name: 'Alquiler de inmuebles'}
]

unit_business.each do |r|
	UnitBusiness.create(code: r[:code], name: r[:name])
end

geographic_zones = [
	{ name: 'Holding'},
	{ name: 'Chubut y Santa Cruz Norte'},
	{ name: 'Santa Cruz Sur'},
	{ name: 'Neuquen'}
]

geographic_zones.each do |r|
	GeographicZone.create(name: r[:name])
end


sub_zones = [
	{ code: '00', name: 'Holding', geographic_zone_id: 1},
	{ code: '01', name: 'Comodoro Rivadavia', geographic_zone_id: 2},
	{ code: '02', name: 'Baltazar', geographic_zone_id: 2},
	{ code: '03', name: 'Caleta Olivia', geographic_zone_id: 2},
	{ code: '04', name: 'Las Heras', geographic_zone_id: 2},
	{ code: '05', name: 'Los Perales', geographic_zone_id: 2},
	{ code: '06', name: 'Sarmiento', geographic_zone_id: 2},
	{ code: '07', name: 'Esquel', geographic_zone_id: 2},
	{ code: '08', name: 'Gobernador Costa', geographic_zone_id: 2},
	{ code: '09', name: 'Rio Mayo', geographic_zone_id: 2},
	{ code: '10', name: 'Rio Senguer', geographic_zone_id: 2},
	{ code: '11', name: 'Rio Gallegos', geographic_zone_id: 3},
	{ code: '12', name: 'Neuquen', geographic_zone_id: 4},
	{ code: '13', name: 'Puerto Deseado', geographic_zone_id: 2},
]

sub_zones.each do |r|
	SubZone.create(code: r[:code], name: r[:name], geographic_zone_id: r[:geographic_zone_id])
end


clients = [
	{ name: 'Etap',},
	{ name: 'Pecom',},
	{ name: 'Taller',},
	{ name: 'Backup',},
	{ name: 'YPF',},
	{ name: 'EDVSA',},
	{ name: 'CGC',}
]

clients.each do |r|
	Client.create(name: r[:name])
end

operators = [
	{ name: 'YPF',},
	{ name: 'Nación',},
	{ name: 'CGC',},
	{ name: 'Enap',},
	{ name: 'PAE',},
	{ name: 'Chubut',},
	{ name: 'SHELL',}
]

operators.each do |r|
	Operator.create(name: r[:name])
end

list_states_vehicles = [
	{ name: 'Reparación',},
	{ name: 'Campo',},
	{ name: 'Fuera de modelo',},
	{ name: 'Servicio',},
	{ name: 'Disponible',},
	{ name: 'Staff',}
]

list_states_vehicles.each do |r|
	ListStatesVehicle.create(name: r[:name])
end