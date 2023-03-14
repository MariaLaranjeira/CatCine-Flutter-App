
## Requirements

### Domain model

 <p align="center" justify="center">
  <img src="https://user-images.githubusercontent.com/92693155/224856512-4a52a713-9c50-4f3e-8d33-6fe0156623ab.jpg">
</p>

**Media:** Class that defines each Film or TV Show.
-imdb_id: the Film's/Show's corresponding Imdb ID, as the name suggests
-name: Film's/Show's title
-date: Film's/Show's release date
-time: Film's/Show's runtime
-picture: Film's/Show's url for their cover image
-description: Film's/Show's summary

**Rate:** Class defines a User Rating given to a determined Film or Show.
-time: At what time the Film/Show was rated

**Review:** Class defines a User Review.

**Category:** Class defines a Category.
-name: The Category's name
-image: url for a Category's cover image
-description: Category's description

**User:** class defines an User
-catname: User's CatCine username
-email: User's email used for login
-password: User's account password

**Association class between User and Category**: An user can leave a like on a category
**Association class between User, Category and Media**: An user can leave an upvote or downvote in a Film/Show inside a category
