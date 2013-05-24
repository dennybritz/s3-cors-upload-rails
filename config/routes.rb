S3CorsUploadRails::Application.routes.draw do

  root :to => "Products#new"
  resources :products

  match "generate_signed_s3_url" => "aws#generate_signed_s3_url"
  
end
