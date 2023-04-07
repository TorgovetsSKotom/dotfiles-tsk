async function handleRequest(request) {
  const url = new URL(request.url);
  // change the hostname
  url.hostname = "rule34.paheal.net";
  let req = new Request(url, request);
  const response = await fetch(req, {
    // RequestInitCfProperties
    // see: https://developers.cloudflare.com/workers/runtime-apis/request#requestinitcfproperties
    cf: {
      minify: {
        javascript: true,
        css: true,
        html: true,
      },
      cacheTtl: 3600,
      cacheEverything: true,
      apps: false,
      scrapeShield: false,
      mirage: false,
      // resolveOverride: "example.domain.com",
    },
    headers: {
      Host: "rule34.paheal.net",
    },
  });
  const res = new Response(response.body, response);
  // force enableling CORS headers
  // see: https://developer.mozilla.org/en-US/docs/Web/API/Headers
  res.headers.delete("X-Frame-Options");
  res.headers.delete("X-Content-Type-Options");
  res.headers.delete("X-XSS-Protection");
  res.headers.delete("Pragma");
  res.headers.set("Access-Control-Allow-Methods", "*");
  res.headers.set("Access-Control-Allow-Origin", "*");
  res.headers.set("Access-Control-Expose-Headers", "*");
  res.headers.set("Cache-Control", "public, max-age=3600");
  const ctyp = res.headers.get("Content-Type");

  // If the response is HTML, it can be transformed with
  // HTMLRewriter -- otherwise, it should pass through
  if (ctyp.includes("html")) {
    return rewriter.transform(res);
  } else {
    return res;
  }
}
const tulip = "tulip.paheal.net";
const lotus = "lotus.paheal.net";
const peach = "peach.paheal.net";
const holly = "holly.paheal.net";
const old = "rule34.paheal.net";
const img1 = "a.r34.onmy.workers.dev";
const img2 = "b.r34.onmy.workers.dev";
const img3 = "c.r34.onmy.workers.dev";
const img4 = "d.r34.onmy.workers.dev";
const noold = "r34.onmy.workers.dev";
const goog = "www.google.com";
const js1 = "adspaces.ero-advertising.com";
const js2 = "a.exosrv.com";
const js3 = "a.realsrv.com";
const js4 = "js.juicyads.com";
const js5 = "adserver.juicyads.com";
const js6 = "poweredby.jads.co";
const nojs = "no-js-ads.r34.workers.dev";
class AttributeRewriter {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(tulip, img1));
    }
  }
}
class AttributeRewriter2 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(lotus, img2));
    }
  }
}
class AttributeRewriter3 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(peach, img3));
    }
  }
}
class AttributeRewriter4 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(holly, img4));
    }
  }
}
class AttributeRewriter5 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(old, noold));
    }
  }
}
class BlockAds {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(goog, nojs));
    }
  }
}
class BlockAds1 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js1, nojs));
    }
  }
}
class BlockAds2 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js2, nojs));
    }
  }
}
class BlockAds3 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js3, nojs));
    }
  }
}
class BlockAds4 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js4, nojs));
    }
  }
}
class BlockAds5 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js5, nojs));
    }
  }
}
class BlockAds6 {
  constructor(attributeName) {
    this.attributeName = attributeName;
  }
  element(element) {
    const attribute = element.getAttribute(this.attributeName);
    if (attribute) {
      element.setAttribute(this.attributeName, attribute.replace(js6, nojs));
    }
  }
}
const rewriter = new HTMLRewriter()
  .on("a", new AttributeRewriter("href"))
  .on("img", new AttributeRewriter("src"))
  .on("a", new AttributeRewriter2("href"))
  .on("img", new AttributeRewriter2("src"))
  .on("a", new AttributeRewriter3("href"))
  .on("img", new AttributeRewriter3("src"))
  .on("a", new AttributeRewriter4("href"))
  .on("img", new AttributeRewriter4("src"))
  .on("link", new AttributeRewriter5("href"))
  .on("a", new AttributeRewriter5("href"))
  .on("img", new AttributeRewriter5("src"))
  .on("script", new BlockAds("src"))
  .on("script", new BlockAds1("src"))
  .on("script", new BlockAds2("src"))
  .on("script", new BlockAds3("src"))
  .on("script", new BlockAds4("src"))
  .on("script", new BlockAds5("src"))
  .on("script", new BlockAds6("src"));

addEventListener("fetch", (event) => {
  return event.respondWith(handleRequest(event.request));
});