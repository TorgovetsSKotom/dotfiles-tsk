// ==UserScript==
// @name         Joyreactor Get All Images From Post
// @namespace    http://tampermonkey.net/
// @version      0.1.2.1
// @description  allows to download all images from post as .tar file / дает возможность скачать все картинки из поста одним файлом в формате .tar
// @author       Gertykhon
// @updateURL    https://openuserjs.org/meta/Gertykhon/Joyreactor_Get_All_Images_From_Post.meta.js
// @include      *reactor.cc*
// @include      *joyreactor.cc*
// @include      *jr-proxy.com*
// @grant        GM_xmlhttpRequest
// @license      MIT
// ==/UserScript==

(function () {
  'use strict';

  /*
   * Leoric(@joyreactor.cc)
   */

  try {
    var posts = document.getElementsByClassName('post_content');

    for (var i of posts) {
      var imgdivs = i.getElementsByClassName('image');
      if (imgdivs.length > 1) { //0 - включить в т.ч. в постах с единственной картинкой, 1 - только с 2мя и более
        var a = document.createElement('a');
        a.textContent = 'скачать картинки';
        a.style = 'border:2px solid gray; padding:0px 4px 2px; cursor:pointer; ' +
          'display:block; width:200px; text-align:center; font-weight: bold';
        i.insertBefore(a, i.firstChild);
        a.addEventListener('click', download, {
          once: true
        });
      }
    }
  }
  catch (err) {
    console.log('JR Get Images: ' + err);
  }

  function download(event) {
    var file, base64;
    var tape = new Tar();
    var imgdivs = event.target.parentNode.getElementsByClassName('image');
    var links = [];
    var data;
    for (var j of imgdivs) {
      if (j.firstElementChild.tagName == 'A') {
        links.push(j.firstElementChild.getAttribute('href'));
      }
      else if (j.firstElementChild.tagName == 'IMG') {
        links.push(j.firstElementChild.getAttribute('src'));
      }
      else if (j.firstElementChild.firstElementChild.tagName == 'A') {
        links.push(j.firstElementChild.firstElementChild.getAttribute('href'));
      }
    }
    event.target.textContent = 'в процессе...';



    var l = 0;
    for (var k of links) {
//      GM_xmlhttpRequest({
//        method: "GET",
//        url: k,
//        headers: {
//          referer: k,
//          origin: k
//        },
//        responseType: "arraybuffer",
//        onload: function (resp) {
//          var imgurl = decodeURI(resp.finalUrl);
//          var fdata = new Uint8Array(resp.response);
//          var fname = imgurl.substring(imgurl.lastIndexOf('/') + 1).split('.');
//          l++;
//          file = tape.append('file_' + fname[0].substring(fname[0].lastIndexOf('-') + 1) + '.' + fname[1], fdata);
//          event.target.textContent = l + '/' + links.length;
//          if (l == links.length) {
//            var blob = new Blob([file], {
//              type: "application/tar"
//            });
//            event.target.textContent = 'готово';
//            event.target.setAttribute('download', fname[0].substring(0, fname[0].lastIndexOf('-')) + '.tar');
//            var objectURL = window.URL.createObjectURL(blob);
//            event.target.setAttribute('href', objectURL);
//            event.target.click();

            //возможность сразу после скачивания убрать за собой
            /*window.URL.revokeObjectURL(objectURL);
            event.target.removeAttribute("href");
            event.target.removeAttribute("download");*/
//          }
//        },
//        onerror: function (resp) {
//          console.log('Joyreactor Get Images: GM_xmlhttpRequest failed. ' + (resp.status ? resp.statusText : ''));
//          event.target.textContent = 'ошибка';
//        }
//      });
    var xhr = new XMLHttpRequest();
    xhr.open('get', k);
    xhr.responseType("arraybuffer");
    xhr.onload = function (resp) {
      var imgurl = decodeURI(resp.finalUrl);
      var fdata = new Uint8Array(resp.response);
      var fname = imgurl.substring(imgurl.lastIndexOf('/') + 1).split('.');
      l++;
      file = tape.append('file_' + fname[0].substring(fname[0].lastIndexOf('-') + 1) + '.' + fname[1], fdata);
      event.target.textContent = l + '/' + links.length;
      if (l == links.length) {
        var blob = new Blob([file], {
          type: "application/tar"
        });
        event.target.textContent = 'готово';
        event.target.setAttribute('download', fname[0].substring(0, fname[0].lastIndexOf('-')) + '.tar');
        var objectURL = window.URL.createObjectURL(blob);
        event.target.setAttribute('href', objectURL);
        event.target.click();

        //возможность сразу после скачивания убрать за собой
        /*window.URL.revokeObjectURL(objectURL);
        event.target.removeAttribute("href");
        event.target.removeAttribute("download");*/
      }
    },
    xhr.onerror = function (resp) {
      console.log('Joyreactor Get Images: XmlHttpRequest failed. ' + (resp.status ? resp.statusText : ''));
      event.target.textContent = 'ошибка';
    }
    xhr.send();
    }
  }

  /*
   * tar-js
   * MIT (c) 2011 T. Jameson Little
   */

  function Utils() {
    this.clean = function (length) {
      var i, buffer = new Uint8Array(length);
      for (i = 0; i < length; i += 1) {
        buffer[i] = 0;
      }
      return buffer;
    };

    this.extend = function (orig, length, addLength, multipleOf) {
      var newSize = length + addLength,
        buffer = this.clean((parseInt(newSize / multipleOf) + 1) * multipleOf);

      buffer.set(orig);

      return buffer;
    };

    this.pad = function (num, bytes, base) {
      num = num.toString(base || 8);
      return "000000000000".substr(num.length + 12 - bytes) + num;
    };

    this.stringToUint8 = function (input, out, offset) {
      var i, length;

      out = out || this.clean(input.length);

      offset = offset || 0;
      for (i = 0, length = input.length; i < length; i += 1) {
        out[offset] = input.charCodeAt(i);
        offset += 1;
      }

      return out;
    };

    this.uint8ToBase64 = function (uint8) {
      var i,
        extraBytes = uint8.length % 3, // if we have 1 byte left, pad 2 bytes
        output = "",
        temp, length;

      function tripletToBase64(num) {
        var lookup = [
          'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
          'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
          'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
          'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
          'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
          'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
          'w', 'x', 'y', 'z', '0', '1', '2', '3',
          '4', '5', '6', '7', '8', '9', '+', '/'
        ];
        return lookup[num >> 18 & 0x3F] + lookup[num >> 12 & 0x3F] + lookup[num >> 6 & 0x3F] + lookup[num & 0x3F];
      };

      // go through the array every three bytes, we'll deal with trailing stuff later
      for (i = 0, length = uint8.length - extraBytes; i < length; i += 3) {
        temp = (uint8[i] << 16) + (uint8[i + 1] << 8) + (uint8[i + 2]);
        output += tripletToBase64(temp);
      }

      // this prevents an ERR_INVALID_URL in Chrome (Firefox okay)
      switch (output.length % 4) {
        case 1:
          output += '=';
          break;
        case 2:
          output += '==';
          break;
        default:
          break;
      }

      return output;
    };
  }

  var utils = new Utils();

  function Header() {

    /*
  struct posix_header {             // byte offset
    char name[100];               //   0
    char mode[8];                 // 100
    char uid[8];                  // 108
    char gid[8];                  // 116
    char size[12];                // 124
    char mtime[12];               // 136
    char chksum[8];               // 148
    char typeflag;                // 156
    char linkname[100];           // 157
    char magic[6];                // 257
    char version[2];              // 263
    char uname[32];               // 265
    char gname[32];               // 297
    char devmajor[8];             // 329
    char devminor[8];             // 337
    char prefix[155];             // 345
                                    // 500
  };
  */

    this.structure = [{
        'field': 'fileName',
        'length': 100
      },
      {
        'field': 'fileMode',
        'length': 8
      },
      {
        'field': 'uid',
        'length': 8
      },
      {
        'field': 'gid',
        'length': 8
      },
      {
        'field': 'fileSize',
        'length': 12
      },
      {
        'field': 'mtime',
        'length': 12
      },
      {
        'field': 'checksum',
        'length': 8
      },
      {
        'field': 'type',
        'length': 1
      },
      {
        'field': 'linkName',
        'length': 100
      },
      {
        'field': 'ustar',
        'length': 8
      },
      {
        'field': 'owner',
        'length': 32
      },
      {
        'field': 'group',
        'length': 32
      },
      {
        'field': 'majorNumber',
        'length': 8
      },
      {
        'field': 'minorNumber',
        'length': 8
      },
      {
        'field': 'filenamePrefix',
        'length': 155
      },
      {
        'field': 'padding',
        'length': 12
      }
    ];

    this.format = function (data, cb) {
      var buffer = utils.clean(512),
        offset = 0;

      this.structure.forEach(function (value) {
        var str = data[value.field] || "",
          i, length;

        for (i = 0, length = str.length; i < length; i += 1) {
          buffer[offset] = str.charCodeAt(i);
          offset += 1;
        }

        offset += value.length - i; // space it out with nulls
      });

      if (typeof cb === 'function') {
        return cb(buffer, offset);
      }
      return buffer;
    };
  }

  var header = new Header();

  function Tar(recordsPerBlock) {

    var recordSize = 512,
      blockSize;
    this.written = 0;
    blockSize = (recordsPerBlock || 20) * recordSize;
    this.out = utils.clean(blockSize);

    this.append = function (filepath, input, opts, callback) {
      var data,
        checksum,
        mode,
        mtime,
        uid,
        gid,
        headerArr;

      if (typeof input === 'string') {
        input = utils.stringToUint8(input);
      }
      else if (input.constructor !== Uint8Array.prototype.constructor) {
        //console.log('Invalid input type');
        throw 'Invalid input type. You gave me: ' + input.constructor.toString().match(/function\s*([$A-Za-z_][0-9A-Za-z_]*)\s*\(/)[1];
      }

      if (typeof opts === 'function') {
        callback = opts;
        opts = {};
      }

      opts = opts || {};

      mode = opts.mode || parseInt('777', 8) & 0xfff;
      mtime = opts.mtime || Math.floor(+new Date() / 1000);
      uid = opts.uid || 0;
      gid = opts.gid || 0;

      data = {
        fileName: filepath,
        fileMode: utils.pad(mode, 7),
        uid: utils.pad(uid, 7),
        gid: utils.pad(gid, 7),
        fileSize: utils.pad(input.length, 11),
        mtime: utils.pad(mtime, 11),
        checksum: '        ',
        type: '0', // just a file
        ustar: 'ustar  ',
        owner: opts.owner || '',
        group: opts.group || ''
      };

      // calculate the checksum
      checksum = 0;
      Object.keys(data).forEach(function (key) {
        var i, value = data[key],
          length;

        for (i = 0, length = value.length; i < length; i += 1) {
          checksum += value.charCodeAt(i);
        }
      });

      data.checksum = utils.pad(checksum, 6) + "\u0000 ";

      headerArr = header.format(data);

      var i, offset, length;

      this.out.set(headerArr, this.written);

      this.written += headerArr.length;

      // If there is not enough space in this.out, we need to expand it to
      // fit the new input.
      if (this.written + input.length > this.out.length) {
        this.out = utils.extend(this.out, this.written, input.length, blockSize);
      }

      this.out.set(input, this.written);

      // to the nearest multiple of recordSize
      this.written += input.length + (recordSize - (input.length % recordSize || recordSize));

      // make sure there's at least 2 empty records worth of extra space
      if (this.out.length - this.written < recordSize * 2) {
        this.out = utils.extend(this.out, this.written, recordSize * 2, blockSize);
      }

      if (typeof callback === 'function') {
        callback(this.out);
      }

      return this.out;
    };

    this.clear = function () {
      this.written = 0;
      this.out = utils.clean(blockSize);
    };
  }

  /*function uint8ToString(buf) {
      var i, length, out = '';
      for (i = 0, length = buf.length; i < length; i += 1) {
          out += String.fromCharCode(buf[i]);
      }
      return out;
  }

  function stringToUint8 (input) {
      var out = new Uint8Array(input.length), i;

      for (i = 0; i < input.length; i += 1) {
          out[i] = input.charCodeAt(i);
      }
      return out;
  }*/

  // end of tar js

  function Uint8ToString(u8a) {
    var CHUNK_SZ = 0x8000;
    var c = [];
    for (var i = 0; i < u8a.length; i += CHUNK_SZ) {
      c.push(String.fromCharCode.apply(null, u8a.subarray(i, i + CHUNK_SZ)));
    }
    return c.join("");
  }

})();
