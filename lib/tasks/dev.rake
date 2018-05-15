namespace :dev do
  desc "Hydrate the database with some dummy data to make it easier to develop"
  task prime: "db:setup" do

    20.times do
      student = Student.new
      student.first_name = Faker::Name.first_name
      student.last_name = Faker::Name.last_name
      student.email = "#{student.first_name[0]}#{student.last_name}@example.com".downcase
      student.save
    end

    puts "There are now #{Student.count} students in the database."

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

  desc "reset the database with courses that have departement IDs"
  task prime_associated_departments: :environment do
    20.times do
      student = Student.new
      student.first_name = Faker::Name.first_name
      student.last_name = Faker::Name.last_name
      student.email = "#{student.first_name[0]}#{student.last_name}@example.com".downcase
      student.save
    end

    puts "There are now #{Student.count} students in the database."

    department_names = [
      "Technology",
      "English",
      "Business",
    ]

    d1 = Department.create(name: "Technology")
    d2 = Department.create(name: "English")
    d3 = Department.create(name: "Business")

    puts "There are now #{Department.count} departments in the database."

    course_info_hashes = [
      {title: "Application Development", department: d1}
      {title: "Composition", department: d2}
      {title: "Economics", department: d3}
      {title: "Product Management", department: d1}
      {title: "Finance", department: d3}
      {title: "Negotiation", department: d3}
    ]

    course_info_hashes.each do |course_info_hash|
      course = Course.new
      course.title = course_info_hash[:title]
      course.department = course_info_hash[:department]
      course.save
    end

    puts "There are now #{Course.count} courses in the database."

  end
end
