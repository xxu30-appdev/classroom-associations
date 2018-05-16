

# Classroom Associations

## Objective

In this project, we'll practice associating rows from different tables to one another.

### Here is [our target](https://classroom-associations-target.herokuapp.com/).

(Don't worry about styling -- focus on functionality only.)

## Setup

 1. Clone this project to your Cloud9 workspace as usual
 1. `bin/setup`
 1. Click the Run Project button
 1. Navigate to the app preview in Chrome and verify that it works. You should see a functional version of the courses index page.
 1. I've already added the [draft_generators](https://guides.firstdraft.com/draftgenerators.html) gem to the `Gemfile` for you, but you might want to go read that Guide to get an overview of what it does for us.
 1. Run `rails grade:all` as you go to check your progress
 1. If at any point `rails grade:all` fails with the message "Migrations are pending. To resolve this issue, run: bin/rake db:migrate RAILS_ENV=test" then run

        rails db:migrate RAILS_ENV=test

## Two important notes about `rails console`

 1. Sometimes when the output of a command is very long, `rails console` is going to paginate it for you. You will have a `:` prompt when this is true, and you can hit <kbd>Return</kbd> to scroll through line by line, or <kbd>Space</kbd> to scroll through page by page.

    **To get back to the regular prompt so that you can enter your next command, just hit <kbd>q</kbd>.**

 2. If you are in `rails console` and then make a change to a model (for example, you add a validation or fix a syntax error), then, annoyingly, **you have to `exit` and then relaunch `rails console`** to pick up the new logic.

## Associating Departments and Courses

### Can X have many of Y? Can Y have many of X?

 - Can a department have many courses? Yes
 - Can a course have many departments? No (in this app, anyway)

Therefore, we have a one (department) to many (courses) relationship.

Whenever you have a One-to-Many relationship, the way to keep track of it in the database is to **add a column to the Many to keep track of which One it belongs to**.

In this case, we want to add a column to the courses table to keep track of which department each course belongs to.

We could add a column called "department_name", but that's not very reliable because there could be two departments with the same name, or a name could change.

Instead, we usually store the ID number of the row in the other table that we want to associate to, which is guaranteed by the database never to change or be duplicated. We can always use the ID number to look up the rest of the details.

So, let's now update the Course resource with all of the columns it needs:

```
rails generate migration add_department_id_to_courses department_id:integer
```

Open up the `db/migrate` folder in your application and open up the last file. See if you can make sense of the instructions. When we run `rails db:migrate`, this set of instructions runs to makes changes in the database structure. Specifically, this migration adds a new column called `department_id` to the courses table.

The `department_id` column is intended to hold the `id` of a row from over in the departments table. Such columns are called **foreign key columns**.

Execute the newly generated instructions to update the courses table:

```
rails db:migrate
```

Reset the database to include courses that have an included `department_id`:

```
rails dev:prime_associated_departments
```

### Improving the generated boilerplate views

 1. Currently, on the courses index page and a course's show page, the code we started with isn't showing any information about associated departments. Add links to associated departments.
 1. On the new and edit course pages, let's give our users a dropdown box to select a department. Let's use the `select_tag` view helper method to make this slightly easier than writing the raw HTML `<select>` and `<option>` tags by hand:

    ```erb
    <%= select_tag("department_id", options_from_collection_for_select(Department.all, :id, :name, @course.try(:department_id)), :class => "form-control") %>
    ```
 1. Edit the `create_row` and `update_row` actions in the Courses controller to save the `department_id` field.
 1. Let's also add a link to the new department form in case the department doesn't exist yet.
 1. On a department's show page, display a count of how many courses belong to that department.
 1. On a department's show page, display a list of the courses that belong to that department.
 1. At the bottom of the list of courses, write a form to add a new course directly to that department (without having to go to "/courses/new"). You can start by copying over the boilerplate new course form, and then modify it to pre-populate the `department_id` input with the correct value. Finally, switch the `type` of the input to "hidden".

**The above are all extremely common steps that you will want to go through for almost every One-to-Many that you ever build.**

## Associating Courses and Students

Our end goal is to show a roster on each course's show page, and a course load on each student's show page.

### Can X have many of Y? Can Y have many of X?

Ask yourself the standard two questions:

 - Can a course be associated to many students? Yes
 - Can an student be associated to many courses? Yes

So, we know we have a Many-to-Many on our hands.

If it had been a One-to-Many, we would simply have added a `course_id` column to students, or a `student_id` column to courses. But this won't work because that limits you to connecting to only one.

The trick we'll use instead is to create a whole new table to keep track of the individual connection between each course/student pair.

Each row in the new table, or **join table**, will have both an `student_id` and a `course_id`, and will represent one student appearing in one course (e.g., Mike McGee in Application Development).

If at all possible, try to think of a good, descriptive, real-world name for the join table. What is the connection between Mike and Application Development called in the real world?

How about "Enrollment"?

Add the Character CRUD resource to our application:

```
rails generate draft:resource enrollment course_id:integer student_id:integer
```

`rails db:migrate` as usual and navigate to `/enrollments` and verify that the CRUD resource boilerplate was generated properly. Then, add a few rows:

```
rails dev:prime_enrollments
```

(This might take a minute.)

### Every Many-to-Many is just two One-to-Manies

We now have two foreign keys in the enrollments table. That means, essentially, **we've broken the many-to-many between Courses and Students down into two one-to-manies**. A enrollment belongs to a course, a course has many enrollments. A enrollment belongs to an student, an student has many enrollments.

So, we should first go through the steps we went through above when we were setting up the one-to-many between departments and courses:

1. Currently, on the enrollments index page and a enrollment's show page, the code that the generator wrote for you is showing users raw course ID numbers. This is bad. Replace the id number with the title of the course and link that title to the course's show page.
1. On the new and edit enrollment pages, let's give our users a dropdown box to select a course, rather than having to type in a valid ID number. Let's use the `select_tag` view helper method to make this slightly easier than writing the raw HTML `<select>` and `<option>` tags by hand:

    ```erb
    <%= select_tag("course_id", options_from_collection_for_select(Course.all, :id, :title, @enrollment.try(:course_id)), :class => "form-control") %>
    ```

1. Let's also add a link to the new course form in case the course doesn't exist yet.
1. On a course's show page, display a count of how many students are enrolled in that course.
1. On a course's show page, display a list of the enrollments that belong to that course.
1. At the bottom of the list of enrollments, write a form to enroll a new student directly to that course (without having to go to "/enrollments/new"). You can start by copying over the boilerplate new enrollment form, and then modify it to pre-populate the `course_id` input with the correct value. Finally, switch the `type` of the input to "hidden".

Do the same steps for the one-to-many relationship between students and enrollments.

> Since there is no single `name` column for students, use `last_name` in any dropdowns.

### The last hop

Now that you have a list of enrollments on a course's show page, replace the enrollment with the associated student name -- voilà, we have a roster.

Now that you have a list of enrollments on a student's show page, replace the enrollment with the associated course title -- voilà, we have a course load.

**We have achieved the many-to-many relationship between courses and students by adding a join table (enrollments) and then building two one-to-manies.**
