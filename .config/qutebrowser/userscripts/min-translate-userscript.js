// ==UserScript==
// @name Translate Page
// @match *
// @run-at context-menu
// ==/UserScript==

const TRANSLATE_TO_LANG = 'en'

function isVisible (el) {
  // https://github.com/jquery/jquery/blob/305f193aa57014dc7d8fa0739a3fefd47166cd44/src/css/hiddenVisibleSelectors.js
  return el.offsetWidth || el.offsetHeight || (el.getClientRects && el.getClientRects().length)
}

function getNodes (doc, win) {
  var maybeNodes = [].slice.call(doc.body.childNodes)
  var textNodes = []

  var ignore = 'link, style, script, noscript, .hidden, [class*="-hidden"], .visually-hidden, .visuallyhidden, [role=presentation], [hidden], [style*="display:none"], [style*="display: none"], .ad, .dialog, .modal, select, svg, details:not([open])'

  while (maybeNodes.length) {
    var node = maybeNodes.shift()

    // if the node should be ignored, skip it and all of it's child nodes
    if (node.matches && node.matches(ignore)) {
      continue
    }

    // if the node is a text node, add it to the list of text nodes

    if (node.nodeType === 3) {
      textNodes.push(node)
      continue
    }

    if (!isVisible(node)) {
      continue
    }

    // otherwise, add the node's text nodes to the list of text, and the other child nodes to the list of nodes to check
    var childNodes = node.childNodes
    var cnl = childNodes.length

    for (var i = cnl - 1; i >= 0; i--) {
      var childNode = childNodes[i]
      maybeNodes.unshift(childNode)
    }
  }

  return textNodes
}

async function translate (doc, win) {
  console.log(doc, win)
  var nodes = getNodes(doc, win).filter(n => n.textContent.replace(/\s+/g, '').length > 5)

  var query = nodes.slice(0, 100).map(node => node.textContent)

  const res = await fetch('https://libretranslate.de/translate', {
    method: 'POST',
    body: JSON.stringify({
      q: query,
      source: 'auto',
      target: TRANSLATE_TO_LANG
    }),
    headers: { 'Content-Type': 'application/json' }
  })

  const result = await res.json()

  console.log(result)

  result.translatedText.forEach(function (text, i) {
    if (query[i].startsWith(' ')) {
      text = ' ' + text
    }
    if (query[i].endsWith(' ')) {
      text += ' '
    }
    nodes[i].textContent = text
  })
}

translate(document, window)
