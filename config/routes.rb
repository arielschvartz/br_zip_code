Rails.application.routes.draw do
  get 'zip_code' => 'zip_code#show', as: :zip_code
end
