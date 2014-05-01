Rails.application.routes.draw do
  get 'zip_code/:id' => 'zip_code#show', as: :zip_code
end
