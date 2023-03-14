
## Requirements

### Domain model

 <p align="center" justify="center">
  <img src="https://user-images.githubusercontent.com/92693155/224860308-f52eeb1a-e21e-439b-8f7d-f167da0bb6c0.jpeg">
</p>


**Media:** Class that defines each Film or TV Show.
- imdb_id: the Film's/Show's corresponding Imdb ID, as the name suggests
- name: Film's/Show's title
- date: Film's/Show's release date
- time: Film's/Show's runtime
- picture: Film's/Show's url for their cover image
- description: Film's/Show's summary

**Rate:** Class that defines a User Rating given to a determined Film or Show.
- time: At what time the Film/Show was rated

**Review:** Class that defines a User Review.

**Category:** Class that defines a Category.
- name: The Category's name
- image: url for a Category's cover image
- description: Category's description

**User:** Class that defines an User
- catname: User's CatCine username
- email: User's email used for login
- password: User's account password

**Association class between User and Category**: An user can leave a like on a category

<p></p>

**Association class between User, Category and Media**: An user can leave an upvote or downvote in a Film/Show inside a category
