// ==UserScript==
// @name         Rule34 Artist favorites
// @description  A simple script to add the possibility to favorite artists to rule34
// @namespace    User_314159_AFav
// @version      1.0
// @author       User_314159
// @license      MIT
// @match        https://rule34.xxx/index.php?page=account&s=home
// @match        https://rule34.xxx/index.php?page=post*
// @grant        none
// ==/UserScript==

/* Functions used to interact with the local storage */
function getArtists() { // gets the localstorage array and parses it into an actual array, creates a new one if there is no key in localStorage
  let artists;
  if (localStorage.getItem('rule34FavArtists') === null) {
    console.log('generated new artists array');
    artists = [];
  }
  else {
    artists = JSON.parse(localStorage.getItem('rule34FavArtists'));
  }
  return artists;
}

function deleteArtist(artist) { // deletes the specified artist out of the array and saves it
  let artists = getArtists();
  let target = artists.indexOf(artist);
  artists.splice(target, 1);
  saveArtists(artists);
  console.log('Deleted ' + artist);
}

function saveArtists(artists) { // saves an updated version of the artists to local storage
  localStorage.setItem('rule34FavArtists', JSON.stringify(artists));
}

function exportArtists() { // gets the local storage and logs it to the console as a string
  let artists = localStorage.getItem('rule34FavArtists');
  console.log(JSON.stringify(artists));
}

function importArtists() { // takes an inputted array string and overwrites the local storage with it
  let data = window.prompt("Enter the string here: ");
  localStorage.setItem('rule34FavArtists', JSON.parse(data));
}

/* These are the functions for the Favorites displaying */
function generateArtistEntry(artists, name) { // generates a container with a delete button calling the deleteArtist function and a link to the artist page
  let link = document.createElement('a');
  let deleteButton = document.createElement('button');
  let container = document.createElement('div');

  deleteButton.innerHTML = 'delete';
  deleteButton.setAttribute('id', 'artistFavDel');
  link.innerHTML = name;

  link.setAttribute('href', 'https://rule34.xxx/index.php?page=post&s=list&tags=' + name);
  deleteButton.setAttribute('name', name);

  deleteButton.addEventListener("click", function () {
    deleteArtist(name)
  }, false);

  container.appendChild(deleteButton);
  container.appendChild(link);

  return container;
}

/* Functions for the adding of artists to the favorites */
function generateAddButton(name) { // generates a button that is added to the bottom of the post to add an artist
  var button = document.createElement('button');
  button.innerHTML = ('Add ' + name + ' to favorites');
  button.addEventListener("click", function () {
    addArtist(name)
  }, false);
  return button;
}

function generateArtistAddable() { // adds the artists as single buttons to the bottom of the page, the buttons are generated in the generateAddButton function
  let possibles = document.getElementsByClassName('tag-type-artist tag');
  let artists = document.getElementsByClassName('link-list')[0];
  for (let i = 0; i < possibles.length; i++) {
    let artist = possibles[i].children[1].firstChild.data.split(' ').join('_'); // this hell of a selector is the name of the artist with the spaces replaced with underscores
    console.log(artist);
    artists.appendChild(generateAddButton(artist));
  }

}

function addArtist(artist) { // adds the name of the artist to the array and saves the array, cancels if the artist already is in the most recent save
  let artists = getArtists();
  if (artists.includes(artist)) {
    console.log(artist + ' already in favorites.');
    return;
  }
  artists.push(artist);
  saveArtists(artists);
  console.log('Added ' + artist + ' to favorites');

}

/* Main Function */
(function () {
  'use strict';
  let artists = getArtists(); // gets the artists and parses them from a string to an iterable

  let url = window.location.href;
  if (url.includes('page=post&s=view')) {
    generateArtistAddable();
  }; // this part checks if you are on a post and if so, the 'add to favorites' gets added

  let favoritesHeader = document.createElement('h4'); //header 4 element
  let favoritesCollapse = document.createElement('details'); // collapsible list of favorites
  let favoritesTitle = document.createElement('summary'); // title element of the collapsible
  let exp = document.createElement('button');
  let imp = document.createElement('button');
  // the two buttons are for import and export
  exp.addEventListener("click", function () {
    exportArtists()
  }, false);
  imp.addEventListener("click", function () {
    importArtists()
  }, false);
  imp.innerHTML = 'Import';
  exp.innerHTML = 'Export';
  // the buttons values get declared and the onclick functions get set to the export / import functions

  favoritesTitle.innerHTML = 'Favorite Artists'; //setting the title

  for (let i = 0; i < artists.length; i++) {
    favoritesCollapse.appendChild(generateArtistEntry(artists, artists[i]));
  } // this adds one link for each favorite artist to the collapsible

  let desc = document.createElement('p'); //description, paragraph element
  desc.innerHTML = 'View all of your favorite artists and remove them if you wish.';

  favoritesCollapse.appendChild(favoritesTitle); // the title of the collapsible gets added

  favoritesHeader.appendChild(favoritesCollapse); // the collapsible gets added to the main container

  let mainPosts = document.getElementById("user-index").lastElementChild; // the last child of the user-index div is gotten, which is the "To main post page"
  let space = document.getElementById('user-index'); // the space variable is the container element for the whole thing

  space.insertBefore(favoritesHeader, mainPosts); // main container for the artist entries
  space.insertBefore(desc, mainPosts); // the description
  space.insertBefore(exp, mainPosts); // export button
  space.insertBefore(imp, mainPosts); // import button
  // this block just adds all the objects to the page before the "To main post page" link
})();
