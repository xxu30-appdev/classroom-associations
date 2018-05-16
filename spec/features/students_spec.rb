require "rails_helper"

describe "/students" do
  it "displays each student's name and dob", points: 5 do
    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")
    jack = create(:student, first_name: "Jack", last_name: "Nicholson", email: "jack@hotmail.com")
    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")

    visit "/students"

    students = Student.all
    students.each do |student|
      expect(page).to have_content(student.first_name)
      expect(page).to have_content(student.last_name)
      expect(page).to have_content(student.email)
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "displays a functional delete link for each student", points: 5 do
    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")
    jack = create(:student, first_name: "Jack", last_name: "Nicholson", email: "jack@hotmail.com")
    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")

    students = Student.all
    students.each do |student|
      visit "/students/#{student.id}"
      count_of_students = Student.count
      click_link 'Delete', match: :first
      expect(Student.count).to eq(count_of_students - 1)
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "displays a count of the student's enrollments", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")
    create(:enrollment, course_id: application_development.id, student_id: leo.id)
    create(:enrollment, course_id: finance.id, student_id: leo.id)

    jack = create(:student, first_name: "Jack", last_name: "Nicholson", email: "jack@hotmail.com")
    create(:enrollment, course_id: finance.id, student_id: jack.id)

    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")
    create(:enrollment, course_id: economics.id, student_id: bob.id)

    students = Student.all
    students.each do |student|
      visit "/students/#{student.id}"
      count_of_enrollments = Enrollment.where(student_id: student.id).count
      expect(page).to have_content(count_of_enrollments)
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "displays a list of the student's courses (course load)", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")
    create(:enrollment, course_id: application_development.id, student_id: leo.id)
    create(:enrollment, course_id: finance.id, student_id: leo.id)

    jack = create(:student, first_name: "Jack", last_name: "Nicholson", email: "jack@hotmail.com")
    create(:enrollment, course_id: finance.id, student_id: jack.id)

    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")
    create(:enrollment, course_id: economics.id, student_id: bob.id)

    students = Student.all
    students.each do |student|
      visit "/students/#{student.id}"
      enrollments = Enrollment.where(student_id: student.id)
      student.enrollments.each do |enrollment|
        course = Course.find_by(id: enrollment.course_id)
        expect(page).to have_content(course.title)
      end
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "displays a form to add a new enrollment", points: 2 do
    students = Student.all
    students.each do |student|
      visit "/students/#{student.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "creates a new enrollment for the student after submitting the form", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")

    visit "/students/#{bob.id}"
    expect(page).to have_selector("form")

    count_of_enrollments = Enrollment.where(student_id: bob.id).count
    select 'Product Management'
    click_button 'Create enrollment'
    expect(Enrollment.where(student_id: bob.id).count).to eq(count_of_enrollments + 1)
  end
end

describe "/students/[STUDENT ID]" do
  it "displays a hidden input field to associate a new enrollment to the student", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")
    create(:enrollment, course_id: application_development.id, student_id: leo.id)
    create(:enrollment, course_id: finance.id, student_id: leo.id)

    jack = create(:student, first_name: "Jack", last_name: "Nicholson", email: "jack@hotmail.com")
    create(:enrollment, course_id: finance.id, student_id: jack.id)

    bob = create(:student, first_name: "Robert", last_name: "De Niro", email: "bob@yahoo.com")
    create(:enrollment, course_id: economics.id, student_id: bob.id)

    students = Student.all
    students.each do |student|
      visit "/students/#{student.id}"
      expect(page).to have_selector("input[value='#{student.id}']", visible: false),
        "expected to find a hidden input field with the student's id as the value"
    end
  end
end

describe "/students/new" do
  it 'creates a new student after submitting the form', points: 5 do
    visit "/students/new"
    expect(page).to have_selector("form")

    count_of_students = Student.count
    fill_in 'First name', with: 'Joseph'
    fill_in 'Last name', with: 'Gordon-Levitt'
    fill_in 'Email', with: 'joe@gmail.com'
    click_button 'Create student'
    new_count_of_students = count_of_students + 1
    expect(Student.count).to eq(new_count_of_students)
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "updates an student's data after submitting the form", points: 5 do
    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio")
    expect(leo.email).to include("fake email")

    visit "/students/#{leo.id}/edit"

    email = 'leo@hotmail.com'
    fill_in 'First name', with: 'test'
    fill_in 'Email', with: email
    click_button 'Update student'

    leo.reload
    expect(leo.first_name).to eq('test')
    expect(leo.email).to eq(email)
  end
end
