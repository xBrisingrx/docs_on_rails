json.data @documents do |document|
    json.name document.name
    json.description document.description
    json.category document.document_category.name
    json.expires ( document.expires ) ? 'Si' : 'No'
    json.expiration_type ( document.expires ) ? document.expiration_type.name : ''
    json.days_of_validity ( document.expires ) ? document.days_of_validity : ''
    json.allow_modify_expiration  ( document.allow_modify_expiration ) ? 'Si' : 'No'
    json.observations document.observations
    json.renewal_methodology document.renewal_methodology
    json.monthly_summary ( document.monthly_summary ) ? 'Si' : 'No'
    json.start_date date_format(document.start_date)
    json.end_date date_format(document.end_date)
    json.status status_format( document.active )
    json.actions 'btn'
end