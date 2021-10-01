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

----
EDITOR=vim rails credentials:edit
add secret password / tokens
<ESC> wq
Stripe.api_key = Rails.application.credentials[:stripe][:secret]
---
heroku create
heroku config:set RAILS_MASTER_KEY=`cat config/master.key`
git push heroku main
heroku run rails db:migrate
heroku run rake db:seed

bundle lock --add-platform ruby  
bundle lock --add-platform x86_64-linux 
bundle install
git add .
git commit -m "Bundler fix"

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


GEM PUNDIT
En el folder de policies se crea un file con el nombre del modelo  en este ejemplo enrollment :  enrollment_policy.rb
      class EnrollmentPolicy < ApplicationPolicy
        class Scope < Scope
          def resolve
            scope.all
          end
        end

        def index?
          @user.has_role?(:admin)
        end
        
        def edit?
          @record.user_id == @user.id
        end

        def update?
          @record.user_id == @user.id
        end

        def destroy?
          @user.has_role?(:admin)
        end
      end
  
  Ahora en el enrollments_controller  se coloca la linea authorize @enrollments  que conecta el metodo con la policy
      def index
        authorize @enrollments
        @enrollments = Enrollment.all
      end
    

HELPERS:  una manera de sacar codigo confuso de las Views y Controller 

MODEL SCOPE: Scopes are custom queries that you define inside your Rails models with the scope method. Every scope takes two arguments: A name, which you use to call this scope in your code. A lambda, which implements the query

USAR PAGY para paginar users
    users-controller
        #@users = @q.result(distinct: true)  << lo anterior que usa ransack para buscar
        @pagy, @users = pagy(@q.result(distinct: true))
    users-index
        != pagy_bootstrap_nav(@pagy)   / al final para ver los botones
    config/initializers/pagy.rb  >> alla se puede cambiar el numero de items que muestra por pantalla y usar bootstrap
        require 'pagy/extras/bootstrap'
        Pagy::VARS[:items]  = 10  





rails new udemy-clone -d postgresql      
yarn add jquery popper.js bootstrap   
mkdir app/javascript/stylesheets 
echo > app/javascript/stylesheets/application.scss 
rails generate simple_form:install --bootstrap   
rails g scaffold Course title:string description:text 
yarn add bootstrap jquery popper.js   
yarn add @popperjs/core  
yarn add @fortawesome/fontawesome-free
rails action_text:install  
rails generate devise:install  
rails generate devise User  
rails g migration AddUserToCourses user:belongs_to
rails generate simple_form:install     
rails g migration AddSlugToCourses slug:uniq  
rails generate friendly_id    
rails g migration add_trackablecols_to_devise   
rails g migration add_confirmable_to_devise    
rails g migration add_fields_to_courses short_description:text language:string level:string price:integer
bin/rails db:environment:set RAILS_ENV=development
rails g public_activity:migration 
rails g rolify Role User 
rails g pundit:install 
rails g pundit:policy course
rails g pundit:policy user 

rails g migration AddSlugToUser slug:uniq  
rails g scaffold lessons title content:text course:references
rails g migration AddSlugToLessons slug:uniq