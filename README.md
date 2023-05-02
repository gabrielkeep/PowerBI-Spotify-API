# PowerBI-Spotify-API

Recently, I found a good playlist for increase focus on Spotify, called "Attention Focus", so I decided to analyzing the songs of this playlist using Power BI

![image](https://user-images.githubusercontent.com/115597735/235776633-ca43b394-9905-47b5-829c-ad37fc2ecbbb.png)

## How the dashboard works

Looking at the dashboard, you can select one or more songs. On the left it will show the name of the song, the artist and album. You also can see the duration of the song in minutes, its popularity, the type of the album (single, album or compilation), a ranking of songs by popularity and the year of release.


## How I got the data?

  The Spotify have an API, that premium and free acounts can acess, its called [Spotify for Developers](https://developer.spotify.com/). To get the data I followed the next steps:
  
  1. Created an application in Spotify for Developers
  2. Got the ClientID and the ClientSecret
  3. Requested the token using terminal
  4. Copied the token
  5. Made a request on Power Query passing the authorization token
  
## Modeling the Data
![image](https://user-images.githubusercontent.com/115597735/235780235-11769dfb-c5a4-43d5-b410-141c166d2ca2.png)

The relationship between Album and Playlist is one-to-many, and the direction of cross filters points to both tables. The same occurs with Artists and Playlist, there is also another table, a calendar dimension that is one-to-many with the Album table, and points to Album.
