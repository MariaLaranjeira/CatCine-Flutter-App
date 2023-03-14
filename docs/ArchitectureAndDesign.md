
# Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 

In this section you should start by briefly describing the overall components of the project and their interrelations. You should also describe how you solved typical problems you may have encountered, pointing to well-known architectural and design patterns, if applicable.

## Logical architecture

<p align="center">
    <img src = "https://user-images.githubusercontent.com/114760605/224853948-28e7497b-acd7-452c-8d59-943257c4ffea.png">
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
    <img src = "https://user-images.githubusercontent.com/114760605/224854041-1d8e17e8-61a1-4e3a-af3c-aab2d8088ff9.png">
</p>

- ### User mobile Phone
    The electronic device on which the application will be executed or used.

- ### CatCine Server Machine
    A computer system that runs the backend for the CatCine application. It acts as an intermediary between the user's mobile device and the Rapid API Machine, receiving user requests and providing the expected services by communicating with the Rapid API Machine, and then responding to the user's requests. It also hosts the CatCine database, which stores and manages data related to the CatCine application, such as movie ratings, watchlists and watched movies.

- ### Rapid API Machine
    It is responsible for managing API requests and responses for the CatCine application. It may host APIs that provide data to implement the features of our app, such as movie data.

## Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).

