// ==UserScript==
// @name        Eza's Image Glutton
// @namespace   https://inkbunny.net/ezalias
// @author			Ezalias
// @description Redirects to high-res images on gallery sites, skipping past descriptions and comments
// @license     MIT
// @license     Public domain / No rights reserved
// @include     /^https*://www\.furaffinity\.net/(view|full)/.*/
// @include     https://inkbunny.net/submissionview.php*
// @include     http://gelbooru.com/*page=post&s=view*
// @include     http://youhate.us/*page=post&s=view*
// @include     http://www.gelbooru.com/*s=view*
// @include     http://danbooru.donmai.us/posts/*
// @include     https://danbooru.donmai.us/posts/*
// @include     http://*.tumblr.com/image/*
// @include     /^http(s|)://e(621|926)\.net/post/show*//
// @include     http://*.deviantart.com/art/*
// @include     http://*.hentai-foundry.com/pictures/*
// @include     /^https*://www\.sofurry\.com/view/*//
// @include     https://www.weasyl.com/*
// @include     http://www.y-gallery.net/view/*
// @include     http://rule34.paheal.net/post/view/*
// @include     http://rule34.xxx/index.php?page=post*
// @include     http://rule34hentai.net/post/view/*
// @include     /^https*://derpiboo.ru/*//
// @include     /^https*://derpibooru.org/.*/
// @include     http://*.booru.org/*s=view*
// @include     http://mspabooru.com/*s=view*
// @include     http://safebooru.org/*s=view*
// @include     http://www.majhost.com/cgi-bin/gallery.cgi?i=*
// @include     http://g.e-hentai.org/s/*
// @include     http://nijie.info/view.php?id=*
// @include     http://www.pixiv.net/member_illust.php?mode=medium&illust_id=*
// @include     http://*sleepymaid.com/*
// @include     https://*.sankakucomplex.com/post/*
// @include     http://*.bronibooru.com/posts/*
// @include     http://luscious.net/c/*
// @include     https://luscious.net/c/*
// @include     http://imageboard.neko-sentai.com/post/*
// @include     https://uberbooru.com/posts/*
// @include     https://www.furiffic.com/*/view/*
// @exclude    http://www.deviantart.com/users/outgoing?*
// @exclude    *#dnr
// @version     1.25.3
// ==/UserScript==



// Any single-image submission will redirect to the full-size image. On multi-image submissions, every page except the first will redirect to its full-size image. 
// If you go "back" to the normal gallery page (to favorite the image, read its description, leave a comment, etc.) then this script will not send you forward again. 
// https://greasyfork.org/scripts/4713-eza-s-image-glutton 



// TO DO: 
// for modify_tumblr: for photoset pages (but everywhere, to be safe) make unlinked images link to themselves. I want nice, clean, chronological tabs for multi-image comics. 
// ugh. test without adblock enabled. 
// modify_furaffinity to change prev/next/fav links with pre-appended #dnr. not raw html fiddling: use the DOM and getElementsByType or whatever. thingy.href=url_plus_dnr. 
// flickr? maybe separately. that whole site is a mess. also full-size images are sometimes gigantic, like dozens of megabytes. 
// inkbunny: move page links above first-page preview on multi-image submissions? - by altering divs or css, if possible. minimal molestation implies better future-proofing. 
	// weasyl: replace bespoke thumbnails with smallest preview images? eh, do these as separate scripts, once userscripts stops fucking around.
// Consider changing some @includes to @match. 
// http://thehentaiworld.com/hentai-doujinshi/theres-something-about-sakura-naruto/ ? I already do rule34; there's no pretending this is just about "art." 
	// Almost deserves a more Pixiv Fixiv-like fix. Maybe just a link dump like that DeviantArt gallery script?
// Swagster.com? Eh. The name alone rubs me the wrong way. Ugh, and they watermark. 
// Greasyfork install page as options page? 
// This would work faster if I could delay or prevent the loading of images. E.g., execute script before loading page, define CSS that doesn't download embedded images, wait for page to load, scrape image_url, and then redirect as usual. Since the script wouldn't trigger on #dnr (which I should do as an @exclude, I guess) images would load as usual when you clicked 'back.' 
	// This thought is mostly driven by opening a bunch of e.g. Gelbooru links all at once. They spend long enough loading that the full-size images are usually half-done before the redirect happens. 
// Getting a generic Pixiv error on http://www.pixiv.net/member_illust.php?mode=medium&illust_id=46742182 
	// Redirects to http://www.pixiv.net/member_illust.php?mode=manga&illust_id=46693388 
// Escape function in JS is encodeURI. Also use in Tumblr Scraper, where we need 'safe' URLs as tag IDs. 
// FurAffinity stories redirect to thumbnail, e.g. http://www.furaffinity.net/view/15903888/ - might need to break out a whole complex function here. 
// http://seiga.nicovideo.jp/seiga/im4507046 ? 
// Nijie.info support might be missing out on multipage submissions? I don't even have an account. 
	// My Nijie support is basically nonexistant because I didn't have an account. Turns out they're more like Pixiv now, including multi-image posts. This is problematic. (Animations work, though.) 
// This script just went missing from OpenUserJS. WTF? I'm pretty sure I didn't hit the gigantic DELETE SCRIPT button on the "Edit" page. And it won't let me upload a new version from scratch? Fuck you, OUJS. Where's the slightest hint of an "undelete" button, or any log of why my fucking script is missing? 
	// Nope, OUJS mod Marti is just kind of an asshole. I made a thread asking about the missing script, and he told me it'd been "permanently removed" for violating the TOS. Apparently "public domain" isn't open-source enough. Great. So despite all the language stating that MIT will be assumed in the absence of contrary information, I have to specify it in @license... "and one @exclude *"? What does that even mean? 
	// OUJS mod Marti is a _real_ asshole. I can't re-upload this script with the same name, because his slapdash website has salted the earth over the /Ezalias/Ezas_Image_Glutton URL. Again, this is for a licensing issue, where the script was labeled "public domain / no rights reserved" instead of MIT, even though having no license specified would be quietly treated as MIT-licensed. So because my open-source @license was too open, the script is permanently barred, without prior notice or warning of any meaningful sort. He is the kind of unprofessional douchebag who is liable to delete my entire account there if he ever deigns to read this comment. Or for no reason whatsoever! Who knows! Apparently standard operating procedure there is shoot first, ask questions never, and swing your dick in the comments if anyone asks why their content is missing and broken. 
	// Can't upload Eza's Image Gluten and then rename it because the URL changes to match the title. Interesting feature, but terrible even for users who haven't been trolled by the admins, since the failure is silent and ditches whatever code you entered in the online editor. You're dropped back into the editor with the last stored version of the code. That hacky bullshit would be fine if the guy responsible wasn't an egotistical hypocrite demanding "professional conduct" in the threads where he casually mentions he almost deleted your whole account and acts offended when you don't thank him for His undue mercy. No, wait, it's even dumber than that - it creates a new page for the differently-named script. What a shithole. 
// Make undersized images link to themselves on imgur. 
// Eza's image glutton as described on http://cuddle.horse/post/109728993805/a-few-browser-extensions-that-make-furaffinity-a -
	// Eza’s Image Glutton: This affects websites beyond just FA but is a unique tool for powerbrowsing and such. When you open a page with a single image it skips all comments and descriptions and just shows the image in the highest quality possible. If you want to see all the items that are hidden all you have to do is go back a page.
	// good rundown from a third party. 'A page with a single image' is clearer than 'gallery submission page.' 

// Changed if-else-if rat's nest to switch/case rat's nest. 
// Changed non-image file-extension blacklist to use an actual list. 

// Since I'm just leafing through HTML (usually), can I jump to the image /before/ trying to load the page? GreaseMonkey has a wonky option for running the script before the page runs, but I don't think we get all the HTML first. Maybe... maybe AJAX the page we're on? Like, @RunAtStart or whatever, then create a little blank page, then grab the URL via XmlHTTPgetObject or whatever, then read the HTML as responseText. The trouble (I expect) would be going back to the normal page when someone hits 'back.' This script shouldn't run... but any browser will probably have cached the fake page. 

// Do-before-load, grab page via ajax, and process as text to redirect before DOM even knows what's going on?
	// intent is to fully prevent rendering of images / execution of other JS, to hastily redirect to whatever image URL is required. 
	// Surprisingly, it works! Any site relying on extract-image-url-after is easy to please. 
	// Cons: still not blazing-fast. Probably doubles GET requests to server, though overall bandwidth might be lower. Forces reliance on extract-etc function. 503-fixer seems busted. 
		// Getting "too much recursion" errors in ctrl+shift+j (error console). 503s still boned. 
	// Reverted. It was an interesting idea, but it was added complexity that broke some useful features. (And then broke entirely. Recursion? WTF?) 
	// Can I run-at document-start and then fire a function at document-end? That might allow me to </html> ASAP, killing the page's execution... but then we'd need to reload if we don't redirect. Hm. 
	// Is there JS to prevent the execution of JS? 

// Owyn Tyler has a ridiculously replete script with similar goals called Handy Just Image - http://userscripts.org/scripts/show/166494
// The supported-site list is waaay longer than mine, and/but his goals are more complex. Image Glutton exists only to deliver the image. 
// He's having trouble with back-trapping, though. His solution sounds absurdly complex even compared to mine. Test the script and recommend help if possible. 






// global variables, for simplicity
var image_url = '';		// location of the full-size image to redirect to
var wait_for_dnr = false;		// some site URLs use "#" liberally, so if this var isn't empty, only "#dnr" will stop a redirect
var page_failed = false; 		// If the page 503s or otherwise forces us to reload, wait a moment, then reload. 

// detect site, extract image URL, then decide whether or not to redirect
switch( document.domain.replace( 'www.', '' ) ) { 		// Remove "www" to avoid cases where both example.com and www.example.com are supported. 
		////////// 		Simple extract_image_url_after sites
	case 'e621.net': extract_image_url_after( '>Respond</a>', 'https://' ); break; 
	case 'e926.net':  extract_image_url_after( '>Respond</a>', '//' ); break;
	case 'weasyl.com':  extract_image_url_after( '<div id="detail-art">', '/' ); break; 		// also redirects to plaintext/HTML on stories, haha 
	case 'hentai-foundry.com':  extract_image_url_after( '<center><img', '//' ); reload_if( '<h1>An error occurred.' ); break;
	case 'y-gallery.net':  extract_image_url_after( 'a_center container2">', 'http://' ); break;
	case 'rule34.xxx':  extract_image_url_after( '>Edit</a></li>', 'http://' ); break;
	case 'derpiboo.ru':  extract_image_url_after( '>Download</a>', '//' ); break;
	case 'derpibooru.org':  extract_image_url_after( '>Download</a>', '//' ); break;
	case 'chan.sankakucomplex.com':  extract_image_url_after( '<li>Original:', '//' ); break;
	case 'idol.sankakucomplex.com':  extract_image_url_after( '<li>Original:', '//' ); break;
	case 'furiffic.com': extract_image_url_after( 'onload="$', '//' ); break; 		// Not using og:image because different URL causes image to re-load is user hits Back 
		////////// 		Slightly complicated extract_image_url_after sites
	case 'rule34hentai.net':  extract_image_url_after( 'shm-zoomer', '/_images/' ); wait_for_dnr = true; break;
	case 'rule34.paheal.net':  extract_image_url_after( 'shm-zoomer', 'http://' ); wait_for_dnr = true; break;
	case 'majhost.com':  image_url = document.getElementsByTagName( "img" )[0].src; break; 		// first and only <img> tag 
	case 'luscious.net':  image_url = document.getElementById( 'original' ).href; break;
		////////// 		Simple custom sites
	case 'sofurry.com': 
		image_url = window.location.href.replace('sofurry.com/view/','sofurryfiles.com/std/content?page='); 
		if( document.body.outerHTML.indexOf( '<div id="sfContentImage' ) < 0 ) { image_url = ''; } 		// Do not redirect from stories
		if( document.body.outerHTML.indexOf( '<div class="sf-story"' ) > 0 ) { image_url = ''; }  		// Really do not redirect from stories break;
		break;
	case 'danbooru.donmai.us':  
		extract_image_url_after( '% of original (', '/data/' );		// resized images will say "X% of original (view full" or something like that
		if( image_url == '' ) {extract_image_url_after( 'twitter:image:src', 'http://' );		// otherwise just grab the preview-sized image (this also works on pages claiming you need Gold to see them)
		image_url = image_url.replace( '/sample/sample-', '/' ); }	 	// if the preview-sized image is a sample, fix that - this sometimes fails for PNG images with JPG previews break;
		break;
	case 'furaffinity.net':  		// This is a mess because I'm trying not to redirect from stories / music... but FA kindly links the thumbnail images for those. 
		reload_if( 'center;">Error 503' ); 
		//extract_image_url_after( 'File type</strong>:', 'd.facdn' );
		extract_image_url_after( 'Favorites</a></b>', '//' );  
		//if( document.getElementsByTagName('html')[0].innerHTML.indexOf( 'Category:</b> Story' ) > 0 ) { image_url = ''; } 		// Don't redirect from stories.
		//if( document.getElementsByTagName('html')[0].innerHTML.indexOf( 'File type</strong>' ) > 0 ) { image_url = ''; } 		// Don't redirect from non-images
		// Arg, still redirecting from music. There's a table with the text in it... but it has no unique ID. Has different width on images? Blarg, also width=1% on music (to fit to content). 
		// Can't just check 'category: art' because there's a wide variety. 
		// Maybe just check for embedded mp3 or flash. 
		// Are music/story image filenames always .txt.gif or similar? Nope. 
		// I might be an idiot: just use the Download link. 
			// No, even that's a little screwy: you can submit a big image and categorize it as a Story, so you get an illustration and write the story itself in the description. 
		// "File type" message may only appear on non-images! I stumbled my way into a solution. Oh, but that misses stories-in-descriptions. Double-check Category, I guess. (Nope: fails on music.) break;
		break;
	case 'g.e-hentai.org':  
		var image_index = document.body.outerHTML.indexOf( '</iframe>' );		// jump to end of navigation iframe
		image_index = document.body.outerHTML.indexOf( 'http://', image_index+1 );		// find next URL (link to next page)
		image_index = document.body.outerHTML.indexOf( 'http://', image_index+1 );		// find URL after that (image source)
		image_url = document.body.outerHTML.substring( image_index, document.body.outerHTML.indexOf( '"', image_index ) ); 		// grab image src, delimited by doublequote break;
		break;
	case 'nijie.info': 
		extract_image_url_after( 'name="twitter:image"', 'http://' );		// some images are behind some sort of barrier, so let's grab the twitter-size image instead...
		image_url = image_url.replace( '/sp/', '/' ); 		// ... and drop the /sp/ to get the full-size URL. break;
		break;
	case 'sleepymaid.com':  
	case 'yay.sleepymaid.com':  
		image_url = document.getElementById( 'the-image' ).src; 
		if( document.getElementById( 'next' ) ) { image_url = ''; }  		// Don't redirect on comic pages break;
		break;
	case 'imageboard.neko-sentai.com':  image_url = document.getElementById( 'main_image' ).src; break;
	case  'uberbooru.com': extract_image_url_after( 'id="image-container', 'https://' ); break;
		////////// 		Sites complex enough to shove into a function down below 
	case  'inkbunny.net': scrape_inkbunny(); break;
	case  'pixiv.net': scrape_pixiv(); break;
	case  'gelbooru.com': scrape_booru(); break;
	case  'youhate.us': scrape_booru(); break;
	case  'mspabooru.com': scrape_booru(); break;
	case  'safebooru.org': scrape_booru(); break;
	case  'bronibooru.com': scrape_booru(); break; 
}
////////// 		Holdovers from the previous method; domains that don't neatly conform to document.domain switch selection. 
if( address_bar_contains( 'tumblr.com' ) ) { extract_image_url_after( 'id="content-image"', 'http://' ); } 
if( address_bar_contains( 'deviantart.com' ) ) { scrape_deviantart(); wait_for_dnr = true; } 
if( address_bar_contains( '.booru.org' ) ) { scrape_booru(); } 



// If the page didn't load properly, but could be fixed by reloading, then wait a moment and reload 
if( page_failed ) { 		// If we get a 503 or other 'please reload' error
	image_url = ''; 		// do not redirect this time
	setTimeout( function inline_reload() { location.reload(); }, Math.floor((Math.random() * 10) + 1) * 1000 ); 		// 1s-10s pause. Can't believe you have to name inline functions. 
}



// Don't redirect if the filetype is obviously not an image. SWF, TXT, MP3, etc. 
// Arguably include Webm? Opening many Gelbooru webms in tabs is a cacaphony. 
// It's tedious to detect flash, story, and music pages on every website supported, so instead let's just cancel redirection based on those file extensions.
// Possibly implement as an array with a For loop instead of a list of OR operations. This could get silly, with text, music, and video formats galore. 
// txt, doc, pdf, swf, mp3, mp4, webm, midi, mid, wav, 
var ext = image_url.substring( image_url.lastIndexOf( '.' ) + 1, image_url.length ); 		// e.g. "png"
//if( ext == 'mp3' || ext == 'swf' || ext == 'txt' || ext == 'webm' || ext == 'docx' ) { image_url = ''; } 		// If the filetype is obviously not an image, don't redirect. (does webm count?) 
var not_images = [ 'mp3', 'swf', 'txt', 'webm', 'mp4', 'docx', 'pdf', 'doc', 'rtf', 'midi', 'mid', 'wav', 'flv', 'cab' ]; 
for( var n in not_images ) { if( ext == not_images[n] ) { image_url = ''; } } 		// If the extension is in our blacklist, don't redirect. 
// Oh right. Doesn't work on FA because FA points to the icon. Yaaayfuck. 



// having defined image_url by scraping the page's HTML, modify the current URL to prevent back-traps, then redirect to that full image 
if( image_url !== '' && (!address_bar_contains('#') || wait_for_dnr) ) 		// do nothing if image_url is empty. ignore pages with a "#", unless wait_for_dnr makes you wait for a full "#dnr". 
{
		// some images don't redirect properly, even if you manually "view image" - so we append ".jpg" to URLs without file extensions, forcing the browser to consider them images
		// even if this doesn't work, the new URL should just 404, which is better than the semi-modal "octet stream" dialog seen otherwise. 
	if( image_url.lastIndexOf( '/' ) > image_url.lastIndexOf( '.' ) ) { image_url = image_url + '.jpg'; }		// if there's not a "." after the last "/" then slap a file extension on there 
	if( image_url[ image_url.length - 1 ] == '.' ) { image_url = image_url + 'jpg'; }		// if the URL ends with a dot, slap a file extension on there 

		// modify current location, so that when the user clicks "back," they aren't immediately sent forward again
	modified_url = window.location.href + '#dnr'; 		// add do-not-redirect tag to current URL
	history.replaceState( {foo:'bar'}, 'Do-not-redirect version', modified_url );		// modify URL without redirecting. the {foo:'bar'} thing is a state object that I don't care about, but the function needs one.

//	window.location.href = image_url;		// redirect to full image
	location.assign("javascript:window.location.href=\""+image_url+"\";");		// pixiv-friendly redirect to full image: maintains referral, happens within document's scope instead of within greasemonkey's 
}		// end of main execution





// ----- //			Functions for readability





function extract_image_url_after( string_before_url, url_begins_with ) {		// extract the first quote-delimited string that appears after unique first var and begins with second var
	var html_elements = document.getElementsByTagName('html'); 		// this way we avoiding doing getElementsEtc every time, and we still access the whole page's HTML by reference
	var string_index = html_elements[0].innerHTML.indexOf( string_before_url ); 		// find a unique string somewhere before the image URL
	if( string_index > -1 ) {
		var image_index = html_elements[0].innerHTML.indexOf( url_begins_with, string_index );  		// find where the image URL starts after the unique string
		var delimiter_index = html_elements[0].innerHTML.indexOf( '"', image_index ); 		// find first doublequote after the image URL starts
		image_url = html_elements[0].innerHTML.substring( image_index, delimiter_index ); 		// grab the image URL up to the next doublequote 
	}
}

function address_bar_contains( string_to_look_for ) {	// I'm so tired of typing out window.location.etc == -1. It's stupidly verbose and it looks terrible.
	return (window.location.href.indexOf( string_to_look_for ) !== -1);		// this makes code more concise and readable. if( address_bar_contains( 'tld.com' ) ) { do tld.com stuff; }
}

function reload_if( error_string ) { 
	var html_elements = document.getElementsByTagName('html'); 		// this way we avoiding doing getElementsEtc every time, and we still access the whole page's HTML by reference
	var string_index = html_elements[0].innerHTML.indexOf( error_string ); 		// look for a string indicating the page failed to load 
	if( string_index > -1 ) { page_failed = true; } 
}





// ----- //			Functions for individual websites (separated for being especially long)





// DeviantArt sometimes doesn't redirect until you F5. I suspect it's their fancy-pants not-actually-redirecting nonsense. Websites - stop acting stupid and just /be documents./ You are not an app. 
function scrape_deviantart() {		// this doesn't use ditch_html_before because data-super-full-img's appear for random links - we need to avoid grabbing one from the ass-end of small-image pages
	/*
	var image_index = document.body.outerHTML.indexOf( 'class="dev-view-deviation"' ); 		// jump to unique and hopefully universal dev-view-deviation div
	if( image_index > 0 ) { 		// Don't redirect on pages without a deviation (e.g. "oops not found" faux-404s). 
		var image_index = document.body.outerHTML.indexOf( 'src=', image_index+1 ); 		// jump to first src (preview size)
		var image_index = document.body.outerHTML.indexOf( 'http://', image_index+1 ); 		// jump to the URL defined in src
		image_url = document.body.outerHTML.substring( image_index, document.body.outerHTML.indexOf( '"', image_index ) ); 		// grab URL, delimited by doublequote
		if( image_url.indexOf( "/PRE/" ) > 0 ) { image_url = image_url.replace( "/PRE/", "/" ); } 		// fix preview-size image to be full-size
	} 
	if( document.body.outerHTML.indexOf( '<div id="flashed-in"' ) > 0 ) { image_url = ''; } 		// Do not redirect on flash pages 
	*/

	image_url = document.getElementsByClassName( "dev-content-full" )[0].src; 		// Woo, document-object model.
	// This still isn't always full-size, because DeviantArt is awful. 
	// E.g. http://whiskypaint.deviantart.com/art/Commission-Pinup-style-526359546 fails - the Download size is bigger than any display size, and there's no way to see just the image.
}

// InkBunny now uses regional CDNs like us.ib.metapix.net and... inkbunny.net? Oh that's just screwy. Admin GreenReaper helpfully recommends /files/screen as the common element. 
// I'd love to use the document-object model, but none of the images or links seem to have IDs. Blar. 
function scrape_inkbunny() {
//	var image_index = document.body.outerHTML.indexOf( 'https://us.ib.metapix.net/files/screen/' );		// look for screen-size image URL 
	var image_index = document.body.outerHTML.indexOf( '/files/screen/' ); 		// Find the middle of a screen-sized image URL 
	image_index = document.body.outerHTML.lastIndexOf( 'https://', image_index ); 		// ... then back up to the start of it
	if( image_index !== -1 )		// if that URL is found
	{
		var delimiter_index = document.body.outerHTML.indexOf( '"', image_index );		// find first doublequote delimiter after URL
		image_url = document.body.outerHTML.substring( image_index, delimiter_index );		// grab delimited URL 
		image_url = image_url.replace( '/screen/', '/full/' );		// turn screen URL into full URL - we don't care if /screen/ is already full-size, because /full/ will kindly redirect anyway
	}

	// if this page is the landing page for a multi-image submission, do not redirect 
	if ( document.body.outerHTML.indexOf( '<form id="changethumboriginal_form"' ) !== -1 && !address_bar_contains( '&page=' ) ) {		// look for language-agnostic 'show custom thumbnails' button
		image_url = '';		// note: we do redirect on URLs for individual pages, including the first. 
	}
}

function scrape_pixiv() { 
	extract_image_url_after( 'class="_illust_modal', 'http://' ); 		// Oh, what now? Code below doesn't work for some pages, so do this instead. (This goes first because only the last successful 'extraction' matters.) 
	extract_image_url_after( 'class="big"', 'http://' ); 		// New Pixiv pages (Dec '14) provide the big URL rather directly. 

	if( image_url == '') { 		// try this old nonsense first, because god forbid these sites update all their code to be remotely fucking consistent
		extract_image_url_after( 'bookmark_modal_thumbnail', 'http://' ); 		// grab bookmark-thumbnail image from "medium" landing page  
			// convert URL to full-size. 
		image_url = image_url.replace( '_m.', '.' ); 		// old style: remove _m for full-size URL
//		image_url = image_url.replace( '/c/600x600', '' ); 		// new style: remove /c/600x600, swap image-master for image-original, remove _master1200. 
		image_url = image_url.replace( '/c/150x150', '' ); 		// new style: remove /c/150x150, swap image-master for image-original, remove _master1200. 
		image_url = image_url.replace( '/img-master/', '/img-original/' ); 
		image_url = image_url.replace( '_master1200', '' ); 
	}

	// Through sheer accident, the old manga code still works after Pixiv's latest change. 
	if( document.getElementsByTagName('html')[0].innerHTML.indexOf( '<a href="member_illust.php?mode=manga' ) > 0 ) { 		// If the works_display preview links to the manga, go there instead
		image_url = window.location.href.replace( 'mode=medium', 'mode=manga' );		// manga pages deserve their own HTML, so just go to that page 
		// Users: please consider Eza's Pixiv Fixiv, which replaces the default manga HTML with full images and none of that scroll-to-load nonsense. 
	} 

	// Don't redirect to "Ugoira" animations (ZIP full of JPGs, played as HTML slideshow) 
	if( document.getElementsByTagName('html')[0].innerHTML.indexOf( 'class="_ugoku' ) > 0 ) { 		// A little messy since we ditched html_copy, isn't it? 
		image_url = ''; 		// prevent redirect by blanking image_url
		// add link to ZIP for Ugoira, purely for archival purposes 
		var ugoku_link = pixiv.context.ugokuIllustData.src;
		document.getElementsByClassName( '_ugoku-illust-player-container' )[0].innerHTML += '<br><a href="' + ugoku_link + '">Download Ugoku frames as ZIP file</a>';  
	} 
}

function scrape_booru() {		// this works on a wide variety of booru-style imageboards. 
//	extract_image_url_after( '>Resize image</a>', 'http://' );		// for booru's which have automatic resizing and images which require it
	extract_image_url_after( "$('edit_form')", 'http://' ); 		// For booru's with automatic resizing on, use the Original Image link, which appears after the Edit button
	if( image_url == '' ) {		// otherwise, use the image that's being displayed 
		var container = document.getElementById( 'image' ); 		// Instead of lurching through raw HTML, let's just grab the display image via the DOM. 
		image_url = container.src; 		// "You think it's cool that things don't always have to be a federal fucking issue." 
	} 
}









/*
Test suite of random URLs from the relevant sites: 
http://www.hentai-foundry.com/pictures/user/Bottlesoldier/133840/Akibabuse
http://www.hentai-foundry.com/pictures/user/Bottlesoldier/214533/Lil-Gwendolyn
https://inkbunny.net/submissionview.php?id=483550
https://inkbunny.net/submissionview.php?id=374519
http://rule34.xxx/index.php?page=post&s=view&id=1399731
http://rule34.xxx/index.php?page=post&s=view&id=1415193
http://equi.booru.org/index.php?page=post&s=view&id=56940
http://furry.booru.org/index.php?page=post&s=view&id=340299
http://derpibooru.org/470074?scope=scpe80a78d33e96a29ea172a0d93e6e90b47c6a431ea
http://mspabooru.com/index.php?page=post&s=view&id=131809
http://mspabooru.com/index.php?page=post&s=view&id=131804
http://shiniez.deviantart.com/art/thanx-for-5-m-alan-in-some-heavy-makeup-XD-413414430
http://danbooru.donmai.us/posts/1250724?tags=dennou_coil
http://danbooru.donmai.us/posts/1162284?tags=dennou_coildata:text/html,<img src='http://example.com/image.jpg'>
http://www.furaffinity.net/view/12077223/
http://gamesbynick.tumblr.com/post/67039820534/the-secrets-out-guys-the-secret-is-out
http://honeyclop.tumblr.com/post/67122645946/stallion-foursome-commission-for-ciderbarrel-d
http://shubbabang.tumblr.com/post/20990300285/new-headcanon-karkat-is-ridiculously-good-at
http://www.furaffinity.net/view/12092394/
https://e621.net/post/show?md5=25385d2349ae11f2057874f0479422ad
http://sandralvv.tumblr.com/post/64933897836/how-did-varrick-get-that-film-cuz-i-want-a-copy
*/