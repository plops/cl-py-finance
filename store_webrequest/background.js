function listener(details) {
    console.log(details);
    return {};
}

browser.webRequest.onCompleted.addListener(
    listener,
    {urls: ["https://query1.finance.yahoo.com/v8/finance/chart/*"], types: ["main_frame"]},
    ["blocking"]
);
