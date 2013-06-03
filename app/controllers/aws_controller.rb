class AwsController < ApplicationController
  include AwsHelper

  def generate_signed_s3_url
    # To avoid file collision, we prepend string to the filename
    filename = "#{SecureRandom.hex(4).to_s}_#{params[:filename]}"

    # Content types
    content_type = "application/pdf" if filename.ends_with?(".pdf")
    content_type = "application/epub+zip" if filename.ends_with?(".epub")
    content_type = "application/x-mobipocket-ebook" if filename.ends_with?(".mobi")

    puts content_type
    resource_endpoint = "http://#{ENV["AWS_S3_BUCKET"]}.s3.amazonaws.com/#{filename}"
    options = {
        :http_verb => "PUT", 
        :date => 1.hours.from_now.to_i, 
        :resource => "/#{ENV["AWS_S3_BUCKET"]}/#{filename}",
        :content_type => content_type
      }
    puts options
    url = AwsHelper.build_s3_upload_url(resource_endpoint, ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"], options)
    render :json => {:put_url => url, :file_url => resource_endpoint, :content_type => content_type}.to_json
  end

end
