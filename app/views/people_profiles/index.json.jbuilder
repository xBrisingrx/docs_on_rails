json.data @people_profiles do |person_profile|
    json.name person_profile.assignated.name
    json.last_name person_profile.assignated.last_name
    json.dni person_profile.assignated.dni
    json.profile person_profile.profile.name
    json.start_date date_format(person_profile.start_date)
    json.end_date date_format(person_profile.end_date)
    json.status status_format( person_profile.active )

    if person_profile.active
      json.actions "#{ link_to '<i class="fa fa-edit"></i>'.html_safe, edit_people_profile_path(person_profile), data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-primary text-white', title: 'Editar' }
                    #{ link_to '<i class="fa fa-trash-o"></i>'.html_safe, modal_disable_person_profile_path(person_profile), 
                        data: {toggle: 'tooltip'}, remote: :true, 
                        class: 'btn btn-sm u-btn-red text-white', title: 'Eliminar' }"
    else 
      json.actions "<button class='btn btn-sm u-btn-orange text-white' 
                      data-toggle='tooltip'
                      title='Reactivar'
                      onclick=''> <i class='fa fa-refresh' aria-hidden='true'></i></button>"
    end
end