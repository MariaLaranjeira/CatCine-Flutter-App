
# Architecture and Design

The main components of the project are the client, the server, and the API. The client is the mobile application that runs on the user's electronic device, which is responsible for presenting data to the user, processing user inputs, and sending requests to the server for data. The server component of the project is responsible for processing requests from the client, retrieving data from the API, and sending responses back to the client. 
To ensure scalability and reliability, we used the Client-Server pattern, which separates the client and server components and enables them to communicate over a network. 
In this section we'll describe the logical and physical architectures of our project.

## Logical architecture

<p align="center">
    <img src = "https://user-images.githubusercontent.com/114760605/224853948-28e7497b-acd7-452c-8d59-943257c4ffea.png" width = 90% height = 90%>
</p>

- ### CatCine GUI
    This package contains the code that defines the graphical user interface (GUI) of the CatCine app, which enables users to interact with the application visually.
    
- ### CatCine Logic
    This package contains the backend logic of the app. It is responsible for the manipulation and management of user data.
    
- ### CatCine Database Scheme
    This package contains the code that defines the structure of the database where some of the data necessary for the application is stored.
   
- ### MDbList's API
    External API responsible for supplying information about movies.

## Physical architecture
    
<p align="center">
    <img src = "https://user-images.githubusercontent.com/114760605/224854041-1d8e17e8-61a1-4e3a-af3c-aab2d8088ff9.png" width = 90% height = 90%>
</p>

- ### User mobile Phone
    The electronic device on which the application will be executed or used.

- ### CatCine Server Machine
    A computer system that runs the backend for the CatCine application. It acts as an intermediary between the user's mobile device and the Rapid API Machine, receiving user requests and providing the expected services by communicating with the Rapid API Machine, and then responding to the user's requests. It also hosts the CatCine database, which stores and manages data related to the CatCine application, such as movie ratings, watchlists and watched movies.

- ### Rapid API Machine
    It is responsible for managing API requests and responses for the CatCine application. It may host APIs that provide data to implement the features of our app, such as movie data.

## Vertical prototype

So far we have implemented a basic Explore Page UI and the API, which successfully fetches the films/shows information and already displays their name in the app according to the User's search. We have also set up the firebase database which is ready to be used in our code.

