<%-- 
    Document   : Player
    Created on : Oct 1, 2021, 1:09:21 PM
    Author     : jv
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Music Player</title>
  <link rel="stylesheet" href="styles/stylePlayer.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA==" crossorigin="anonymous" referrerpolicy="no-referrer" />-->
  
</head>
<body>
  <div class="wrapper">
    <div class="top-bar">
      <img src="dekuAll.jpg" alt="">
      <span>Now Playing</span>
      <i class="material-icons" id="menu">more_horiz</i>
    </div>
    <div class="img-area">
      <img src="" alt="">
    </div>
    <div class="song-details">
      <p class="name"></p>
      <p class="artist"></p>
    </div>
    <div class="progress-area">
      <div class="progress-bar">
        <audio id="main-audio" src=""></audio>
      </div>
      <div class="song-timer">
        <span class="current-time">0:00</span>
        <span class="max-duration">0:00</span>
      </div>
    </div>
    <div class="controls">
      <i id="repeat-plist" class="material-icons" title="Playlist looped">repeat</i>
      <i id="prev" class="material-icons">skip_previous</i>
      <div class="play-pause">
        <i class="material-icons play">play_arrow</i>
      </div>
      <i id="next" class="material-icons">skip_next</i>
      <i id="more-music" class="material-icons">queue_music</i>
    </div>
    <div class="music-list">
      <div class="header">
        <div class="row">
          <i class= "list material-icons">queue_music</i>
          <span>Music list</span>
        </div>
        <i id="close" class="material-icons">close</i>
      </div>
      <ul>
        <!-- here li list are coming from js -->
      </ul>
    </div>
    <div class="menu" id="dropdown">
      <ul>
        <li><i class="material-icons">add</i><p> Musica </p></li>
        <li><i class="material-icons">logout</i><p> Sair </p></li>
      </ul>
    </div>
  </div>
    
    <div class="add-music">
        <form method="POST" action="musicController" enctype="multipart/form-data">
            <label>Nome da música:</label><br>
            <input name="txtMusic"><br>
            <label>Nome do autor:</label><br>
            <input name="txtAutor"><br>
            <label for="myfileIMG">Selecione a imagem:</label><br>
            <input type="file" id="myfileIMG" name="myfileIMG" accept="image/*" ><br>
            <label for="myfile2">Selecione a música:</label><br>
            <input type="file" id="myfileMP3" name="myfile2" accept="audio/*"><br>
            <button type="submit">Adicionar</button>
        </form>
    </div>

  <script src="js/music-list.js"></script>
  <script src="js/scriptPlayer.js"></script>
  
      <script>// To add more song, just copy the following code and paste inside the array

//   {
//     name: "Here is the music name",
//     artist: "Here is the artist name",
//     img: "image name here - remember img must be in .jpg formate and it's inside the images folder of this project folder",
//     src: "music name here - remember img must be in .mp3 formate and it's inside the songs folder of this project folder"
//   }

//paste it inside the array as more as you want music then you don't need to do any other thing
    let allMusic = [];   
    $.get("listSource", function(populateArray) {
        /// code here
    }
                  );
    document.write(allMusic);

/*let allMusic = [
  {
    name: "Harley Bird - Home",
    artist: "Jordan Schor",
    img: "music-1",
    src: "music-1"
  },
  {
    name: "Ikson Anywhere – Ikson",
    artist: "Audio Library",
    img: "music-2",
    src: "music-2"
  },
  {
    name: "Beauz & Jvna - Crazy",
    artist: "Beauz & Jvna",
    img: "music-3",
    src: "music-3"
  },
  {
    name: "Hardwind - Want Me",
    artist: "Mike Archangelo",
    img: "music-4",
    src: "music-4"
  },
  {
    name: "Jim - Sun Goes Down",
    artist: "Jim Yosef x Roy",
    img: "music-5",
    src: "music-5"
  },
  {
    name: "Lost Sky - Vision NCS",
    artist: "NCS Release",
    img: "music-6",
    src: "music-6"
  },
  // like this paste it and remember to give comma after ending of this bracket }
  // {
  //   name: "Here is the music name",
  //   artist: "Here is the artist name",
  //   img: "image name here - remember img must be in .jpg formate and it's inside the images folder of this project folder",
  //   src: "music name here - remember img must be in .mp3 formate and it's inside the songs folder of this project folder"
  // }
];*/</script>
<script>
    const wrapper = document.querySelector(".wrapper"),
    musicImg = wrapper.querySelector(".img-area img"),
    musicName = wrapper.querySelector(".song-details .name"),
    musicArtist = wrapper.querySelector(".song-details .artist"),
    playPauseBtn = wrapper.querySelector(".play-pause"),
    prevBtn = wrapper.querySelector("#prev"),
    nextBtn = wrapper.querySelector("#next"),
    mainAudio = wrapper.querySelector("#main-audio"),
    progressArea = wrapper.querySelector(".progress-area"),
    progressBar = progressArea.querySelector(".progress-bar"),
    musicList = wrapper.querySelector(".music-list"),
    moreMusicBtn = wrapper.querySelector("#more-music"),
    closemoreMusic = musicList.querySelector("#close"),
    menu = wrapper.querySelector("#menu"),
    dropdown = document.querySelector('.menu');


    let musicIndex = Math.floor((Math.random() * allMusic.length) + 1);
    isMusicPaused = true;

    window.addEventListener("load", ()=>{
      loadMusic(musicIndex);
      playingSong(); 
    });

    function loadMusic(indexNumb){
      musicName.innerText = allMusic[indexNumb - 1].name;
      musicArtist.innerText = allMusic[indexNumb - 1].artist;
      musicImg.src = `images/${allMusic[indexNumb - 1].src}.jpg`;
      mainAudio.src = `songs/${allMusic[indexNumb - 1].src}.mp3`;
    }

    //play music function
    function playMusic(){
      wrapper.classList.add("paused");
      playPauseBtn.querySelector("i").innerText = "pause";
      mainAudio.play();
    }

    //pause music function
    function pauseMusic(){
      wrapper.classList.remove("paused");
      playPauseBtn.querySelector("i").innerText = "play_arrow";
      mainAudio.pause();
    }

    //prev music function
    function prevMusic(){
      musicIndex--; //decrement of musicIndex by 1
      //if musicIndex is less than 1 then musicIndex will be the array length so the last music play
      musicIndex < 1 ? musicIndex = allMusic.length : musicIndex = musicIndex;
      loadMusic(musicIndex);
      playMusic();
      playingSong(); 
    }

    //next music function
    function nextMusic(){
      musicIndex++; //increment of musicIndex by 1
      //if musicIndex is greater than array length then musicIndex will be 1 so the first music play
      musicIndex > allMusic.length ? musicIndex = 1 : musicIndex = musicIndex;
      loadMusic(musicIndex);
      playMusic();
      playingSong(); 
    }

    // play or pause button event
    playPauseBtn.addEventListener("click", ()=>{
      const isMusicPlay = wrapper.classList.contains("paused");
      //if isPlayMusic is true then call pauseMusic else call playMusic
      isMusicPlay ? pauseMusic() : playMusic();
      playingSong();
    });

    //prev music button event
    prevBtn.addEventListener("click", ()=>{
      prevMusic();
    });

    //next music button event
    nextBtn.addEventListener("click", ()=>{
      nextMusic();
    });

    // update progress bar width according to music current time
    mainAudio.addEventListener("timeupdate", (e)=>{
      const currentTime = e.target.currentTime; //getting playing song currentTime
      const duration = e.target.duration; //getting playing song total duration
      let progressWidth = (currentTime / duration) * 100;
      progressBar.style.width = `${progressWidth}%`;

      let musicCurrentTime = wrapper.querySelector(".current-time"),
      musicDuartion = wrapper.querySelector(".max-duration");
      mainAudio.addEventListener("loadeddata", ()=>{
        // update song total duration
        let mainAdDuration = mainAudio.duration;
        let totalMin = Math.floor(mainAdDuration / 60);
        let totalSec = Math.floor(mainAdDuration % 60);
        if(totalSec < 10){ //if sec is less than 10 then add 0 before it
          totalSec = `0${totalSec}`;
        }
        musicDuartion.innerText = `${totalMin}:${totalSec}`;
      });
      // update playing song current time
      let currentMin = Math.floor(currentTime / 60);
      let currentSec = Math.floor(currentTime % 60);
      if(currentSec < 10){ //if sec is less than 10 then add 0 before it
        currentSec = `0${currentSec}`;
      }
      musicCurrentTime.innerText = `${currentMin}:${currentSec}`;
    });

    // update playing song currentTime on according to the progress bar width
    progressArea.addEventListener("click", (e)=>{
      let progressWidth = progressArea.clientWidth; //getting width of progress bar
      let clickedOffsetX = e.offsetX; //getting offset x value
      let songDuration = mainAudio.duration; //getting song total duration

      mainAudio.currentTime = (clickedOffsetX / progressWidth) * songDuration;
      playMusic(); //calling playMusic function
      playingSong();
    });

    //change loop, shuffle, repeat icon onclick
    const repeatBtn = wrapper.querySelector("#repeat-plist");
    repeatBtn.addEventListener("click", ()=>{
      let getText = repeatBtn.innerText; //getting this tag innerText
      switch(getText){
        case "repeat":
          repeatBtn.innerText = "repeat_one";
          repeatBtn.setAttribute("title", "Song looped");
          break;
        case "repeat_one":
          repeatBtn.innerText = "shuffle";
          repeatBtn.setAttribute("title", "Playback shuffled");
          break;
        case "shuffle":
          repeatBtn.innerText = "repeat";
          repeatBtn.setAttribute("title", "Playlist looped");
          break;
      }
    });

    //code for what to do after song ended
    mainAudio.addEventListener("ended", ()=>{
      // we'll do according to the icon means if user has set icon to
      // loop song then we'll repeat the current song and will do accordingly
      let getText = repeatBtn.innerText; //getting this tag innerText
      switch(getText){
        case "repeat":
          nextMusic(); //calling nextMusic function
          break;
        case "repeat_one":
          mainAudio.currentTime = 0; //setting audio current time to 0
          loadMusic(musicIndex); //calling loadMusic function with argument, in the argument there is a index of current song
          playMusic(); //calling playMusic function
          break;
        case "shuffle":
          let randIndex = Math.floor((Math.random() * allMusic.length) + 1); //genereting random index/numb with max range of array length
          do{
            randIndex = Math.floor((Math.random() * allMusic.length) + 1);
          }while(musicIndex == randIndex); //this loop run until the next random number won't be the same of current musicIndex
          musicIndex = randIndex; //passing randomIndex to musicIndex
          loadMusic(musicIndex);
          playMusic();
          playingSong();
          break;
      }
    });

    //show music list onclick of music icon
    moreMusicBtn.addEventListener("click", ()=>{
      musicList.classList.toggle("show");
    });
    closemoreMusic.addEventListener("click", ()=>{
      moreMusicBtn.click();
    });

    const ulTag = wrapper.querySelector("ul");
    // let create li tags according to array length for list
    for (let i = 0; i < allMusic.length; i++) {
      //let's pass the song name, artist from the array
      let liTag = `<li li-index="${i + 1}">
                    <div class="row">
                      <span>${allMusic[i].name}</span>

                      <p>${allMusic[i].artist}</p>

                    </div>
                    <div class="btn-delete-edit">
                      <i class="material-icons">block</i>
                      <i class="material-icons">edit</i>
                      <!-- comentário era para estar aqui -->
                    </div>
                    <audio class="${allMusic[i].src}" src="songs/${allMusic[i].src}.mp3"></audio>
                  </li>`;  /*O COMENTÁRIO --->  <div class="artista-tempo"><span id="${allMusic[i].src}" class="audio-duration">3:40</span></div>*/ 
      ulTag.insertAdjacentHTML("beforeend", liTag); //inserting the li inside ul tag


      let liAudioDuartionTag = ulTag.querySelector(`#${allMusic[i].src}`);
      let liAudioTag = ulTag.querySelector(`.${allMusic[i].src}`);
      liAudioTag.addEventListener("loadeddata", ()=>{
        let duration = liAudioTag.duration;
        let totalMin = Math.floor(duration / 60);
        let totalSec = Math.floor(duration % 60);
        if(totalSec < 10){ //if sec is less than 10 then add 0 before it
          totalSec = `0${totalSec}`;
        };
        liAudioDuartionTag.innerText = `${totalMin}:${totalSec}`; //passing total duation of song
        liAudioDuartionTag.setAttribute("t-duration", `${totalMin}:${totalSec}`); //adding t-duration attribute with total duration value
      });
    }

    //play particular song from the list onclick of li tag
    function playingSong(){
      const allLiTag = ulTag.querySelectorAll("li");

      for (let j = 0; j < allLiTag.length; j++) {
        let audioTag = allLiTag[j].querySelector(".audio-duration");

        if(allLiTag[j].classList.contains("playing")){
          allLiTag[j].classList.remove("playing");
          let adDuration = audioTag.getAttribute("t-duration");
          audioTag.innerText = adDuration;
        }

        //if the li tag index is equal to the musicIndex then add playing class in it
        if(allLiTag[j].getAttribute("li-index") == musicIndex){
          allLiTag[j].classList.add("playing");
          audioTag.innerText = "Playing";
        }

        allLiTag[j].setAttribute("onclick", "clicked(this)");
      }
    }

    //particular li clicked function
    function clicked(element){
      let getLiIndex = element.getAttribute("li-index");
      musicIndex = getLiIndex; //updating current song index with clicked li index
      loadMusic(musicIndex);
      playMusic();
      playingSong();
    }

    /* ABRIR E FECHAR O MENU O MENU*/
    menu.addEventListener("click", ()=> {
      if (dropdown.style.visibility == 'visible') {
        dropdown.style.visibility = 'hidden';
        dropdown.style.opacity = 0;
      }else{
        dropdown.style.opacity = 1;
        dropdown.style.visibility = 'visible';
      }
      });

    document.documentElement.addEventListener('click', function(e) {
      if (e.target !== menu) {
        dropdown.style.visibility = 'hidden';
        dropdown.style.opacity = 0;
      }
    });

</script>    
</body>
</html>
