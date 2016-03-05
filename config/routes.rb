SimpleNestedComments::Engine.routes.draw do
  resources :nested_comments, only: :create
end
