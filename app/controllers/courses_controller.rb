class CoursesController < ApplicationController
  def index
    @courses = Course.all

    render("course_templates/index.html.erb")
  end

  def show
    @course = Course.find(params.fetch("id_to_display"))

    render("course_templates/show.html.erb")
  end

  def new_form
    render("course_templates/new_form.html.erb")
  end

  def create_row
    @course = Course.new

    @course.title = params.fetch("title")
    @course.department_id = params.fetch("department_id")
    if @course.valid?
      @course.save

      redirect_to("/courses", :notice => "Course created successfully.")
    else
      render("course_templates/new_form.html.erb")
    end
  end

  def edit_form
    @course = Course.find(params.fetch("prefill_with_id"))
   
    render("course_templates/edit_form.html.erb")
  end

  def update_row
    @course = Course.find(params.fetch("id_to_modify"))
    @course.department_id = params.fetch("department_id")
    @course.title = params.fetch("title")

    if @course.valid?
      @course.save

      redirect_to("/courses/#{@course.id}", :notice => "Course updated successfully.")
    else
      render("course_templates/edit_form.html.erb")
    end
  end

  def destroy_row
    @course = Course.find(params.fetch("id_to_remove"))

    @course.destroy

    redirect_to("/courses", :notice => "Course deleted successfully.")
  end
end
