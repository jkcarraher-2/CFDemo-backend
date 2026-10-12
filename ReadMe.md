# CFDemo Application

The goal of this project is to provide help me walk through setting up features of a modern CF application, seeing how features with this framework compare to Node.js and equivelant backend frameworks. 

## System Architecture
<img height="750" alt="Screenshot 2026-10-12 at 11 21 44 AM" src="https://github.com/user-attachments/assets/a663bb92-77c2-4531-8cff-7a47cd4a1698" />

## Setup Instructions
1. To run this application locally, first create a `.env` file, emulating settings in the `.env.example`.


Then run the application with `Docker`.
```
docker compose up --build
```

OPTIONAL: While there is code for REST endpoints, they will not work by default. 

To run commands within the docker container.
```
docker exec -it [CONTAINER-NAME] bash
```
