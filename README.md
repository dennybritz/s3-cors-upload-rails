## Step 1 - Configure S3 for CORS

1. Create an Amazon S3 Bucket
2. Click on Properties -> Permissions -> Edit CORS
3. Enter a CORS configuration, such as the following. For security purposes you should restrict the origin further.

    ```<?xml version="1.0" encoding="UTF-8"?>
    <CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
        <CORSRule>
            <AllowedOrigin>*</AllowedOrigin>
            <AllowedOrigin>http://localhost:3000</AllowedOrigin>
            <AllowedMethod>PUT</AllowedMethod>
            <MaxAgeSeconds>3000</MaxAgeSeconds>
            <AllowedHeader>*</AllowedHeader>
        </CORSRule>
    </CORSConfiguration>```

## Step 2 - Set your AWS Keys and bucket

The application can be configured via the following environment variables.

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_S3_BUCKET`