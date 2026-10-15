# apple-music-compose
a docker compose project to run WorldObservationLog/wrapper (lite) and zhaarey/apple-music-downloader with ease

## notes
  - place urls in urls.txt<br>
  - songs are downloaded to .media (`ln -s $PATH .media` to override)<br>
  - login tokens are stored in .cache ('rm .cache' to logout) <br>
  
## build and login
```bash
USERNAME=example@gmail.com PASSWORD=urpasswd docker compose up --build
```

## run the wrapper and downloader
```bash
docker compose up
```
