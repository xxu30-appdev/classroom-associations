class EnrollmentsController < ApplicationController
  def index
    @enrollments = Enrollment.all

    render("enrollment_templates/index.html.erb")
  end

  def show
    @enrollment = Enrollment.find(params.fetch("id_to_display"))

    render("enrollment_templates/show.html.erb")
  end

  def new_form
    @enrollment = Enrollment.new

    render("enrollment_templates/new_form.html.erb")
  end

  def create_row
    @enrollment = Enrollment.new

    @enrollment.course_id = params.fetch("course_id")
    @enrollment.student_id = params.fetch("student_id")

    if @enrollment.valid?
      @enrollment.save

      redirect_back(:fallback_location => "/enrollments", :notice => "Enrollment created successfully.")
    else
      render("enrollment_templates/new_form_with_errors.html.erb")
    end
  end

  def edit_form
    @enrollment = Enrollment.find(params.fetch("prefill_with_id"))

    render("enrollment_templates/edit_form.html.erb")
  end

  def update_row
    @enrollment = Enrollment.find(params.fetch("id_to_modify"))

    @enrollment.course_id = params.fetch("course_id")
    @enrollment.student_id = params.fetch("student_id")

    if @enrollment.valid?
      @enrollment.save

      redirect_to("/enrollments/#{@enrollment.id}", :notice => "Enrollment updated successfully.")
    else
      render("enrollment_templates/edit_form_with_errors.html.erb")
    end
  end

  def destroy_row
    @enrollment = Enrollment.find(params.fetch("id_to_remove"))

    @enrollment.destroy

    redirect_to("/enrollments", :notice => "Enrollment deleted successfully.")
  end
end
