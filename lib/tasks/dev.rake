namespace :dev do
  desc "Hydrate the database with some dummy data to make it easier to develop"
  task prime: "db:setup" do

    Student.destroy_all
    20.times do
      student = Student.new
      student.first_name = Faker::Name.first_name
      student.last_name = Faker::Name.last_name
      student.email = "#{student.first_name[0]}#{student.last_name}@example.com".downcase
      student.save
    end

    puts "There are now #{Student.count} students in the database."

    Department.destroy_all
    department_names = [
      "Technology",
      "English",
      "Business",
    ]

    department_names.each do |department_name|
      department = Department.new
      department.name = department_name
      department.save
    end

    puts "There are now #{Department.count} departments in the database."

    Course.destroy_all
    course_titles = [
      "Application Development",
      "Composition",
      "Economics",
      "Product Management",
      "Finance",
      "Negotiation",
    ]

    course_titles.each do |course_title|
      course = Course.new
      course.title = course_title
      course.save
    end

    puts "There are now #{Course.count} courses in the database."

  end

  desc "reset the database with courses that have department IDs"
  task prime_associated_departments: :environment do
    Student.destroy_all
    20.times do
      student = Student.new
      student.first_name = Faker::Name.first_name
      student.last_name = Faker::Name.last_name
      student.email = "#{student.first_name[0]}#{student.last_name}@example.com".downcase
      student.save
    end

    puts "There are now #{Student.count} students in the database."

    Department.destroy_all
    department_names = [
      "Technology",
      "English",
      "Business",
    ]

    d1 = Department.create(name: "Technology")
    d2 = Department.create(name: "English")
    d3 = Department.create(name: "Business")

    puts "There are now #{Department.count} departments in the database."

    Course.destroy_all
    course_info_hashes = [
      {title: "Application Development", department_id: d1.id},
      {title: "Composition", department_id: d2.id},
      {title: "Economics", department_id: d3.id},
      {title: "Product Management", department_id: d1.id},
      {title: "Finance", department_id: d3.id},
      {title: "Negotiation", department_id: d3.id},
    ]

    course_info_hashes.each do |course_info_hash|
      course = Course.new
      course.title = course_info_hash[:title]
      course.department_id = course_info_hash[:department_id]
      course.save
    end

    puts "There are now #{Course.count} courses in the database."

  end


  desc "reset the database with associated courses, departments, students and enrollments"
  task prime_enrollments: [:environment] do
    Enrollment.destroy_all
    Student.all.each do |student|
      num_courses = rand(4) + 1
      course_ids = Course.all.map { |c| c.id }
      num_courses.times do
        Enrollment.create(
          student_id: student.id,
          course_id: course_ids.shuffle!.pop
        )
      end
    end
    puts "There are now #{Enrollment.count} enrollments in the database."
  end
end
