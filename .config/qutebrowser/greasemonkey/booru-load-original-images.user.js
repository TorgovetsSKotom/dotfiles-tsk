// ==UserScript==
// @name         booru-load-original-images
// @namespace    https://gist.github.com/xeleoss/07d9f38a6762e468d7abbf863e5f549e
// @version      0.2
// @description  script for (safe|gel|dan)booru.org to load the original size image instead of preview
// @author       github.com/xeleoss
// @match        *://safebooru.org/index.php*
// @match        *://gelbooru.com/index.php*
// @match        *://danbooru.donmai.us/posts*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=safebooru.org
// @run-at document-end
// ==/UserScript==

(async function () {
    'use strict';

    const siteStyles = {
        'https://gelbooru.com': `
            .thumbnail-preview {
                width: 100%;
                height: 100%;
            }
            
            article.thumbnail-preview img {
                width: 100%;
                height: 100%;
                max-width: unset;
                max-height: unset;
            }
        `,

        'https://safebooru.org': `
            span.thumb {
                height: 100%;
                width: 100%;
            }
        `,
        
        'https://danbooru.donmai.us': `
            .post-preview-180 .post-preview-image {
                max-height: unset;
                width: 100%;
                height: 100%;
            }

            .post-gallery-grid.post-gallery-180 .post-preview-container {
                height: 100%;
                width: 100%;
            }

            .post-gallery-grid.post-gallery-180 .posts-container {
                grid-template-columns: unset;
            }
        `,
    };

    const site = window.location.origin;
    const style = document.createElement('style');
    style.textContent = siteStyles[site];
    document.body.appendChild(style);

    function sleep(timeout) {
        return new Promise((resolve) => setTimeout(resolve, timeout));
    }

    const aArray = Array.from(document.querySelectorAll('a'));
    for (const a of aArray) {
        let loaded = false;
        const imgs = a.querySelectorAll('img');
        if (imgs.length !== 1 || !a.href || (!a.href.startsWith(site + '/index.php') && !a.href.startsWith(site + '/posts/'))) {
            continue;
        }

        const img = imgs[0];
        const iframe = document.createElement('iframe');
        iframe.style.setProperty('opacity', 0);
        iframe.setAttribute('src', a.href);
        document.body.appendChild(iframe);
        iframe.addEventListener('load', () => {
            const image = iframe.contentDocument.getElementById('image');
            const setLoaded = () => loaded = true;
            if (image) {
                img.addEventListener('load', setLoaded);
                img.addEventListener('error', setLoaded);
                img.setAttribute('src', image.src);
                a.querySelectorAll('source').forEach(el => el.remove());
            } else {
                setLoaded();
            }

            document.body.removeChild(iframe);
        });

        while (loaded !== true) {
            await sleep(10);
        }
    }
})();