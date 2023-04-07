// ==UserScript==
// @name          ThePirateBay Fixer
// @namespace     ThePirateBay Fixer
// @description   Remove all ads and misleading links. Clean looks. Add torcache.net & torrage.com links. Simple yet efficient code!
// @updateURL     https://openuserjs.org/install/Azev/ThePirateBay_Fixer.user.js
// @downloadURL   https://openuserjs.org/install/Azev/ThePirateBay_Fixer.user.js
// @grant		  GM_xmlhttpRequest
// @author        Azev
// @version       1.3.8
// @icon          http://i.imgur.com/nszPxuj.png
// @include      *thepiratebay.*

	/* popups */
	
// @include      *0427d7.se/*
// @include      *rtbpopd.com/*
// ==/UserScript==

/* stop popup infinite reload loop, high cpu usage */	
if ( (document.URL.indexOf('0427d7.se')!=-1) || (document.URL.indexOf('rtbpopd.com')!=-1) ){ window.stop(); return; }


var css = '';
var LOGO_IMG = '<a href="https://thepiratebay.se"> <img src="https://thepiratebay.se/static/img/tpblogo_sm_ny.gif" style="padding: 10px"></a><br>'; // http://i.imgur.com/hGBNIHG.png
var ajaxGif = 'http://opengraphicdesign.com/wp-content/uploads/2009/01/loaderb16.gif';
var elms;

function addCss(css){
	// http://stackoverflow.com/questions/11371550/change-hover-css-properties-with-javascript
	var style = document.createElement('style');
	if (style.styleSheet)
	    style.styleSheet.cssText=css;
	else 
	    style.appendChild(document.createTextNode(css));
	document.getElementsByTagName('head')[0].appendChild(style);
}

/* remove 'anonymous donwload' link */

	elms = document.getElementsByTagName('a');
	for (i=0 ; i<elms.length; i++) {
		if ( elms[i].getAttribute('title')!==null ) {
			if ( elms[i].getAttribute('title').indexOf('Anonymous Download')>=0 ) elms[i].style.display='none';
		}
		if ( elms[i].innerHTML=='torrent client' ) {
			elms[i].parentNode.style.display = 'none';
		}
	}


/* remove all iframes (ads) */ 

	elms = document.getElementsByTagName('iframe');
	for (i=0 ; i<elms.length; i++){
		elms[i].src = '';
		elms[i].style.display='none';
		elms[i].outerHTML = '';
	}


/* layout rebuid */
	
	css += ".ad {display: none}";
	css += ".promoimglink {display: none}";
	css += "#social {display: none}";
	css += "#widget {display: none}";
	
	var header = document.getElementById('header');
	var results = document.getElementById('searchResult');
	var mcont = document.getElementById('main-content');
	var torrentDetails = document.getElementById('detailsouterframe');
	
	if ( results!==null ) {
	
		/* results table css */
	
		results.id='newtbl';
		css += "#newtbl {width: 800px; margin: auto; martin-top: 50px; margin-bottom: 50px; border-spacing: 0; border-collapse: 1px; border: 1px solid #999;}";
		css += "#newtbl tr th { background-color: #ddd; text-align: center; padding: 10px ; border-bottom: 1px solid #999;}";
		css += "#newtbl tr td { background-color: #eee; text-align: left; border-bottom: 1px solid #d3d3d3; padding: 10px;}";
		css += "#newtbl tr:hover td { background-color: #E6E6E6; }";
		css += ".detName { margin-bottom: 5px;}";
		css += "a { outline: none; border: none}";
		elms = document.getElementsByTagName('td');
		for (i=0 ; i<elms.length; i++){
			//elms[i].style.background='#eee';
			if ( !isNaN(elms[i].innerHTML) ) elms[i].style.textAlign='Right';
		}
	
		/* rebuild body */
		document.body.innerHTML = header.outerHTML + results.outerHTML + mcont.nextSibling.nextSibling.innerHTML;
	
	
	} else {
		if ( torrentDetails!==null ) {

			/* remove popup links*/
			elms = document.getElementsByTagName('a');
			for (i=0 ; i<elms.length; i++){
				if ( elms[i].target=='_blank' ) elms[i].style.display = 'none';
			}
			
			/* add option to download from torcache & torrage*/
			var torrentHash = torrentDetails.innerHTML.match(/[0-9A-Fa-f]{40}/g)[0];
			var dLinks = document.getElementsByClassName('download')[0];

			dLinks.innerHTML += '<div id="torcache"><img class="ajaxloading" src="' + ajaxGif +'"><span> Checking torcache.net ...</span></div>';
			var torcache = 'http://torcache.net/torrent/' + torrentHash + '.torrent';
			/* check if torrent exist in torcache.net */		
			GM_xmlhttpRequest({
				method: "GET",
				url: torcache,
				onload: function(response) {
					if (response.status==200){
						torcache = '<a href="' + torcache + '">Download .torrent from TORCACHE</a>';
						document.getElementById('torcache').innerHTML = torcache;
					} else {
						document.getElementById('torcache').outerHTML = ''; // no link found @ torcache
					}
			  	}
			});
			
			dLinks.innerHTML += '<div id="torrage"><img class="ajaxloading" src="' + ajaxGif +'"><span> Checking torrage.com ...</span></div>'; 
			var torrage = 'http://torrage.com/torrent/' + torrentHash + '.torrent';
			/* check if torrent exist in torrage.com */		
			GM_xmlhttpRequest({
				method: "GET",
				url: torrage,
				onload: function(response) {
					if (response.status==200){
						torrage = '<a href="' + torrage + '">Download .torrent from TORRAGE</a>';
						document.getElementById('torrage').innerHTML = torrage;
					} else {
						document.getElementById('torrage').outerHTML = ''; // no link found @ torcache
					}
			  	}
			});
			
  
			css += "#torcache, #torrage {display: block; margin-top: 5px}";		
			css += ".ajaxloading {vertical-align: middle; height: 16px}";		
			css += ".nfo {border: 1px solid #777}";		
			css += "#details {background-color: #eee}";
			css += "#detailsouterframe {border: 1px solid #000;}";
			/* css won't apply */
			document.getElementById('title').style.background = '#ccc';
			elms = document.getElementsByTagName('dt');
			for (i=0 ; i<elms.length; i++) elms[i].style.color='#000';

				
			/* rebuild body */
			document.body.innerHTML = header.outerHTML + torrentDetails.outerHTML;
	
		}
	}

/* main page msg */

	var icons = document.getElementById('icons');
	if (icons!==null) {
		var msg = '<br><br><i>For faster browsing and ad-free, block these domains in your firewall/adblocker:<br><br>'
	  	msg += '<b>cdn1.adexprt.com, cdn2.adexprt.com, cdn3.adexprt.com, cdn3.adexprts.com<br>'
		msg += '0427d7.se, syndication.exoclick.com, main.exoclick.com, exoclick.com</b></i>'
		icons.innerHTML = msg;
	}
	


/* extra css */

	css += "#TPBlogo {display: none}"
	css += "iframe {display: none}"
	css += "img {padding: 3px}"

	var searchForm = document.getElementsByTagName('form')[0];
	if (searchForm!==undefined) searchForm.innerHTML = LOGO_IMG + searchForm.innerHTML ;
	css+= "#q{ text-align: center; padding: 20px; width: auto }"
	

	addCss(css);

	document.body.style.padding = '0';
	document.body.style.margin = '0';
	document.body.style.paddingTop = document.body.style.paddingBottom = '50px';


/* blank popup */

//	if ( typeof(_wm_settings)==='object' ) _wm_settings.popunder.url = '';



