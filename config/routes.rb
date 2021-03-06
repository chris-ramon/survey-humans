SurveyHuman::Application.routes.draw do

  resources :courses

  namespace :panel do resources :organizations end
  namespace :panel do resources :organization_invitations end

  get "report/index"
  namespace :panel do resources :subscription_transactions end

  get "/gateways/update-default-gateway/:id/:task", :to => "panel/gateways#update_default_gateway" ,\
  :as => 'update_default_gateway'

  get "/organization-invitation/update-status/:id/:status",
      :to => "panel/organization_invitations#update_status",
      :as => 'organization_invitation_update_status'

  post "/panel/deals/send-deal",
    :to => "panel/deals#send_deal",
    :as => 'send_deal'

  namespace :panel do
    resources :gateways do
    end
  end

  namespace :panel do resources :planfeatures end

  namespace :panel do resources :features end

  namespace :panel do resources :subscriptions end

  namespace :panel do resources :deals end

  namespace :panel do resources :plans end

  namespace :panel do resources :billings end

  resources :countries

  get "survey/index"

  get "front/sign_up"

  get "payment_notification/create"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  #devise_for :users
  devise_for :users, :path => "", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }, :controllers => { :confirmations => "confirmations" }

  devise_scope :user do
    get "sign_in", :to => "devise/sessions#new"
    get "home", :to => "devise/sessions#homepage"
    get "sign_up", :to => "devise/registrations#new"
  end

  namespace :account_management do
    resources :user do
      get :dashboard, :on => :collection
      get :account_panel, :on => :collection
      get :export_to_spreadsheet, :on => :collection
      post :create_user_by_sign_up, :on => :collection
    end
    resources :profile
    resources :log
    resources :company
  end

  namespace :match_management do
    resources :match do 
      get :match_panel, :on => :collection
      get :show_matches_by_match_type, :on => :collection
    end
    resources :survey do
      delete :delete_question, :on=>:collection
      delete :delete_answer, :on=>:collection
      get :generate_url_for_survey, :on=>:collection
      get :distribute, :on=>:collection
      put :send_survey_by_email, :on=>:collection
    end
    resources :exam do
      delete :delete_question, :on=>:collection
      delete :delete_answer, :on=>:collection
      get :generate_url_for_exam, :on=>:collection
      get :distribute, :on=>:collection
      put :send_exam_by_email, :on=>:collection
    end
    resources :match_type
    resources :question do
      post :add_question, :on=>:collection
      put :edit_question, :on=>:collection
      put :choose_correct_answer, :on=>:collection
    end
    resources :answer do
      put :add_answers, :on=>:collection
      put :edit_answers, :on=>:collection
    end
    resources :question_level
    resources :question_type
    resources :exam_topic
    resources :answer_format
    
  end

  namespace :organization_management do
    resources :company do 
      get :organization_panel, :on => :collection
    end
  end

  namespace :panel do
    resources :survey do
      post :submit_survey, :on => :collection
      get :success, :on => :collection
      get :error, :on => :collection
    end
    resources :exam do
      post :validate_user, :on => :collection
      get :forgot_password, :on => :collection
      post :send_password, :on => :collection
      get :new_code, :on => :collection
      post :create_code, :on => :collection
      get :show_exam, :on => :collection
      post :submit_exam, :on => :collection
      get :success, :on => :collection
      get :error, :on => :collection
    end
    resources :subscribe do
      get :index, :on => :collection
      get :edit, :on => :collection
      get :update, :on => :collection
    end
  end

  namespace :reports_management do
    resources :report do
      get :show_question , :on => :collection
      get :export_pdf, :on=> :collection
      get :show_result_student, :on=> :collection
      put :complete_result, :on=> :collection
    end
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :controller=>"account_management/user", :action=>"dashboard"

end
