// ==UserScript==
// @name         JoyReactor MP4 downloader for GIFs
// @namespace    nikisby
// @version      0.1
// @description  Добавляет кнопку скачивания mp4-гифок на JoyReactor
// @author       nikisby
// @license      MIT
// @match        *://joyreactor.cc/*
// @match        *://reactor.cc/*
// @match        *://joyreactor.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=joyreactor.cc
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    var wrappers = document.querySelectorAll('.video_gif_holder');
    wrappers.forEach(function (item) {
        var video = item.querySelector('video');
        if (video) {
            var mp4url = video.querySelector('[type="video/mp4"]').src;
            var link = document.createElement('a');
            link.appendChild(document.createTextNode('ссылка на mp4'));
            link.href = mp4url;
            link.setAttribute('download', '');
            link.classList.add('video_gif_source');
            link.style.left = 0;
            link.style.right = 'auto';
            item.prepend(link);
        }
    });
})();