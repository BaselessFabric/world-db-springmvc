<h1>World-DB-Spring-MVC</h1>

## Live Demo

The project can be viewed by visiting https://3xzxquhfxy.eu-west-2.awsapprunner.com/
- Username: user
- Password: password

## Project Overview
This project creates a Java application that uses an SQL database containing a list of countries and cities, along with other details. This application allows users to query certain fields within the database, following the Spring architecture layout: Entities -> Repository -> Service -> Controller. I have implemented REST APIs and endpoints to allow the following CRUD methods while providing each page with a stylized and user-friendly design.

In addition, I have added a frontend user interface using Thymeleaf and implemented user login with Spring Security. This enhancement allows users to interact with the application through a web interface, providing a seamless and secure user experience. The login functionality ensures that only authenticated users can access certain features, maintaining the integrity and security of the application.

- POST /city: Adds a new city.
- GET /cities: Retrieves all cities.
- GET /city/{id}: Retrieves a city by its ID.
- GET /city/name: Retrieves cities by their name.
- PUT /city/{id}: Updates an existing city.
- DELETE /city/{id}: Deletes a city by its ID.
- The above is similar for the countries controller

## CI/CD Pipeline

This project implements a robust CI/CD pipeline:

1. Development Process:
   - Changes are pushed to the `dev` branch.
   - Pull requests are used to merge changes from `dev` to `main`.

2. Automated Deployment:
   - A webhook is configured to notify my Jenkins server of changes to the `main` branch.
   - Jenkins uses the Jenkinsfile in the repository to orchestrate the build and deployment process.

3. Build Process:
   - The application is built using Maven.
   - The built application is then containerized.

4. Deployment:
   - The container image is uploaded to AWS ECR (Elastic Container Registry).
   - Jenkins triggers an update to AWS App Runner.
   - AWS App Runner pulls the new ECR image and deploys it to a live URL.

This CI/CD setup ensures that every change merged to the main branch is automatically built, tested, and deployed, maintaining a streamlined and efficient development workflow.

## Acceptance Criteria
- Interact with the MySQL World Database
- Application allows user to view, add, update and delete from the 3 SQL tables
- Use Tailwind to develop the frontend of the site
- Use Spring security to secure the application.
- Tested with WebMVCTests and MockMVCTests

## Dependencies
- JDK 21

<h2>Connecting to your database</h2>

This application uses environment variables to configure the database connection. You need to set the following environment variables:

- `DB_URL`: The JDBC URL for your MySQL database
- `DB_USERNAME`: The username for your database
- `DB_PASSWORD`: The password for your database

For local development, you can set these variables in your IDE's run configuration or create a `.env` file in the project root (make sure to add `.env` to your `.gitignore`).

Example `.env` file:
```
spring.datasource.url=jdbc:mysql://localhost:3306/world
spring.datasource.username=<YOUR USERNAME>
spring.datasource.password=<YOUR PASSWORD>
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
```
For production deployment (such as on AWS App Runner), set these environment variables in your deployment configuration.

The `application.properties` file uses these environment variables:

```
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.jpa.hibernate.naming.physical-strategy=org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl
```

Ensure you have the World database on your local computer or have access to a MySQL instance with the World database.

In addition to ensuring your database is correctly connected to, please make sure to run this script to ensure you have the user tables.

```
create table if not exists users
(
    id        bigint       not null
        primary key,
    password  varchar(255) null,
    roles     varchar(255) null,
    user_name varchar(255) null
);

create table if not exists users_seq
(
    next_val bigint null
);

insert into users_seq (next_val) values (1);
```

## How to use the Program 
Open the program and run the main method.

Open up browser and access your localhost
```
http://localhost:8080/
```
From here you can access all the endpoints from the user interface.


## Feedback
📫 If you encounter any bugs, please open up an issue to let me know.
Alternatively, I welcome suggestions for any updates or improvements you would like to see! 
