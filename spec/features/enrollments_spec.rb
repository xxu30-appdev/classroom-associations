require "rails_helper"

describe "/enrollments" do
  it "displays each enrollment's student and course", points: 10 do
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

    visit "/enrollments"

    enrollments = Enrollment.all
    enrollments.each do |enrollment|
      course = Course.find_by(id: enrollment.course_id)
      expect(page).to have_content(course.title)

      student = Student.find_by(id: enrollment.student_id)
      expect(page).to have_content(student.first_name)
      expect(page).to have_content(student.last_name)
    end
  end
end

describe "/enrollments/[ENROLLMENT ID]" do
  it "displays a functional delete link for each enrollment", points: 5 do
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

    visit "/enrollments"

    enrollments = Enrollment.all
    enrollments.each do |enrollment|
      visit "/enrollments/#{enrollment.id}"
      count_of_enrollments = Enrollment.count
      click_link 'Delete', match: :first
      expect(Enrollment.count).to eq(count_of_enrollments - 1)
    end
  end
end

describe "/enrollments/[ENROLLMENT ID]" do
  it "displays the enrollment's course and student", points: 10 do
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

    enrollments = Enrollment.all
    enrollments.each do |enrollment|
      visit "/enrollments/#{enrollment.id}"

      course = Course.find_by(id: enrollment.course_id)
      expect(page).to have_content(course.title)

      student = Student.find_by(id: enrollment.student_id)
      expect(page).to have_content(student.first_name)
      expect(page).to have_content(student.last_name)
    end
  end
end

describe "/enrollments/new" do
  it "includes a dropdown with courses", points: 10 do
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

    visit "/enrollments/new"

    expect(page).to have_selector("select[name='course_id']"), 'expected to find a select field for course_id in the form'

    courses = Course.all
    courses.each do |course|
      expect(page).to have_selector("select[name='course_id'] option[value='#{course.id}']"),
        "expected to find options in the select field with value attributes for each course's id"

      dropdown_option = find("select[name='course_id'] option[value='#{course.id}']").text
      expect(dropdown_option).to eq(course.title),
        "expected to find options in the select field displaying each course's title"
    end
  end
end

describe "/enrollments/new" do
  it "includes a dropdown with students", points: 10 do
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

    visit "/enrollments/new"

    expect(page).to have_selector("select[name='student_id']"), 'expected to find a select field for student_id in the form'

    students = Student.all
    students.each do |student|
      expect(page).to have_selector("select[name='student_id'] option[value='#{student.id}']"),
        "expected to find options in the select field with the value attributes for each student's id"

      dropdown_option = find("select[name='student_id'] option[value='#{student.id}']").text
      expect(dropdown_option).to eq(student.last_name),
        "expected to find options in the select field displaying each student's name"
    end
  end
end

describe "/enrollments/new" do
  it "displays a link to add a new course", points: 2 do
    visit "/enrollments/new"

    expect(page).to have_link(nil, href: /courses\/new/)
  end
end

describe "/enrollments/new" do
  it "displays a link to add a new student", points: 2 do
    visit "/enrollments/new"

    expect(page).to have_link(nil, href: /students\/new/)
  end
end

describe "/enrollments/new" do
  it 'creates a new enrollment after submitting the form', points: 5 do
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

    hardy = create(:student, first_name: "Tom", last_name: "Hardy", email: "tom@aol.com")

    visit "/enrollments/new"

    expect(page).to have_selector("form")

    count_of_enrollments = Enrollment.count

    select 'Hardy'
    select 'Finance'
    click_button 'Create enrollment'

    new_count_of_enrollments = count_of_enrollments + 1
    expect(Enrollment.count).to eq(new_count_of_enrollments)
  end
end

describe "/enrollments/[ENROLLMENT ID]/edit" do
  it "includes a dropdown with courses", points: 10 do
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

    enrollment = Enrollment.last
    visit "/enrollments/#{enrollment.id}/edit"

    within("select[name='course_id']") do
      courses = Course.all
      courses.each do |course|
        expect(find("option[value='#{course.id}']").text).to eq(course.title),
          "expected to find option in the select field displaying each course's title"
      end
    end
  end
end

describe "/enrollments/[ENROLLMENT ID]/edit" do
  it "includes a dropdown with students", points: 10 do
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

    enrollment = Enrollment.last
    visit "/enrollments/#{enrollment.id}/edit"

    within("select[name='student_id']") do
      students = Student.all
      students.each do |student|
        expect(find("option[value='#{student.id}']").text).to eq(student.last_name),
          "expected to find options in the select field displaying each student's name"
      end
    end
  end
end
