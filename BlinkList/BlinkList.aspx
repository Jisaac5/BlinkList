<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BlinkList.aspx.cs" Inherits="BlinkList.BlinkList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BlinkList</title>
    <link rel="icon" type="image/x-icon" href="logoblink.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="styles.css" />
    <!-- Updated CSS reference -->
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="isLoggedIn" runat="server" Value="False" />
        <div class="container-fluid">
            <div class="sidebar">
                <!-- Logo picture container -->
                <div class="logo-container">
                    <img src="blinklogo2.png" alt="Logo" />
                    <input type="text" id="songSearch" class="search-input" placeholder="Search for a song..." />
                </div>
                <div class="navigation">
                    <ul>
                        <li>
                            <a href="#">
                                <span class="fa fa-home"></span>
                                <span>Home</span>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <span class="fa fas fa-book"></span>
                                <span>Your Library</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="navigation">
                    <ul>
                        <li>
                            <a href="#">
                                <span class="fa fas fa-plus-square"></span>
                                <span>Create Playlist</span>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <span class="fa fas fa-heart"></span>
                                <span>Liked Songs</span>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Playlist section -->
                <div class="playlist-section">
                    <h2>Playlists</h2>
                    <ul class="list-group">
                        <!-- Add playlist -->
                    </ul>

                </div>
            </div>

            <div class="content">
                <div class="main-container">
                    <div class="topbar">

                        <div class="navbar">
                            <ul>

                                <li>
                                    <a href="#">Support</a>
                                </li>
                                <li>
                                    <a href="#">Download</a>
                                </li>
                                <li class="divider">|</li>
                                <li class="nav-item" id="signin-nav">
                                    <a class="nav-link" href="Entry.aspx">Sign In</a>
                                </li>
                                <li class="nav-item" id="profile-nav" style="display: none;">
                                    <a class="nav-link" href="#" id="profile-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Profile</a>
                                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="profile-dropdown">
                                        <div class="dropdown-divider"></div>
                                        <asp:Button ID="btnSignout" runat="server"  class="dropdown-item" Text="Sign Out" OnClick="Signout_Event"/>  
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>


                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="album-filter">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                            <i class="fas fa-filter"></i>
                                        </button>
                                        <ul class="dropdown-menu" aria-labelledby="filterDropdown">
                                            <li><a class="dropdown-item" href="#" id="sortAlphabetically">Alphabetically</a></li>
                                            <li><a class="dropdown-item" href="#" id="sortDescending">Descending</a></li>
                                            <li><a class="dropdown-item" href="#" id="sortAscending">Ascending</a></li>
                                        </ul>
                                    </div>
                                </div>


                                <button class="album-button active" data-album="">All Songs</button>
                                <button class="album-button" data-album="Enema of the State"  type="button">Enema of the State</button>
                                <button class="album-button" data-album="take off your pants" type="button">Take Off Your Pants and Jacket</button>
                                <button class="album-button" data-album="dude ranch" type="button">Dude Ranch </button>
                                <button class="album-button" data-album="blink182" type="button">Blink-182</button>
                                <button class="album-button" data-album="marktom" type="button">The Mark, Tom, and Travis Show</button>
                            </div>
                            <div class="songListContainer">
                                <div id="songList" class="audio-list"></div>
                            </div>
                            <div class="pagination-buttons">
                                <button id="prevButton" class="btn pagination-button"type="button"><i class="fas fa-chevron-left"></i></button>
                                <button id="nextButton" class="btn pagination-button"type="button"><i class="fas fa-chevron-right"></i></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- New queue container -->
            <div class="queue-container" id="queueContainer">
                <div class="qcon">
                    <h3>Queue</h3>
                    <ul id="queueItems" class="queue-items"></ul>
                </div>
                <div id="Lyrics" class="lyrics"></div>
            </div>
        </div>




        <div class="audio-player">
            <div class="audio-info">
                <div id="songInfo">
                    <img id="albumCover" src="" alt="">
                    <span id="currentSong"></span>
                </div>
            </div>

            <div class="audio-controls">

                <button id="shuffleButton" class="shuffle-btn" title="Shuffle"type="button">
                    <i class="fas fa-random"></i>
                </button>

                <button id="previoussongButton" class="control-button"type="button"><i class="fas fa-backward"></i></button>
                <button id="playPauseButton" class="control-button"type="button"><i class="fas fa-play"></i></button>
                <button id="nextsongButton" class="control-button"type="button"><i class="fas fa-forward"></i></button>
                <div id="currentTime">0:00</div>
                <div class="audio-progress">
                    <input type="range" id="progressBar" min="0" max="100" value="0"/>
                </div>
                <div id="duration">0:00</div>

                <div class="volume-control">
                    <i id="volumeIcon" class="fas fa-volume-up volume-icon"></i>
                    <div id="volumeBarContainer" class="volume-bar-container">
                        <input type="range" id="volumeBar" min="0" max="1" step="0.01" value="1" class="vertical-volume-bar"/>
                    </div>
                </div>
                <button id="audioControlButton" class="control-button"type="button"><i class="fas fa-music"></i></button>
                <!-- Add the queue icon button here -->
                <button class="queue-button" id="queueButton"type="button"><i class="fas fa-list"></i></button>
            </div>


            <audio id="audio" preload="metadata">
                Your browser does not support the audio element.
            </audio>
        </div>


        <div id="contextMenu">
            <ul>
                <li id="addToQueue">Add to Queue</li>
                <li id="addToPlaylist">Add to Playlist</li>
                <li id="addToLike">Add to Favorite</li>
            </ul>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/interactjs/dist/interact.min.js"></script>
        <script src="dist/js/script.min.js"></script>
        <script src="login.js"></script>
        <script src="songs.js"></script>
        <!-- Updated JavaScript reference -->
        <script>

            $(document).ready(function () {
                var isLoggedIn = false;
                // Check if user is logged in
                if ('<%=isLoggedIn.Value%>' !== 'False') {
                    isLoggedIn = true;
                }
                if (isLoggedIn) {
                    $("#signin-nav").hide(); // Hide sign in link
                    $("#profile-nav").show(); // Show profile link
                } else {
                    $("#signin-nav").show(); // Show sign in link
                    $("#profile-nav").hide(); // Hide profile link
                }
            });

            document.getElementById("loginButton").addEventListener("click", function () {
                window.location.href = "signin.html";
            });

        </script>
        <script>
            // Get the queue container element
            var queueContainer = document.getElementById("queueContainer");

            // Get the lyrics container element
            var lyricsContainer = document.getElementById("Lyrics");

            // Get the queue button element
            var queueButton = document.getElementById("queueButton");

            // Get the audio control button element
            var audioControlButton = document.getElementById("audioControlButton");

            // Get the qcon element
            var qcon = document.querySelector(".qcon");

            // Add click event listener to the queue button
            queueButton.addEventListener("click", function () {
                // Toggle the 'active' class on the queue container
                queueContainer.classList.toggle("active");

                // Hide the lyrics container
                lyricsContainer.style.display = "none";

                // Show the qcon
                qcon.style.display = "block";
            });

            // Add click event listener to the audio control button
            audioControlButton.addEventListener("click", function () {
                // Toggle the 'active' class on the queue container
                queueContainer.classList.toggle("active");

                // Hide the qcon
                qcon.style.display = "none";

                // Display the lyrics container
                lyricsContainer.style.display = "block";
            });


            // Function to close the queue container when clicking outside of it
            //document.addEventListener("click", function(event) {
            // Check if the clicked element is not the queue button or inside the queue container
            //  if (!event.target.closest("#queueButton") && !event.target.closest("#queueContainer")) {
            // Remove the 'active' class from the queue container
            //    queueContainer.classList.remove("active");
            //  }
            //});
        </script>
    </form>


</body>
</html>
