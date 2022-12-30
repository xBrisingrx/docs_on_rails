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
  resources :documents
  post 'disable_document', to: 'documents#disable', as: 'disable_document'
  resources :document_categories
  resources :expiration_types
  
  get 'documents_profiles/:id/modal_disable', to: 'documents_profiles#modal_disable', as: 'modal_disable_document_profile'
  resources :documents_profiles, except: [:destroy, :show]
  post 'disable_document_profile', to: 'documents_profiles#disable', as: 'disable_document_profile'
  
  resources :people_profiles, except: [:destroy, :show]
  get 'people_profiles/:id/modal_disable', to: 'people_profiles#modal_disable', as: 'modal_disable_person_profile'
end
