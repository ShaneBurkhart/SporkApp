Beerocity::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'

  get "content" => "content#basic"

  get "team" => "about#index"
  get "faq" => "faq#index"
#  get "contact" => "contact#index"
#  post "contact" => "contact#message"
#  get "tos" => "faq#index"

# The route to execute charges
# post "recipe/charge" => "recipes#charge"

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    # put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end

  resources :users, except: ["show"]
#  resources :recipes
  resources :comments, except: ["index", "show", "new"]
end
