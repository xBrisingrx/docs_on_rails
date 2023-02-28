Rails.application.routes.draw do
  resources :jobs
  resources :zones
  resources :zone_job_profiles, only: [:new, :create, :edit, :update]
  resources :zone_job_profile_docs, only: [:index,:new, :create, :edit, :update]
  get 'zone_job_profile_docs/:id/modal_disable', to: 'zone_job_profile_docs#modal_disable', as: 'modal_disable_zone_job_profile_docs'
  post 'disable_zone_job_profile_docs', to: 'zone_job_profile_docs#disable', as: 'disable_zone_job_profile_docs'
  resources :vehicles
  resources :vehicle_locations
  resources :vehicle_models
  resources :vehicle_brands
  resources :vehicle_types
  root 'main#welcome'
  get 'main/welcome'

  namespace :authentication, path: '', as: '' do
    resources :users, only: [:index,:new, :create]
    resources :sessions, only: [:create]
    get 'login', to: 'sessions#new', as: 'login'
    get 'logout', to: 'sessions#destroy', as: 'logout'
  end
  
  get 'person_dato_disponible', to: 'people#dato_disponible', as: 'person_dato_disponible'
  get '/people/:id/upload_person_file/:file', to: 'people#upload_person_file', as: 'upload_person_file'
  resources :people, except: [:destroy]
  post 'disable_person', to: 'people#disable', as: 'disable_person'
  get 'inactive_people', to: 'people#inactives', as: 'inactive_people'
  get 'people/:id/show_person_history', to: 'people#show_person_history', as: 'show_person_history'
  get 'people/:id/modal_enable_person', to: 'people#modal_enable_person', as: 'modal_enable_person'
  post 'people/enable_person', to: 'people#enable_person', as: 'enable_person'
  resources :companies, except: [:destroy, :show]
  post 'disable_company', to: 'companies#disable', as: 'disable_company'
  resources :profiles, except: [:destroy, :show]
  post 'disable_profile', to: 'profiles#disable', as: 'disable_profile'
  resources :documents
  post 'disable_document', to: 'documents#disable', as: 'disable_document'
  resources :document_categories
  resources :expiration_types
  
  get 'documents_profiles/:id/modal_disable', to: 'documents_profiles#modal_disable', as: 'modal_disable_document_profile'
  resources :documents_profiles, except: [:destroy, :show]
  post 'disable_document_profile', to: 'documents_profiles#disable', as: 'disable_document_profile'
  
  resources :people_profiles, except: [:destroy, :show] do 
    get 'modal_disable'
  end
  resources :assignments_profiles, except: [:index, :destroy]
  post 'disable_assignment_profile', to: 'assignments_profiles#disable', as: 'disable_assignment_profile'
  resources :assignments_documents, except: [:index, :destroy]

  get 'status_documentation/people'
  get 'status_documentation/vehicules'

  resources :document_renovations do 
    get 'show_files'
  end
  post 'disable_document_renovation', to: 'document_renovations#disable', as: 'disable_document_renovation'

  resources :reasons_to_disables, except: [:destroy, :show]
  post 'disable_reason', to: 'reasons_to_disables#disable', as: 'disable_reason'
end
