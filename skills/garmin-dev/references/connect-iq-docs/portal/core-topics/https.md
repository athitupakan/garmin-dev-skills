---
source: https://developer.garmin.com/connect-iq/core-topics/https/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/HTTPS.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# JSON REST Requests

Widgets and apps can communicate with a mobile phone via Bluetooth low energy (BLE). The mobile phone may be sharing data with the device, or it may act as a bridge between the app and the Internet. This allows the mobile phone to become part of the wearable web.

There are also high-level interfaces for making JSON and image requests. This allows developers the option of developing a wearable web app without having to write their own companion phone app.

| API | Purpose | API Level |
| --- | --- | --- |
| Communications.makeWebRequest() | Make an asynchronous JSON REST request to a web service | 1.3.0 |
| Communications.makeImageRequest() | Download an image from the web | 1.2.0 |
| Communications.openWebPage() | Commands Connect Mobile to ask the user to view a web link | 1.3.0 |

## JSON REST Requests via Mobile Proxy

Monkey C exposes a high level APIs to allow calls to basic web services through Garmin Connect Mobile via the Communications.makeWebRequest() and APIs. These APIs expose JSON requests and image requests as very straightforward APIs for making REST API calls. The JSON calls are converted to serialized Monkey C data and sent across the BLE pipe. You must have set the `Communications` permission to use this API.

Communications.makeWebRequest() provides a high level API for making a JSON REST request to an endpoint. The call is asynchronous and requires a callback to receive the data once the operation completes.

```
// It is common for developers to wrap a makeWebRequest() call in a function
// as displayed below. The function defines the variables for each of the
// necessary arguments in a Communications.makeWebRequest() call, then passes
// these variables as the arguments. This allows for a clean layout of your web
// request and expandability.
import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;

class JsonTransaction {
    // set up the response callback function
    function onReceive(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            System.println("Request Successful");                   // print success
        } else {
            System.println("Response: " + responseCode);            // print response code
        };

    };

    function makeRequest() as Void {
        var url = "https://www.garmin.com";                         // set the url

        var params = {                                              // set the parameters
            "definedParams" => "123456789abcdefg"
        };

        var options = {                                             // set the options
            :method => Communications.HTTP_REQUEST_METHOD_GET,      // set HTTP method
            :headers => {                                           // set headers
            "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED},
            // set response type
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_URL_ENCODED
        };

        var responseCallback = method(:onReceive);                  // set responseCallback to
        // onReceive() method
        // Make the Communications.makeWebRequest() call
        Communications.makeWebRequest(url, params, options, method(:onReceive));
    }
}
```

offers a similar API for making an image request. The images can be processed by the system, including applying a palette and dithering.

```
import Toybox.System;
import Toybox.Communications;
import Toybox.WatchUi;

class ImageTransaction {
    var image as BitmapResource?;
    var responseCode as Number?;

    // Set up the responseCallback function to return an image or null
    function responseCallback(responseCode as Number, data as BitmapResource?) {
        responseCode = responseCode;
        if (responseCode == 200) {
            image = data;
        } else {
            image = null;
        }
    }

    // wrap the request in a function
    function makeRequest() as Void {
        // set the image url
        var url = "http://www.garmin.com/image-path";
        // set the parameters
        var parameters = null;
        // set the options
        var options = {
            // set the palette
            :palette => [ Gfx.COLOR_ORANGE,
                          Gfx.COLOR_DK_BLUE,
                          Gfx.COLOR_BLUE,
                          Gfx.COLOR_BLACK
                        ],
            // set the max width
            :maxWidth => 100,
            // set the max height
            :maxHeight => 100,
            // set the dithering
            :dithering => Communications.IMAGE_DITHERING_NONE
        };

        // Make the image request
        Communications.makeImageRequest(url, parameters, options, method(:responseCallback));
    }
}
```

For more see the `WebRequest` sample app distributed with the SDK.

## Directing Users to Web Content

The call can be used to direct the user to a specific web page on the paired mobile device. When called, the specified web page should be fetched and displayed in the phones default browser. There is no callback for this function and the watch app has no method for checking if the call was completed on the phone successfully.
