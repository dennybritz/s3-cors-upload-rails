class AwsController < ApplicationController
  include AwsHelper

  def generate_signed_s3_url
    # To avoid file collision, we prepend string to the filename
    filename = "#{SecureRandom.hex(4).to_s}_#{params[:filename]}"
    resource_endpoint = "http://#{ENV["AWS_S3_BUCKET"]}.s3.amazonaws.com/#{filename}"
    options = {
        :http_verb => "PUT", 
        :date => 1.hours.from_now.to_i, 
        :resource => "/#{ENV["AWS_S3_BUCKET"]}/#{filename}",
        :content_type => params[:content_type]
      }
    puts options
    url = AwsHelper.build_s3_upload_url(resource_endpoint, ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"], options)
    render :json => {:put_url => url, :file_url => resource_endpoint}.to_json
  end

end
