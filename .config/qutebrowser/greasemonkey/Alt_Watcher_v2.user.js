// ==UserScript==
// @name         Alt Watcher v2
// @namespace    https://vk.com/shiki_ex
// @version      2.1.6
// @description  [shikimori.org] Добавляет ссылку на Альтернативные сайты просмотра аниме ###
// @author       STorn
// @match https://shikimori.org/*
// @match http://shikimori.org/*
// @match https://shikimori.one/*
// @match http://shikimori.one/*
// @require      https://code.jquery.com/jquery-3.3.1.slim.min.js
// @grant        none
// @license      MIT
// @copyright    2018, Newt300 (https://openuserjs.org/users/Newt300)
// ==/UserScript==

// url, name, allowed page types bitmap(0 - blocked, 1 - hentai)
var selections = [
    ["https://smotret-anime.ru/catalog/search?q=", "Anime 365", 1],
    ["https://hentai365.ru/catalog/search?q=", "Hentai 365", 2],
    ["https://vk.com/video?q=", "VK", 3],
    ["https://sovetromantica.com/anime?query=", "SR", 1],
    ["https://online.anidub.com/index.php?do=search&subaction=search&search_start=1&full_search=0&result_from=1&story=", "AniDub", 1],
    ["https://video.sibnet.ru/search.php?panel=open&sortby=0&duration=0&inname=1&text=", "Sibnet", 3],
    ["http://www.animespirit.ru/index.php?do=search&story=", "animespirit", 1],
    ["http://desu.me/search/555/?o=date&c[title_only]=1&c[node]=20+22+21&q=", "Desu.me", 1]
];

var $ = jQuery.noConflict(true);

var cookieTime = 1000 * 60 * 60 * 24 * 30; //месяц

function getPrefService(pageType) {
    var matches = document.cookie.match(new RegExp('(?:^|; )altWatcherPrefServiceFor' + pageType + '=([^;]*)'));
    if (matches){
        matches = decodeURIComponent(matches[1]);
        matches = selections.find(function(it){
            return it[1] == matches;
        });
        if (matches && matches[2] & pageType) return  matches;
    }

    for (var i = 0, v = selections[i]; i < selections.length; v = selections[++i])
        if ((v[2] & pageType) != 0)
            return v;

    return selections[0];
}

function setPrefService(pageType, value) {
    var d = new Date();
    d.setTime(d.getTime() + cookieTime);
    document.cookie = "altWatcherPrefServiceFor" + pageType + "=" + encodeURIComponent(value) + "; path=/; expires=" + d.toUTCString();
}

function getAltWatcherLanguage() {
    var matches = document.cookie.match(new RegExp('(?:^|; )altWatcherLanguage=([^;]*)'));
    if (matches){
        matches = decodeURIComponent(matches[1]);
        return matches;
    }
    return "en";
}

function setAltWatcherLanguage(value) {
    var d = new Date();
    d.setTime(d.getTime() + cookieTime);
    document.cookie = "altWatcherLanguage=" + encodeURIComponent(value) + "; path=/; expires=" + d.toUTCString();
}

const DMap = {0: 0, 1: 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, 8: 8, 9: 9, 10: 10, 11: 11, 12: 12, 13: 13, 14: 14, 15: 15, 16: 16, 17: 17, 18: 18, 19: 19, 20: 20, 21: 21, 22: 22, 23: 23, 24: 24, 25: 25, 26: 26, 27: 27, 28: 28, 29: 29, 30: 30, 31: 31, 32: 32, 33: 33, 34: 34, 35: 35, 36: 36, 37: 37, 38: 38, 39: 39, 40: 40, 41: 41, 42: 42, 43: 43, 44: 44, 45: 45, 46: 46, 47: 47, 48: 48, 49: 49, 50: 50, 51: 51, 52: 52, 53: 53, 54: 54, 55: 55, 56: 56, 57: 57, 58: 58, 59: 59, 60: 60, 61: 61, 62: 62, 63: 63, 64: 64, 65: 65, 66: 66, 67: 67, 68: 68, 69: 69, 70: 70, 71: 71, 72: 72, 73: 73, 74: 74, 75: 75, 76: 76, 77: 77, 78: 78, 79: 79, 80: 80, 81: 81, 82: 82, 83: 83, 84: 84, 85: 85, 86: 86, 87: 87, 88: 88, 89: 89, 90: 90, 91: 91, 92: 92, 93: 93, 94: 94, 95: 95, 96: 96, 97: 97, 98: 98, 99: 99, 100: 100, 101: 101, 102: 102, 103: 103, 104: 104, 105: 105, 106: 106, 107: 107, 108: 108, 109: 109, 110: 110, 111: 111, 112: 112, 113: 113, 114: 114, 115: 115, 116: 116, 117: 117, 118: 118, 119: 119, 120: 120, 121: 121, 122: 122, 123: 123, 124: 124, 125: 125, 126: 126, 127: 127, 1027: 129, 8225: 135, 1046: 198, 8222: 132, 1047: 199, 1168: 165, 1048: 200, 1113: 154, 1049: 201, 1045: 197, 1050: 202, 1028: 170, 160: 160, 1040: 192, 1051: 203, 164: 164, 166: 166, 167: 167, 169: 169, 171: 171, 172: 172, 173: 173, 174: 174, 1053: 205, 176: 176, 177: 177, 1114: 156, 181: 181, 182: 182, 183: 183, 8221: 148, 187: 187, 1029: 189, 1056: 208, 1057: 209, 1058: 210, 8364: 136, 1112: 188, 1115: 158, 1059: 211, 1060: 212, 1030: 178, 1061: 213, 1062: 214, 1063: 215, 1116: 157, 1064: 216, 1065: 217, 1031: 175, 1066: 218, 1067: 219, 1068: 220, 1069: 221, 1070: 222, 1032: 163, 8226: 149, 1071: 223, 1072: 224, 8482: 153, 1073: 225, 8240: 137, 1118: 162, 1074: 226, 1110: 179, 8230: 133, 1075: 227, 1033: 138, 1076: 228, 1077: 229, 8211: 150, 1078: 230, 1119: 159, 1079: 231, 1042: 194, 1080: 232, 1034: 140, 1025: 168, 1081: 233, 1082: 234, 8212: 151, 1083: 235, 1169: 180, 1084: 236, 1052: 204, 1085: 237, 1035: 142, 1086: 238, 1087: 239, 1088: 240, 1089: 241, 1090: 242, 1036: 141, 1041: 193, 1091: 243, 1092: 244, 8224: 134, 1093: 245, 8470: 185, 1094: 246, 1054: 206, 1095: 247, 1096: 248, 8249: 139, 1097: 249, 1098: 250, 1044: 196, 1099: 251, 1111: 191, 1055: 207, 1100: 252, 1038: 161, 8220: 147, 1101: 253, 8250: 155, 1102: 254, 8216: 145, 1103: 255, 1043: 195, 1105: 184, 1039: 143, 1026: 128, 1106: 144, 8218: 130, 1107: 131, 8217: 146, 1108: 186, 1109: 190}

function unicodeToWin1251_UrlEncoded(s) {
    var L = [];
    for (var i=0; i<s.length; i++) {
        var ord = s.charCodeAt(i);
        if (!(ord in DMap)) continue;
            // throw "Character "+s.charAt(i)+" isn't supported by win1251!";
        L.push('%'+DMap[ord].toString(16));
    }
    return L.join('').toUpperCase();
}

function start(){
    // if (window.location.pathname.indexOf("animes") && ($(".disabled").length || !$(".watch-online-placeholer").children().length)) {
    let lang = getAltWatcherLanguage();
    var animeName = $("#animes_show > section > div > header > h1").text().split(" / ")[lang === "en" ? 1 : 0],
        link = $('<a target="_blank"/>'),
        bar = $('<div/>'),
        pageType = (!!$('a.b-tag[href*="genre/12"]').length + 1),
        barItemClicked = function (){
            let lang = getAltWatcherLanguage();
            let animeName = $("#animes_show > section > div > header > h1").text().split(" / ")[lang === "en" ? 1 : 0];
            var i = selections[$(this).data('service-index')];
            if (i[1] === "Sibnet") {
                animeName = unicodeToWin1251_UrlEncoded(animeName)
            } else {
                animeName = encodeURIComponent(animeName)
            }
            link.attr('href', i[0] + animeName).text('Смотреть на ' + i[1]);
            setPrefService(pageType, i[1]);
            bar.hide();
        };

    for (var i = 0; i < selections.length; i++) {
        var v = selections[i];
        if ((v[2] & pageType) != 0)
            bar.append($('<a/>').addClass('b-link_button dark watch-online').text(v[1]).data('service-index', i).click(barItemClicked));
    }

    let en = $('<a>').addClass(lang === "en" ? "b-link_button dark" : "b-link_button").text('en').attr('title', "Искать по английскому названию").css({minWidth: 0});
    let ru = $('<a>').addClass(lang === "ru" ? "b-link_button dark" : "b-link_button").text('ru').attr('title', "Искать по русскому названию").css({minWidth: 0});
    let table = $('<table width="100%"/>').append($('<tr/>')
        .append($('<td/>').append(ru.click(function() {
            ru.addClass("dark")
            en.removeClass("dark")
            setAltWatcherLanguage("ru")
            start();
        })))
        .append($('<td/>').append(en.click(function(){
            en.addClass("dark")
            ru.removeClass("dark")
            setAltWatcherLanguage("en")
            start();
        }))));

    bar.append($('<div/>').addClass('block watch-online').css({top: "5px"}).append(table));


    i = getPrefService(pageType);
    if (i[1] === "Sibnet") {
        animeName = unicodeToWin1251_UrlEncoded(animeName)
    } else {
        animeName = encodeURIComponent(animeName)
    }
    $('#altWatcher_userscript').remove();
    $('#altWatcher_userscript_block').remove();
    $("#animes_show > section > div:nth-child(1) > div.menu-slide-outer.x199 > div > div > div.block > div.b-db_entry > div.c-about > div > div.c-info-right").append(
        $('<div/>').css({'textAlign': 'center'}).attr('id', 'altWatcher_userscript').append(
            $('<div/>').css({display: 'inline-flex'}).append(
                link.addClass("b-link_button dark")
                    .attr('href', i[0] + animeName).text('Смотреть на ' + i[1])
            ).append(
                $('<a/>').addClass("b-link_button dark").text('▼').css({
                    minWidth: 0,
                    marginBottom: '10px'
                }).click(function () {
                    bar.toggle();
                })
            )
        )
            .append(bar.addClass('block').css({marginBottom: 0}).attr('id', 'altWatcher_userscript_block').hide())
            .append($('<br/>'))
            .append(
                $('<a/>')
                    .attr('target', '_blank')
                    .attr('href', 'https://chrome.google.com/webstore/detail/shiki-extender/omonjfjfonodikianjjfdcdodjndnffe')
                    .text('Больше возможностей')
            )
    );

}

$(document).ready(start);
$(document).on('page:load', start);
$(document).on('turbolinks:load', start);
