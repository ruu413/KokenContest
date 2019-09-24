Rails.application.routes.draw do
  resources :evaluations ,except:[:new,:create,:edit]
  get "/evaluations/:id/new", action: :new, controller: "evaluations"
  post "/evaluations/:id", action: :create, controller: "evaluations"
  get "/admin", action: :index, controller: "admin"
  post "/admin", action: :update, controller: "admin"
  get "/ranking", action: :index, controller: "ranking"
  get "/ranking/1", action: :show1, controller: "ranking"
  get "/ranking/2", action: :show2, controller: "ranking"
  get "/ranking/3", action: :show3, controller: "ranking"
  resources :entries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'entries#index'
end
