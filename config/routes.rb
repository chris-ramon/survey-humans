SurveyHuman::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  devise_for :users

  namespace :account_management do
    resources :user do
      get :dashboard, :on => :collection
      get :account_panel, :on => :collection
      get :export_to_spreadsheet, :on => :collection
    end
    resources :profile
    resources :log
    resources :company
  end

  namespace :match_management do
    resources :match do 
      get :match_panel, :on => :collection
    end
    resources :match_type
    resources :question
    resources :question_level
    resources :question_type
    resources :exam_topic
    resources :answer
    resources :answer_format
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  root :controller=>"account_management/user", :action=>"dashboard"

end
