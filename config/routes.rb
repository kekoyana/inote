# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    resources :notes, only: %i[index create]
  end
end
