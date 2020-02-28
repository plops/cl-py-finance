function listener(details) {
    console.log("LISTENER:");
    // https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/onCompleted#details
    console.log(details);
    return {};
}

browser.webRequest.onCompleted.addListener(
    listener,
    {urls: ["https://query1.finance.yahoo.com/v8/finance/chart/*"]
    // ,types: ["xmlhttprequest"]
    }
);
