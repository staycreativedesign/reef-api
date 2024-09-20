# README
```
Rails version             7.2.1
Ruby version              ruby 3.2.2 (2023-03-30 revision e51014f9c0) [arm64-darwin22]
RubyGems version          3.4.20
Rack version              3.1.7
Database adapter          postgresql
Database schema version   20240920160102
Docker version            25.0.0, build e758fe5a7f
```

Solution : Basic CRUD API
Added features

When Items or Ingredients are blank I could've returned a no_content but I've always ran into and felt that a 200 with info message saying to the dev go add some. 
Catch all Errors on application level giving information to the dev.  If need be said errors could be overwritten in the specific controller level. 

# TODO 
I'd graphql this. 
Authentication.
meta program errors. 

# Quick API Testing with Postman (https://www.postman.com/)

Load this document with Postman 
https://github.com/staycreativedesign/reef-api/blob/main/Reef%20API.postman_collection.json

Instructions after installing Postman to import collection
Open Postman
Click on Collections
Drag and drop file into collections area ( when you drag file it will say Import into Postman )
Review API documentation ( after you have logged in )
https://documenter.getpostman.com/view/2706642/2sAXqtZfjd#906d6f0b-3c88-4645-8d4d-2dfc66f15996

If you dont want to download Postman you can use this link
https://www.postman.com/developeyourdreams/my-workspace/overview
Hover over Test API @gustavop click the the circles 
Click on View Documentation

# Setting up container

Make sure you have docker desktop installed
https://www.docker.com/products/docker-desktop/

```
docker compose build
docker compose up
```
Hopefully it should work, docker is known to be finnicky.

If not just
```
bundle install
rails db:create
rails db:migrate
rails db:seed
```
yala bai!
