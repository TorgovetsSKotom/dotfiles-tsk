// ==UserScript==
// @name         safe-and-gel-booru-switching-pages-arrows
// @namespace    https://gist.github.com/xeleoss/cca13f846081b883863606f2009f817e
// @version      0.1
// @description  script for (safe|gel)booru.org to switching pages with keyboard arrows
// @author       github.com/xeleoss
// @match        *://safebooru.org/index.php*
// @match        *://gelbooru.com/index.php*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=safebooru.org
// @run-at document-end
// ==/UserScript==

(async function () {
    'use strict';
    const geelbooru = 'https://gelbooru.com';
    const site = window.location.origin;
   
    document.addEventListener('keydown', e => {
        console.log(e);
        let alt = undefined;
        switch(e.code) {
            case "ArrowRight": {
                alt = "next";
                break;
            }
            case "ArrowLeft": {
                alt = "back";
                break;
            }
        }

        if (!alt) return;

        const btn = document.querySelector(`a[alt="${alt}"]`);
        if (btn) {
            btn.click();
        } else {
            if (site === geelbooru && alt === "back") {
                window.history.back();
            }
        }
    });
})();