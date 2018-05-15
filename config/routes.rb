Rails.application.routes.draw do

  # Routes for the Course resource:

  # CREATE
  get("/courses/new", { :controller => "courses", :action => "new_form" })
  post("/create_course", { :controller => "courses", :action => "create_row" })

  # READ
  get("/courses", { :controller => "courses", :action => "index" })
  get("/courses/:id_to_display", { :controller => "courses", :action => "show" })

  # UPDATE
  get("/courses/:prefill_with_id/edit", { :controller => "courses", :action => "edit_form" })
  post("/update_course/:id_to_modify", { :controller => "courses", :action => "update_row" })

  # DELETE
  get("/delete_course/:id_to_remove", { :controller => "courses", :action => "destroy_row" })

  #------------------------------

  get("/", { :controller => "courses", :action => "index" })

  # Routes for the Department resource:

  # CREATE
  get("/departments/new", { :controller => "departments", :action => "new_form" })
  post("/create_department", { :controller => "departments", :action => "create_row" })

  # READ
  get("/departments", { :controller => "departments", :action => "index" })
  get("/departments/:id_to_display", { :controller => "departments", :action => "show" })

  # UPDATE
  get("/departments/:prefill_with_id/edit", { :controller => "departments", :action => "edit_form" })
  post("/update_department/:id_to_modify", { :controller => "departments", :action => "update_row" })

  # DELETE
  get("/delete_department/:id_to_remove", { :controller => "departments", :action => "destroy_row" })

  #------------------------------

  # Routes for the Student resource:

  # CREATE
  get("/students/new", { :controller => "students", :action => "new_form" })
  post("/create_student", { :controller => "students", :action => "create_row" })

  # READ
  get("/students", { :controller => "students", :action => "index" })
  get("/students/:id_to_display", { :controller => "students", :action => "show" })

  # UPDATE
  get("/students/:prefill_with_id/edit", { :controller => "students", :action => "edit_form" })
  post("/update_student/:id_to_modify", { :controller => "students", :action => "update_row" })

  # DELETE
  get("/delete_student/:id_to_remove", { :controller => "students", :action => "destroy_row" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
