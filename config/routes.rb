Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  resource :session, only: %i[new create destroy], controller: :session
  resources :teachers, only: %i[new create]
  resources :courses, only: %i[index show new create]
  resources :teacher_courses, only: %i[create destroy]
end
