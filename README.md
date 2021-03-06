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

FRINDLY_ID  a enrollments
    rails g migration AddSlugToEnrollments slug:uniq
    rails db:migrate
    en el enrollment controller ... cambia de 
        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
        end

        @enrollment = Enrollment.friendly.find(params[:id])

    y en el modelo de enrollment.rb se agrega
       extend FriendlyId
   friendly_id :to_s, use: :slugged
   y para cambiar los datos que ya existian .. se va a la consola Rails c y se escribe: Enrollment.find_each(&:save)

RAMSACK  .. para poder hacer busqueda dentro de enrollmets
    enrollment controller
        se cambia de :
            def index
              @pagy, @enrollments = pagy(Enrollment.all)
              authorize @enrollments
            end
            a
            def index
              @q = Enrollment.ransack(params[:q])
              @pagy, @enrollments = pagy(@q.result.includes(:user))
            end
    y en enrollment index para ver y pedir los filtros:
        = search_form_for @q do |f|
        = f.search_field :user_email_cont, placeholder: 'user email'
        = f.search_field :course_title_cont, placeholder: 'course title'
        = f.search_field :price_eq, placeholder: 'price'
        = f.search_field :rating_eq, placeholder: 'rating'
        = f.search_field :review_cont, placeholder: 'review'
        = f.submit
      = link_to 'refresh', enrollments_path

    y en los datos:
        %th
          = sort_link(@q, :user_email)
          /.fa.fa-user
          /User
        %th

get :purchased, on: :collection ??

      2.10.2 Adding Collection Routes
      A collection route doesn't require an ID because it acts on a collection of objects
      :collection creates path with the pattern /:controller/:your_method
      To add a route to the collection, use a collection block:

      resources :photos do
        collection do
          get 'search'
        end
      end

      This will enable Rails to recognize paths such as /photos/search with GET, and route to the search action of PhotosController. It will also create the search_photos_url and search_photos_path route helpers.

      Just as with member routes, you can pass :on to a route:

      resources :photos do
        get 'search', on: :collection
      end

scope :pending_review, -> { where(rating: [0, nil, ""], review: [0, nil, ""]) }

  scope:  Scope defines where in a program a variable is accessible. Ruby has four types of variable scope, local, global, instance and class. In addition, Ruby has one constant type. ... These are nil which is assigned to uninitialized variables and self which refers to the currently executing object.

  lambda:  Ruby lambdas allow you to encapsulate logic and data in an eminently portable variable. A lambda function can be passed to object methods, stored in data structures, and executed when needed. Lambda functions occupy a sweet spot between normal functions and objects.  Aqui el -> es la forma de crear un lambda 

code to embed youtube:  https://gist.github.com/yshmarov/90377ba51f14df09df03e6442cd7412e

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

