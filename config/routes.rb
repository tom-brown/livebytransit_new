Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "listings#index"
  # Routes for the Listings_search resource:
  # CREATE
  get "/listings_searches/new", :controller => "listings_searches", :action => "new"
  post "/create_listings_search", :controller => "listings_searches", :action => "create"

  # READ
  get "/listings_searches", :controller => "listings_searches", :action => "index"
  get "/listings_searches/:id", :controller => "listings_searches", :action => "show"

  # UPDATE
  get "/listings_searches/:id/edit", :controller => "listings_searches", :action => "edit"
  post "/update_listings_search/:id", :controller => "listings_searches", :action => "update"

  # DELETE
  get "/delete_listings_search/:id", :controller => "listings_searches", :action => "destroy"
  #------------------------------

  # Routes for the Hood_search resource:
  # CREATE
  get "/hood_searches/new", :controller => "hood_searches", :action => "new"
  post "/create_hood_search", :controller => "hood_searches", :action => "create"

  # READ
  get "/hood_searches", :controller => "hood_searches", :action => "index"
  get "/hood_searches/:id", :controller => "hood_searches", :action => "show"

  # UPDATE
  get "/hood_searches/:id/edit", :controller => "hood_searches", :action => "edit"
  post "/update_hood_search/:id", :controller => "hood_searches", :action => "update"

  # DELETE
  get "/delete_hood_search/:id", :controller => "hood_searches", :action => "destroy"
  #------------------------------

  # Routes for the City_search resource:
  # CREATE
  get "/city_searches/new", :controller => "city_searches", :action => "new"
  post "/create_city_search", :controller => "city_searches", :action => "create"

  # READ
  get "/city_searches", :controller => "city_searches", :action => "index"
  get "/city_searches/:id", :controller => "city_searches", :action => "show"

  # UPDATE
  get "/city_searches/:id/edit", :controller => "city_searches", :action => "edit"
  post "/update_city_search/:id", :controller => "city_searches", :action => "update"

  # DELETE
  get "/delete_city_search/:id", :controller => "city_searches", :action => "destroy"
  #------------------------------

  # Routes for the Metra_search resource:
  # CREATE
  get "/metra_searches/new", :controller => "metra_searches", :action => "new"
  post "/create_metra_search", :controller => "metra_searches", :action => "create"

  # READ
  get "/metra_searches", :controller => "metra_searches", :action => "index"
  get "/metra_searches/:id", :controller => "metra_searches", :action => "show"

  # UPDATE
  get "/metra_searches/:id/edit", :controller => "metra_searches", :action => "edit"
  post "/update_metra_search/:id", :controller => "metra_searches", :action => "update"

  # DELETE
  get "/delete_metra_search/:id", :controller => "metra_searches", :action => "destroy"
  #------------------------------

  # Routes for the Cta_search resource:
  # CREATE
  get "/cta_searches/new", :controller => "cta_searches", :action => "new"
  post "/create_cta_search", :controller => "cta_searches", :action => "create"

  # READ
  get "/cta_searches", :controller => "cta_searches", :action => "index"
  get "/cta_searches/:id", :controller => "cta_searches", :action => "show"

  # UPDATE
  get "/cta_searches/:id/edit", :controller => "cta_searches", :action => "edit"
  post "/update_cta_search/:id", :controller => "cta_searches", :action => "update"

  # DELETE
  get "/delete_cta_search/:id", :controller => "cta_searches", :action => "destroy"
  #------------------------------

  # Routes for the Cta_assign resource:
  # CREATE
  get "/cta_assigns/new", :controller => "cta_assigns", :action => "new"
  post "/create_cta_assign", :controller => "cta_assigns", :action => "create"

  # READ
  get "/cta_assigns", :controller => "cta_assigns", :action => "index"
  get "/cta_assigns/:id", :controller => "cta_assigns", :action => "show"

  # UPDATE
  get "/cta_assigns/:id/edit", :controller => "cta_assigns", :action => "edit"
  post "/update_cta_assign/:id", :controller => "cta_assigns", :action => "update"

  # DELETE
  get "/delete_cta_assign/:id", :controller => "cta_assigns", :action => "destroy"
  #------------------------------

  # Routes for the Metra_assign resource:
  # CREATE
  get "/metra_assigns/new", :controller => "metra_assigns", :action => "new"
  post "/create_metra_assign", :controller => "metra_assigns", :action => "create"

  # READ
  get "/metra_assigns", :controller => "metra_assigns", :action => "index"
  get "/metra_assigns/:id", :controller => "metra_assigns", :action => "show"

  # UPDATE
  get "/metra_assigns/:id/edit", :controller => "metra_assigns", :action => "edit"
  post "/update_metra_assign/:id", :controller => "metra_assigns", :action => "update"

  # DELETE
  get "/delete_metra_assign/:id", :controller => "metra_assigns", :action => "destroy"
  #------------------------------

  # Routes for the Hood_point resource:
  # CREATE
  get "/hood_points/new", :controller => "hood_points", :action => "new"
  post "/create_hood_point", :controller => "hood_points", :action => "create"

  # READ
  get "/hood_points", :controller => "hood_points", :action => "index"
  get "/hood_points/:id", :controller => "hood_points", :action => "show"

  # UPDATE
  get "/hood_points/:id/edit", :controller => "hood_points", :action => "edit"
  post "/update_hood_point/:id", :controller => "hood_points", :action => "update"

  # DELETE
  get "/delete_hood_point/:id", :controller => "hood_points", :action => "destroy"
  #------------------------------

  # Routes for the Neighborhood resource:
  # CREATE
  get "/neighborhoods/new", :controller => "neighborhoods", :action => "new"
  post "/create_neighborhood", :controller => "neighborhoods", :action => "create"

  # READ
  get "/neighborhoods", :controller => "neighborhoods", :action => "index"
  get "/neighborhoods/:id", :controller => "neighborhoods", :action => "show"

  # UPDATE
  get "/neighborhoods/:id/edit", :controller => "neighborhoods", :action => "edit"
  post "/update_neighborhood/:id", :controller => "neighborhoods", :action => "update"

  # DELETE
  get "/delete_neighborhood/:id", :controller => "neighborhoods", :action => "destroy"
  #------------------------------

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
