BrZipCode::Engine.routes.draw do
  get 'zip_code/:id' => 'br_zip_code/zip_code#show'
end
