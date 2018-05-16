require "rails_helper"

describe "/departments" do
  it "displays each department's name and dob", points: 5 do
    technology = create(:department, name: "Technology")
    business = create(:department, name: "Business")

    visit "/departments"

    departments = Department.all
    departments.each do |department|
      expect(page).to have_content(department.name)
    end
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "displays a functional delete link for each department", points: 5, hint: h("copy_must_match")  do
    technology = create(:department, name: "Technology")
    business = create(:department, name: "Business")

    departments = Department.all

    departments.each do |department|
      visit "/departments/#{department.id}"
      count_of_departments = Department.count
      click_link "Delete", match: :first
      expect(Department.count).to eq(count_of_departments - 1)
    end
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "displays a count of the department's courses", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    departments = Department.all

    departments.each do |department|
      visit "/departments/#{department.id}"
      count_of_courses = Course.where(department_id: department.id).count
      expect(page).to have_content(count_of_courses)
    end
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "displays a list of the department's courses", points: 5 do
    technology = create(:department, name: "Technology")
    application_development = create(:course, title: "Application Development", department_id: technology.id)
    product_management = create(:course, title: "Product Management", department_id: technology.id)

    business = create(:department, name: "Business")
    finance = create(:course, title: "Finance", department_id: business.id)
    economics = create(:course, title: "Economics", department_id: business.id)

    departments = Department.all

    departments.each do |department|
      visit "/departments/#{department.id}"
      courses = Course.where(department_id: department.id)
      courses.each do |course|
        expect(page).to have_content(course.title)
      end
    end
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "displays a form to add a new course", points: 2 do
    technology = create(:department, name: "Technology")
    business = create(:department, name: "Business")

    departments = Department.all
    departments.each do |department|
      visit "/departments/#{department.id}"
      expect(page).to have_selector("form", count: 1)
    end
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "creates a new course for the department after submitting the form", points: 10, hint: h("copy_must_match") do
    science = create(:department, name: "Science")

    visit "/departments/#{science.id}"

    expect(page).to have_selector("form")

    count_of_courses = Course.where(department_id: science.id).count

    fill_in "Title", with: "Physics"
    click_button "Create course"

    expect(Course.where(department_id: science.id).count).to eq(count_of_courses + 1)
  end
end

describe "/departments/[DEPARTMENT ID]" do
  it "displays a hidden input field to associate a new course to the department", points: 10 do
    departments = Department.all
    departments.each do |department|
      visit "/departments/#{department.id}"
      expect(page).to have_selector("input[value='#{department.id}']", visible: false),
        "expected to find a hidden input field with the department's id as the value"
    end
  end
end

describe "/departments/new" do
  it "creates a new department after submitting the form", points: 5, hint: h("copy_must_match") do
    visit "/departments/new"

    expect(page).to have_selector("form")

    count_of_departments = Department.count

    fill_in "Name", with: "Science"
    click_button "Create department"

    new_count_of_departments = count_of_departments + 1
    expect(Department.count).to eq(new_count_of_departments)
  end
end

describe "/departments/[DEPARTMENT ID]/edit" do
  it "updates a department's data after submitting the form", points: 5 do
    science = create(:department)
    expect(science.name).to include("fake name")

    visit "/departments/#{science.id}/edit"

    name = "science"
    fill_in "Name", with: name
    click_button "Update department"

    science.reload
    expect(science.name).to eq(name)
  end
end
