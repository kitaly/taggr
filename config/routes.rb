Taggr::Application.routes.draw do |map|
  match 'train/', :to => 'classifier#train', :via => 'post', :as => 'train'
  match 'train/', :to => 'classifier#create_train', :via => 'get'

  match 'try-guess/', :to => 'classifier#try_guess', :via => 'get', :as => 'try_guess'
  match 'guess/', :to => 'classifier#create_guess', :via => 'get'
  match 'guess/', :to => 'classifier#guess', :via => 'post', :as => 'guess'
  
  match 'reports/:initial_date/:end_date/:percentage', :to => 'reports#report', :via => 'get', :as => 'reports'
  match 'reports/', :to => 'reports#create', :via => 'get'
end
