// ==UserScript==
// @name         Joyreactor.cc - бесконечная главная (endless home page)
// @namespace    http://tampermonkey.net/
// @version      0.2
// @description  Заменяет навигацию по страницам бесконечной прокруткой (The script replaces page navigation by endless scrolling)
// @author       Aleks
// @icon        http://joyreactor.cc/favicon.ico
// @match        http*://*reactor.com/*
// @match        http*://*reactor.cc/*
// @grant        none
// @license      MIT
// ==/UserScript==

(function() {
    'use strict';

    var currentPage, posts, lastPost;
    var documentContainer = document.getElementById('content');
    var loading = false;

    function findLastPost(content) {
        if (typeof(content) == 'undefined') {
            currentPage = document.getElementById('contentinner');
        } else {
            currentPage = content;
        }
        posts = currentPage.querySelectorAll('.postContainer');
        lastPost = posts[posts.length - 1];
    }
    findLastPost();

    function isScrolledIntoView(el) {
        // Only completely visible elements return true:
        //var isVisible = (elemTop >= 0) && (elemBottom <= window.innerHeight);
        // Partially visible elements return true:
        var isVisible = lastPost.getBoundingClientRect().top < window.innerHeight && lastPost.getBoundingClientRect().bottom >= 0;
        return isVisible;
    }

    window.onscroll = function() {
        if (isScrolledIntoView(lastPost) && !loading) {
            loadContent();
        }
    }

    function loadContent() {
        var pagination = currentPage.querySelector('#Pagination');
        var nextPageUrl = pagination.querySelector('.next').href;

        var xhr = new XMLHttpRequest();
        xhr.responseType = "document";
        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4) {
                loading = false;
                if (xhr.status != 200) {
                    console.log( xhr.status + ': ' + xhr.statusText ); // пример вывода: 404: Not Found
                    return;
                }
                insertContent(xhr.response, pagination);
            }
        };
        xhr.open('GET', nextPageUrl, true);
        xhr.send();
        loading = true;
    };

    function insertContent(response, pagination) {
        var content = response.querySelector('#contentinner');
        documentContainer.appendChild(content);
        setTimeout(function() {
        content.querySelectorAll('.post_content_expand').forEach(function(elem) { //only after adding content on page, so it will have the height
            var post = elem.previousSibling;
            console.log('P:' + post.clientHeight);
            console.log(post);
            console.log('C:' + post.querySelector('div').clientHeight);
            if (post.clientHeight < post.querySelector('div').clientHeight) {
                post.classList.add('post_content_cut');
                elem.style.display = 'block';
            }
        });
        }, 1000);
        pagination.remove();
        findLastPost(content);
    };
})();
