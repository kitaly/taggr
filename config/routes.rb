Taggr::Application.routes.draw do |map|
  match 'train/', :to => 'classifier#train', :via => 'post', :as => 'train'
  match 'train/', :to => 'classifier#create_train', :via => 'get'
  match 'guess/', :to => 'classifier#guess', :via => 'post'
end
