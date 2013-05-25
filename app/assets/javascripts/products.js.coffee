# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

uploadFile = (file) ->
  # Figure out the signature by asking the server.
  # We need to do this on the server side to not expose the AWS secret key
  $.getJSON("/generate_signed_s3_url?filename=#{file.name}&content_type=#{file.type}", (data) ->
    uploadToS3(file, data.put_url)
    $("#product_url").val(data.file_url)
  )
  
# Updates the upload progress
window.setProgress = (progress, str) ->
  $(".progress .bar").css("width", progress + "%");
  $("#product-upload-progress .text").text(str)

  # When the progress is 100%, form can be submitted
  if progress == 100
    $("#new_product_submit").show()

$ ->

  # Hide irrelevant elements
  $("#product-upload-progress").hide()
  $("#new_product_submit").hide()

  # When the form is submitted, remove the file, since it's uploaded already
  $("#new_product_submit").click ->
    $("#product_file").remove()
    #$("#new_product").submit()
    return true

  # When a file is chosen, upload it
  $("#product_file").change (obj) ->
    # We only allow one file per selection
    file = obj.target.files[0]

    # Check if the file is larger than 500MB
    if file.size > 500 * 1024 * 1024
      alert("File cannot be larger than 500MB.")
      return false

    # Show the progress bar
    $("#product-upload-progress").show()
    
    uploadFile(file)
