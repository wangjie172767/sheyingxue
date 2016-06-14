


function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge);
    } else {
        document.addEventListener(‘WebViewJavascriptBridgeReady’, function() {
                                  callback(WebViewJavascriptBridge);
                                  }, false);
    }
}

connectWebViewJavascriptBridge(function(bridge) {
                               
   /* Init your app here */
   
   bridge.init(function(message, responseCallback) {
               if (responseCallback) {
               responseCallback(“Right back Catcha”);
               }
               })
                               
   /* imgCallback 是注册方法名，data 传递高清图片地址 */
   bridge.registerHandler(“imgCallback”, function(data, responseCallback) {
                          // 成功之后回调
                          responseCallback(document.location.toString());
                          })
})

