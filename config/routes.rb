Rails.application.routes.draw do
  match 'cep' => 'zip_code#show'
end
