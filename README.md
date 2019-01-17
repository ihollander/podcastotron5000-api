# Podcast API Server

This is the backend API for a React podcast management tool. See [https://github.com/ihollander/podcastotron5000](https://github.com/ihollander/podcastotron5000) for more details.

To setup and start the server: 

Install gems:
`bundle install`

Setup database:
`rails db:create && rails db:migrate`

Start server on port 4000 to communicate with frontend:
`rails s -p 4000`