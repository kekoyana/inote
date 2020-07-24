# frozen_string_literal: true

Rails.application.routes.draw do
  resources :notes, only: %i[index create]
end
