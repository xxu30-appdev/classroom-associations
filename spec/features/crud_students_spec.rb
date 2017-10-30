require "rails_helper"

describe "/students" do
  it "has the first name of every row", points: 1 do
    test_students = create_list(:student, 5)

    visit "/students"

    test_students.each do |current_student|
      expect(page).to have_content(current_student.first_name)
    end
  end
end

describe "/students" do
  it "has the last name of every row", points: 1 do
    test_students = create_list(:student, 5)

    visit "/students"

    test_students.each do |current_student|
      expect(page).to have_content(current_student.last_name)
    end
  end
end

describe "/students" do
  it "has the email of every row", points: 1 do
    test_students = create_list(:student, 5)

    visit "/students"

    test_students.each do |current_student|
      expect(page).to have_content(current_student.email)
    end
  end
end

describe "/students" do
  it "has a link to the details page of every row", points: 0 do
    test_students = create_list(:student, 5)

    visit "/students"

    test_students.each do |current_student|
      expect(page).to have_css("a[href*='#{current_student.id}']", text: "Show details")
    end
  end
end

describe "/students/[STUDENT ID]" do
  it "has the correct first name", points: 1 do
    student_to_show = create(:student)

    visit "/students"
    find("a[href*='#{student_to_show.id}']", text: "Show details").click

    expect(page).to have_content(student_to_show.first_name)
  end
end

describe "/students/[STUDENT ID]" do
  it "has the correct last name", points: 1 do
    student_to_show = create(:student)

    visit "/students"
    find("a[href*='#{student_to_show.id}']", text: "Show details").click

    expect(page).to have_content(student_to_show.last_name)
  end
end

describe "/students/[STUDENT ID]" do
  it "has the correct email", points: 1 do
    student_to_show = create(:student)

    visit "/students"
    find("a[href*='#{student_to_show.id}']", text: "Show details").click

    expect(page).to have_content(student_to_show.email)
  end
end

describe "/students" do
  it "has a link to the new student page", points: 0 do
    visit "/students"

    expect(page).to have_css("a", text: "Add a new student")
  end
end

describe "/students/new" do
  it "saves the first name when submitted", points: 2, hint: h("label_for_input") do
    visit "/students"
    click_on "Add a new student"

    test_first_name = "A fake first name I'm typing at #{Time.now}"
    fill_in "First name", with: test_first_name
    click_on "Create student"

    last_student = Student.order(created_at: :asc).last
    expect(last_student.first_name).to eq(test_first_name)
  end
end

describe "/students/new" do
  it "saves the last name when submitted", points: 2, hint: h("label_for_input") do
    visit "/students"
    click_on "Add a new student"

    test_last_name = "A fake last name I'm typing at #{Time.now}"
    fill_in "Last name", with: test_last_name
    click_on "Create student"

    last_student = Student.order(created_at: :asc).last
    expect(last_student.last_name).to eq(test_last_name)
  end
end

describe "/students/new" do
  it "saves the email when submitted", points: 2, hint: h("label_for_input") do
    visit "/students"
    click_on "Add a new student"

    test_email = "A fake email I'm typing at #{Time.now}"
    fill_in "Email", with: test_email
    click_on "Create student"

    last_student = Student.order(created_at: :asc).last
    expect(last_student.email).to eq(test_email)
  end
end

describe "/students/new" do
  it "redirects to the index when submitted", points: 0, hint: h("redirect_vs_render") do
    visit "/students"
    click_on "Add a new student"

    click_on "Create student"

    expect(page).to have_current_path("/students")
  end
end

describe "/students/[STUDENT ID]" do
  it "has a 'Delete student' link", points: 0 do
    student_to_delete = create(:student)

    visit "/students"
    find("a[href*='#{student_to_delete.id}']", text: "Show details").click

    expect(page).to have_css("a", text: "Delete")
  end
end

describe "/students" do
  it "removes a row from the table", points: 0 do
    student_to_delete = create(:student)

    visit "/students"
    find("a[href*='#{student_to_delete.id}']", text: "Show details").click
    click_on "Delete student"

    expect(Student.exists?(student_to_delete.id)).to be(false)
  end
end

describe "/students" do
  it "redirects to the index", points: 2, hint: h("redirect_vs_render") do
    student_to_delete = create(:student)

    visit "/students"
    find("a[href*='#{student_to_delete.id}']", text: "Show details").click
    click_on "Delete student"

    expect(page).to have_current_path("/students")
  end
end

describe "/students/[STUDENT ID]" do
  it "has an 'Edit student' link", points: 5 do
    student_to_edit = create(:student)

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click

    expect(page).to have_css("a", text: "Edit student")
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "has first name pre-populated", points: 2, hint: h("value_attribute") do
    test_first_name = "Some fake pre-existing first name at #{Time.now}"
    student_to_edit = create(:student, first_name: test_first_name)

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    expect(page).to have_css("input[value='#{test_first_name}']")
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "has last name pre-populated", points: 2, hint: h("value_attribute") do
    test_last_name = "Some fake pre-existing last name at #{Time.now}"
    student_to_edit = create(:student, last_name: test_last_name)

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    expect(page).to have_css("input[value='#{test_last_name}']")
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "has email pre-populated", points: 2, hint: h("value_attribute") do
    test_email = "Some fake pre-existing email at #{Time.now}"
    student_to_edit = create(:student, email: test_email)

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    expect(page).to have_css("input[value='#{test_email}']")
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "updates first name when submitted", points: 1, hint: h("label_for_input button_type") do
    student_to_edit = create(:student, first_name: "Boring old first name")

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    test_first_name = "Exciting new first name at #{Time.now}"
    fill_in "First name", with: test_first_name
    click_on "Update student"

    photo_as_revised = Student.find(student_to_edit.id)

    expect(photo_as_revised.first_name).to eq(test_first_name)
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "updates last name when submitted", points: 1, hint: h("label_for_input button_type") do
    student_to_edit = create(:student, last_name: "Boring old last name")

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    test_last_name = "Exciting new last name at #{Time.now}"
    fill_in "Last name", with: test_last_name
    click_on "Update student"

    photo_as_revised = Student.find(student_to_edit.id)

    expect(photo_as_revised.last_name).to eq(test_last_name)
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "updates email when submitted", points: 1, hint: h("label_for_input button_type") do
    student_to_edit = create(:student, email: "Boring old email")

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"

    test_email = "Exciting new email at #{Time.now}"
    fill_in "Email", with: test_email
    click_on "Update student"

    photo_as_revised = Student.find(student_to_edit.id)

    expect(photo_as_revised.email).to eq(test_email)
  end
end

describe "/students/[STUDENT ID]/edit" do
  it "redirects to the details page", points: 0, hint: h("embed_vs_interpolate redirect_vs_render") do
    student_to_edit = create(:student)

    visit "/students"
    find("a[href*='#{student_to_edit.id}']", text: "Show details").click
    click_on "Edit student"
    click_on "Update student"

    expect(page).to have_current_path(/.*#{student_to_edit.id}.*/)
  end
end
