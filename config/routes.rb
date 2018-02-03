Rails.application.routes.draw do
  # Routes for the Cta_station resource:
  # CREATE
  get "/cta_stations/new", :controller => "cta_stations", :action => "new"
  post "/create_cta_station", :controller => "cta_stations", :action => "create"

  # READ
  get "/cta_stations", :controller => "cta_stations", :action => "index"
  get "/cta_stations/:id", :controller => "cta_stations", :action => "show"

  # UPDATE
  get "/cta_stations/:id/edit", :controller => "cta_stations", :action => "edit"
  post "/update_cta_station/:id", :controller => "cta_stations", :action => "update"

  # DELETE
  get "/delete_cta_station/:id", :controller => "cta_stations", :action => "destroy"
  #------------------------------

  # Routes for the Cta_line resource:
  # CREATE
  get "/cta_lines/new", :controller => "cta_lines", :action => "new"
  post "/create_cta_line", :controller => "cta_lines", :action => "create"

  # READ
  get "/cta_lines", :controller => "cta_lines", :action => "index"
  get "/cta_lines/:id", :controller => "cta_lines", :action => "show"

  # UPDATE
  get "/cta_lines/:id/edit", :controller => "cta_lines", :action => "edit"
  post "/update_cta_line/:id", :controller => "cta_lines", :action => "update"

  # DELETE
  get "/delete_cta_line/:id", :controller => "cta_lines", :action => "destroy"
  #------------------------------

  # Routes for the Metra_station resource:
  # CREATE
  get "/metra_stations/new", :controller => "metra_stations", :action => "new"
  post "/create_metra_station", :controller => "metra_stations", :action => "create"

  # READ
  get "/metra_stations", :controller => "metra_stations", :action => "index"
  get "/metra_stations/:id", :controller => "metra_stations", :action => "show"

  # UPDATE
  get "/metra_stations/:id/edit", :controller => "metra_stations", :action => "edit"
  post "/update_metra_station/:id", :controller => "metra_stations", :action => "update"

  # DELETE
  get "/delete_metra_station/:id", :controller => "metra_stations", :action => "destroy"
  #------------------------------

  # Routes for the Metra_line resource:
  # CREATE
  get "/metra_lines/new", :controller => "metra_lines", :action => "new"
  post "/create_metra_line", :controller => "metra_lines", :action => "create"

  # READ
  get "/metra_lines", :controller => "metra_lines", :action => "index"
  get "/metra_lines/:id", :controller => "metra_lines", :action => "show"

  # UPDATE
  get "/metra_lines/:id/edit", :controller => "metra_lines", :action => "edit"
  post "/update_metra_line/:id", :controller => "metra_lines", :action => "update"

  # DELETE
  get "/delete_metra_line/:id", :controller => "metra_lines", :action => "destroy"
  #------------------------------

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
