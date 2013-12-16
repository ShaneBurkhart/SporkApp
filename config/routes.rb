Spork::Application.routes.draw do

  mount StripeEvent::Engine => '/stripe'


  get "team" => "about#index"

  authenticated :user do
    root :to => 'home#index'
  end

  root :to => "home#index"

  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    # put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end

end
