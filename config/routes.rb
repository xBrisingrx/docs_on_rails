Rails.application.routes.draw do
  root 'main#welcome'
  get 'main/welcome'

  get 'person_dato_disponible', to: 'people#dato_disponible', as: 'person_dato_disponible'
  get '/people/:id/upload_person_file/:file', to: 'people#upload_person_file', as: 'upload_person_file'
  resources :people, except: [:destroy]
  post 'disable_person', to: 'people#disable', as: 'disable_person'
  resources :companies, except: [:destroy, :show]
  post 'disable_company', to: 'companies#disable', as: 'disable_company'
  resources :profiles, except: [:destroy, :show]
  post 'disable_profile', to: 'profiles#disable', as: 'disable_profile'
end
