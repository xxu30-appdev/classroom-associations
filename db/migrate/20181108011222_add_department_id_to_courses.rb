class AddDepartmentIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :department_id, :integer
  end
end
