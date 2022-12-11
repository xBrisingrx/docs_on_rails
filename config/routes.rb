Rails.application.routes.draw do
  root 'main#welcome'
  get 'main/welcome'

  resources :companies, except: [:destroy, :show]
  post 'disable_company', to: 'companies#disable', as: 'disable_company'
end
