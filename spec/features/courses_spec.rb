require "rails_helper"

describe "/courses" do
  it "displays each course's title", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    visit "/courses"

    courses = Course.all
    courses.each do |course|
      expect(page).to have_content(course.title)
    end
  end
end

describe "/courses" do
  it "displays each course's department", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    visit "/courses"

    courses = Course.all
    courses.each do |course|
      department = Department.find_by(id: course.department_id)
      expect(page).to have_content(department.name)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays a functional delete link for each course", points: 5, hint: h("copy_must_match") do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)


    courses = Course.all

    courses.each do |course|
      visit "/courses/#{course.id}"
      expect(page).to have_content(course.title)
      count_of_courses = Course.count
      click_link 'Delete', match: :first
      expect(Course.count).to eq(count_of_courses - 1)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays the course's title", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      expect(page).to have_content(course.title)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays the course's department", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      department = Department.find_by(id: course.department_id)
      expect(page).to have_content(department.name)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays a count of the course's enrollments", points: 5 do
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

    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      count_of_enrollments = Enrollment.where(course_id: course.id).count
      expect(page).to have_content(count_of_enrollments)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays a list of the course's students (roster)", points: 5 do
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

    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      enrollments = Enrollment.where(course_id: course.id)
      enrollments.each do |enrollment|
        student = Student.find_by(id: enrollment.student_id)
        expect(page).to have_content(student.last_name)
      end
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "displays a form to add a new enrollment", points: 2 do
    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/courses/[COURSE ID]" do
  it "creates a new enrollment for the course after submitting the form", points: 10, hint: h("copy_must_match") do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    leo = create(:student, first_name: "Leonardo", last_name: "DiCaprio", email: "leo@juno.com")

    visit "/courses/#{application_development.id}"
    expect(page).to have_selector("form")

    count_of_enrollments = Enrollment.where(course_id: application_development.id).count

    select 'DiCaprio'
    click_button 'Create enrollment'

    expect(Enrollment.where(course_id: application_development.id).count).to eq(count_of_enrollments + 1)
  end
end

describe "/courses/[COURSE ID]" do
  it "displays a hidden input field to associate a new enrollment to the course", points: 10 do
    courses = Course.all
    courses.each do |course|
      visit "/courses/#{course.id}"
      expect(page).to have_selector("input[value='#{course.id}']", visible: false),
        "expected to find a hidden input field with the course's id as the value"
    end
  end
end

describe "/courses/new" do
  it "includes a dropdown with departments", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)


    visit "/courses/new"

    expect(page).to have_selector("select[name='department_id']"), 'expected to find a select field for department_id in the form'

    departments = Department.all
    departments.each do |department|
      expect(page).to have_selector("select[name='department_id'] option[value='#{department.id}']"),
        "expected to find options in the select field with value attributes for each department's id"
      dropdown_option = find("select[name='department_id'] option[value='#{department.id}']").text
      expect(dropdown_option).to eq(department.name),
        "expected to find options in the select field displaying each department's name"
    end
  end
end

describe "/courses/new" do
  it "displays a link to add a new department", points: 2 do
    visit "/courses/new"

    expect(page).to have_link(nil, href: /departments\/new/)
  end
end

describe "/courses/new" do
  it 'creates a new course after submitting the form', points: 5, hint: h("copy_must_match") do
    technology = create(:department, name: "Technology")

    visit "/courses/new"

    expect(page).to have_selector("form")

    count_of_courses = Course.count

    fill_in 'Title', with: 'Something'
    select 'Technology'
    click_button 'Create course'

    new_count_of_courses = count_of_courses + 1
    expect(Course.count).to eq(new_count_of_courses)
  end
end

describe "/courses/[COURSE ID]/edit" do
  it "includes a dropdown with departments", points: 10 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    course = Course.last
    visit "/courses/#{course.id}/edit"

    within("select[name='department_id']") do
      departments = Department.all
      departments.each do |department|
        expect(find("option[value='#{department.id}']").text).to eq(department.name),
          "expected to find options in the select field displaying each department's name"
      end
    end
  end
end
