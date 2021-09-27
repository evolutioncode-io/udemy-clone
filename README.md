# README

https://???.herokuapp.com/   < Live App

rails new udemy-clone -d=postgresql
cd udemy-clone
git init
gaa .
gcmsg 'initial commit'
rake db:create
rake db:migrate
--- Create the github repository
git remote add origin https://github.com/evolutioncode-io/???.git
git branch -M main
git push -u origin main

---
EDITOR=vim rails credentials:edit
add secret password / tokens
<ESC> wq
---
heroku create
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
git push heroku main
heroku run rails db:migrate
heroku run rake db:seed

heroku pg:reset DATABASE_URL  << para borrar los datos de las tablas en heroku
---
rails db:seed
rails generate devise:install
rails generate devise User

heroku run rails console   << para interactuar con los datos
heroku logs --tail         << para ver los logs de Heroku
---

INSTALAR BOOTSTRAP
 yarn add jquery popper.js bootstrap
 mkdir app/javascript/stylesheets
 echo > app/javascript/stylesheets/application.scss
 https://blog.corsego.com/rails-6-install-bootstrap-with-webpacker-tldr

yarn add @fortawesome/fontawesome-free

rails generate simple_form:install --bootstrap

rails g scaffold Course title:string description:text
