Rails.application.routes.draw do
  # Routes for the Search resource:
  # CREATE
  get "/searches/new", :controller => "searches", :action => "new"
  post "/create_search", :controller => "searches", :action => "create"

  # READ
  get "/searches", :controller => "searches", :action => "index"
  get "/searches/:id", :controller => "searches", :action => "show"

  # UPDATE
  get "/searches/:id/edit", :controller => "searches", :action => "edit"
  post "/update_search/:id", :controller => "searches", :action => "update"

  # DELETE
  get "/delete_search/:id", :controller => "searches", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # Routes for the Listing resource:
  # CREATE
  get "/listings/new", :controller => "listings", :action => "new"
  post "/create_listing", :controller => "listings", :action => "create"

  # READ
  get "/listings", :controller => "listings", :action => "index"
  get "/listings/:id", :controller => "listings", :action => "show"

  # UPDATE
  get "/listings/:id/edit", :controller => "listings", :action => "edit"
  post "/update_listing/:id", :controller => "listings", :action => "update"

  # DELETE
  get "/delete_listing/:id", :controller => "listings", :action => "destroy"
  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
