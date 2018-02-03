Rails.application.routes.draw do
  # Routes for the City resource:
  # CREATE
  get "/cities/new", :controller => "cities", :action => "new"
  post "/create_city", :controller => "cities", :action => "create"

  # READ
  get "/cities", :controller => "cities", :action => "index"
  get "/cities/:id", :controller => "cities", :action => "show"

  # UPDATE
  get "/cities/:id/edit", :controller => "cities", :action => "edit"
  post "/update_city/:id", :controller => "cities", :action => "update"

  # DELETE
  get "/delete_city/:id", :controller => "cities", :action => "destroy"
  #------------------------------

  # Routes for the Showing resource:
  # CREATE
  get "/showings/new", :controller => "showings", :action => "new"
  post "/create_showing", :controller => "showings", :action => "create"

  # READ
  get "/showings", :controller => "showings", :action => "index"
  get "/showings/:id", :controller => "showings", :action => "show"

  # UPDATE
  get "/showings/:id/edit", :controller => "showings", :action => "edit"
  post "/update_showing/:id", :controller => "showings", :action => "update"

  # DELETE
  get "/delete_showing/:id", :controller => "showings", :action => "destroy"
  #------------------------------

  # Routes for the Contact resource:
  # CREATE
  get "/contacts/new", :controller => "contacts", :action => "new"
  post "/create_contact", :controller => "contacts", :action => "create"

  # READ
  get "/contacts", :controller => "contacts", :action => "index"
  get "/contacts/:id", :controller => "contacts", :action => "show"

  # UPDATE
  get "/contacts/:id/edit", :controller => "contacts", :action => "edit"
  post "/update_contact/:id", :controller => "contacts", :action => "update"

  # DELETE
  get "/delete_contact/:id", :controller => "contacts", :action => "destroy"
  #------------------------------

  # Routes for the Favorite resource:
  # CREATE
  get "/favorites/new", :controller => "favorites", :action => "new"
  post "/create_favorite", :controller => "favorites", :action => "create"

  # READ
  get "/favorites", :controller => "favorites", :action => "index"
  get "/favorites/:id", :controller => "favorites", :action => "show"

  # UPDATE
  get "/favorites/:id/edit", :controller => "favorites", :action => "edit"
  post "/update_favorite/:id", :controller => "favorites", :action => "update"

  # DELETE
  get "/delete_favorite/:id", :controller => "favorites", :action => "destroy"
  #------------------------------

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
