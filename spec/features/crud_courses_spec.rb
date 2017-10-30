require "rails_helper"

describe "/courses" do
  it "has the title of every row", points: 1 do
    test_courses = create_list(:course, 5)

    visit "/courses"

    test_courses.each do |current_course|
      expect(page).to have_content(current_course.title)
    end
  end
end

describe "/courses" do
  it "has a link to the details page of every row", points: 0 do
    test_courses = create_list(:course, 5)

    visit "/courses"

    test_courses.each do |current_course|
      expect(page).to have_css("a[href*='#{current_course.id}']", text: "Show details")
    end
  end
end

describe "/courses/[STUDENT ID]" do
  it "has the correct title", points: 1 do
    course_to_show = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_show.id}']", text: "Show details").click

    expect(page).to have_content(course_to_show.title)
  end
end

describe "/courses" do
  it "has a link to the new course page", points: 0 do
    visit "/courses"

    expect(page).to have_css("a", text: "Add a new course")
  end
end

describe "/courses/new" do
  it "saves the title when submitted", points: 2, hint: h("label_for_input") do
    visit "/courses"
    click_on "Add a new course"

    test_title = "A fake title I'm typing at #{Time.now}"
    fill_in "Title", with: test_title
    click_on "Create course"

    course = Course.order(created_at: :asc).last
    expect(course.title).to eq(test_title)
  end
end

describe "/courses/new" do
  it "redirects to the index when submitted", points: 0, hint: h("redirect_vs_render") do
    visit "/courses"
    click_on "Add a new course"

    click_on "Create course"

    expect(page).to have_current_path("/courses")
  end
end

describe "/courses/[STUDENT ID]" do
  it "has a 'Delete course' link", points: 0 do
    course_to_delete = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_delete.id}']", text: "Show details").click

    expect(page).to have_css("a", text: "Delete")
  end
end

describe "/courses" do
  it "removes a row from the table", points: 0 do
    course_to_delete = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_delete.id}']", text: "Show details").click
    click_on "Delete course"

    expect(Course.exists?(course_to_delete.id)).to be(false)
  end
end

describe "/courses" do
  it "redirects to the index", points: 2, hint: h("redirect_vs_render") do
    course_to_delete = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_delete.id}']", text: "Show details").click
    click_on "Delete course"

    expect(page).to have_current_path("/courses")
  end
end

describe "/courses/[STUDENT ID]" do
  it "has an 'Edit course' link", points: 5 do
    course_to_edit = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_edit.id}']", text: "Show details").click

    expect(page).to have_css("a", text: "Edit course")
  end
end

describe "/courses/[STUDENT ID]/edit" do
  it "has title pre-populated", points: 2, hint: h("value_attribute") do
    test_title = "Some fake pre-existing title at #{Time.now}"
    course_to_edit = create(:course, title: test_title)

    visit "/courses"
    find("a[href*='#{course_to_edit.id}']", text: "Show details").click
    click_on "Edit course"

    expect(page).to have_css("input[value='#{test_title}']")
  end
end

describe "/courses/[STUDENT ID]/edit" do
  it "updates title when submitted", points: 1, hint: h("label_for_input button_type") do
    course_to_edit = create(:course, title: "Boring old title")

    visit "/courses"
    find("a[href*='#{course_to_edit.id}']", text: "Show details").click
    click_on "Edit course"

    test_title = "Exciting new last title at #{Time.now}"
    fill_in "Title", with: test_title
    click_on "Update course"

    photo_as_revised = Course.find(course_to_edit.id)

    expect(photo_as_revised.title).to eq(test_title)
  end
end

describe "/courses/[STUDENT ID]/edit" do
  it "redirects to the details page", points: 0, hint: h("embed_vs_interpolate redirect_vs_render") do
    course_to_edit = create(:course)

    visit "/courses"
    find("a[href*='#{course_to_edit.id}']", text: "Show details").click
    click_on "Edit course"
    click_on "Update course"

    expect(page).to have_current_path(/.*#{course_to_edit.id}.*/)
  end
end
