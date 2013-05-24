# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $("#new_product_submit").hide()

  uploadFile = (file) ->
    # Figure out the signature
    $.getJSON("/generate_signed_s3_url?filename=#{file.name}&content_type=#{file.type}", (data) ->
      uploadToS3(file, data.put_url)
      $("#product_url").val(data.file_url)
    )


  $("#files").change (obj) -> 
    # We only allow one file per selection
    file = obj.target.files[0]
    uploadFile(file)
    $("#files").remove()
    $("#new_product_submit").show()

  
