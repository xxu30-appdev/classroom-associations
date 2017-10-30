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
end
