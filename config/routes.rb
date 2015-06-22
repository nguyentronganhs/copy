# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get '/projects/:project_id/issues/kanbans', :to => 'kanbans#index', :as => 'project_kanbans'
