# SAML redirect for Google Workspace™ by Devoteam G Cloud

This repository contains a  Node.js application designed to be deployed as a Google Cloud Run service. It provides a dynamic HTTP redirect based on a query parameter that will skip the payload that prevent proper redirection from some website.

## Functionality

The service listens for HTTP GET or POST requests. It expects a query parameter named `targetUrl`.

*   **If `targetUrl` is provided and valid (starts with `http://` or `https://`)**: The service responds with an HTTP 302 Found redirect to the specified URL.
*   **If `targetUrl` is missing, empty, or invalid**: The service responds with an HTTP 400 Bad Request error.

## Usage

Once deployed, you can use the service URL like this:

`https://<your-cloud-run-service-url>/?targetUrl=https://www.google.com`

Replace `<your-cloud-run-service-url>` with the actual URL provided by Cloud Run after deployment. Replace `https://www.google.com` with the desired destination URL.

**Example:**

Accessing `https://my-redirector-xyz.a.run.app/?targetUrl=https://developer.mozilla.org` will redirect your browser to `https://developer.mozilla.org`.

Accessing `https://my-redirector-xyz.a.run.app/` (without the parameter) will result in a "Bad Request" error page.

## Deployment to Cloud Run

You can deploy this service directly to Google Cloud Run using the button below:

[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

**Deployment Steps:**

1.  Click the "Run on Google Cloud" button.
2.  If prompted, log in to your Google Cloud account.
3.  Select or create a Google Cloud Project.
4.  Choose a Region for deployment.
5.  Review the default service settings (you can customize them if needed, based on `app.json`).
6.  Click "Deploy".

Cloud Build will build the container image using the included `Dockerfile` and deploy it as a Cloud Run service. The service will be configured to allow unauthenticated access by default.

## Files

*   `index.js`: The Node.js Cloud Function code using the Functions Framework.
*   `package.json`: Defines Node.js dependencies and the start script.
*   `Dockerfile`: Instructions for building the container image.
*   `app.json`: Configuration for the Cloud Run Button deployment flow.
*   `README.md`: This file.

## Local Development (Optional)

1.  Install Node.js (version specified in `package.json`).
2.  Install dependencies: `npm install`
3.  Run the function locally: `npm start`
4.  Access in your browser: `http://localhost:8080/?targetUrl=https://example.com`
