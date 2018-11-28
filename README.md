# papertrail-mailer

- scrape.rb contains the function `post_params_to_event_hash`, which takes the list of messages and parses it into a hash
- email.rb contains the function `html_email`, which takes the hash returned by scrape and turns it into an html email
- main.rb contains the sinatra server that accepts a post request and passes its payload, the list of events, to scrape.rb
- mail-test.rb is just me testing the mail gem
- webhook-test.rb is from one of Papertrail's gists, with the "events" list modified to have things closer to the messages from the screenshot that you sent. 