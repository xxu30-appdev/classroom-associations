# Classroom

## Setup

 1. Clone this repo to your workspace as usual
 1. In a Terminal, run `bin/setup` as usual.
 1. In a Terminal, run `bin/server` as usual.
 1. Preview running application as usual.
 1. Note: as you are working and running into error messages, you may be prompted to run a different `bin/whitelist X.X.X.X` command each time your IP address/location changes; copy-paste it into a terminal prompt if so.
 1. Check your progress/submit your work with `rails grade:all` as usual.

> If at any point `rspec` fails with the message "Migrations are pending. To resolve this issue, run: bin/rake db:migrate RAILS_ENV=test" then run
>
> `rails db:migrate RAILS_ENV=test`

## Introduction

You'll start with an almost blank application that just has a navbar with links corresponding to each necessary resource.

This application has 2 database tables:

 - students (columns: first_name, last_name, email)
 - courses (columns: name)

Each resource needs 7 "golden" actions to allow users to interact with it:

### CREATE

 - new_form
 - create_row

### READ

 - index
 - show

### UPDATE

 - edit_form
 - update_row

### DELETE

 - destroy

Build the Golden Seven for Students and Courses from scratch, the same way that you did for Photogram Golden 7. Hint: [the README for Photogram Golden 7](https://github.com/appdev-projects/photogram-golden-7#photogram-golden-seven) will come in handy.

### [Here is your target.](https://classroom-target.herokuapp.com/)

Make yours work like it. Your local app is using a light theme, and the reference app is using a dark theme so that you don't get confused between tabs as you try to check your work.

If you run into any problems or error messages, **use the server log to help figure out what's going on.**

---

All in all, you need to:

 - Build the Golden Seven for Students from scratch
 - Build the Golden Seven for Courses from scratch

I've already generated the models for you, so you just have to do the RCAVs.
