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
  get "/ranking/soft", action: :show_soft, controller: "ranking"
  get "/ranking/soft/1", action: :show_soft_1, controller: "ranking"
  get "/ranking/soft/2", action: :show_soft_2, controller: "ranking"
  get "/ranking/soft/3", action: :show_soft_3, controller: "ranking"
  get "/ranking/hard", action: :show_hard, controller: "ranking"
  get "/ranking/hard/1", action: :show_hard_1, controller: "ranking"
  get "/ranking/hard/2", action: :show_hard_2, controller: "ranking"
  get "/ranking/hard/3", action: :show_hard_3, controller: "ranking"
  resources :entries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'entries#index'
end
