/**
 * Responds to any HTTP request.
 * Redirects the user to the URL specified in the 'targetUrl' query parameter.
 *
 * @param {!import('express').Request} req HTTP request context.
 * @param {!import('express').Response} res HTTP response context.
 */
exports.dynamicRedirect = (req, res) => {
  // Allow GET and POST methods
  if (req.method !== "POST" && req.method !== "GET") {
    console.warn(`Received non-GET/POST request: ${req.method}`);
    res.status(405).send('Method Not Allowed');
    return;
  }

  // Get the target URL from the query string
  const targetUrl = req.query.targetUrl;

  // Validate if targetUrl exists and is a non-empty string
  if (!targetUrl || typeof targetUrl !== 'string' || targetUrl.trim() === '') {
    console.error('Missing or invalid targetUrl query parameter.');
    res.status(400).send('Bad Request: Missing or invalid "targetUrl" query parameter.');
    return;
  }

  // Basic check to ensure it looks somewhat like a URL (starts with http/https)
  // NOTE: This is a very basic check. For production, consider more robust URL validation.
  if (!targetUrl.startsWith('http://') && !targetUrl.startsWith('https://')) {
      console.error(`Invalid URL format for targetUrl: ${targetUrl}`);
      res.status(400).send('Bad Request: "targetUrl" parameter must start with http:// or https://');
      return;
  }


  console.log({
    event: "Dynamic Redirection",
    method: req.method,
    from: req.originalUrl,
    to: targetUrl
  });

  // Perform the redirect
  res.redirect(302, targetUrl);
  // No need for res.end() after res.redirect() in Express
};
