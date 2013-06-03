function createCORSRequest(method, url) 
{
  var xhr = new XMLHttpRequest();
  if ("withCredentials" in xhr) 
  {
    xhr.open(method, url, true);
  } 
  else if (typeof XDomainRequest != "undefined") 
  {
    xhr = new XDomainRequest();
    xhr.open(method, url);
  } 
  else 
  {
    xhr = null;
  }
  return xhr;
}

/**
 * Use a CORS call to upload the given file to S3. Assumes the url
 * parameter has been signed and is accessible for upload.
 */
function uploadToS3(file, url, content_type)
{
  var xhr = createCORSRequest('PUT', url);
  if (!xhr) 
  {
    setProgress(0, 'CORS not supported');
  }
  else
  {
    xhr.onload = function() 
    {
      if(xhr.status == 200)
      {
        setProgress(100, 'Upload completed.');
      }
      else
      {
        setProgress(0, 'Upload error: ' + xhr.status);
      }
    };

    xhr.onerror = function() 
    {
      setProgress(0, 'XHR error.');
    };

    xhr.upload.onprogress = function(e) 
    {
      if (e.lengthComputable) 
      {
        var percentLoaded = Math.round((e.loaded / e.total) * 100);
        setProgress(percentLoaded, percentLoaded == 100 ? 'Finalizing.' : 'Uploading.');
      }
    };

    xhr.setRequestHeader('Content-Type', content_type);
    //xhr.setRequestHeader('x-amz-acl', 'public-read');
    xhr.send(file);
  }
}
