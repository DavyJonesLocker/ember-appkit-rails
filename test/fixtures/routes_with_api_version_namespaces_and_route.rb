Dummy::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :dogs, except: [:new, :edit]
    end

  end

  namespace :dogs do

  end
end
