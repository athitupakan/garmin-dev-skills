---
source: https://developer.garmin.com/connect-iq/api-docs/Toybox/Communications.html
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/Toybox/Communications.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Module: Toybox.Communications

## Overview

The Communications Module provides tools for communication.

With the Communications module, widgets and apps will be able to communicate with a mobile phone via Bluetooth Low Energy (BLE). The mobile phone may be sharing data with the device, or it may act as a bridge between the app and the Internet. This allows the device to become part of the Internet of Things.

Note:

This module was made available to foreground data fields with API 5.0.0

**Since:** API Level 1.0.0

**App Types and Runtime Contexts:**

- Audio Content Provider
- Background
- Data Field
- Glance
- Watch App
- Widget

_Supported on 163 devices._

**Requires Permission:**

- Communications

## Classes Under Namespace

**Classes:** ConnectionListener, MailboxIterator, Message, OAuthMessage, PhoneAppMessage, SyncDelegate

## Constant Summary

### Error

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| UNKNOWN_ERROR | 0 | API Level 1.0.0 | An unknown error has occurred. |
| BLE_ERROR | -1 | API Level 1.0.0 | A generic BLE error has occurred. |
| BLE_HOST_TIMEOUT | -2 | API Level 1.0.0 | We timed out waiting for a response from the host. |
| BLE_SERVER_TIMEOUT | -3 | API Level 1.0.0 | We timed out waiting for a response from a server. |
| BLE_NO_DATA | -4 | API Level 1.0.0 | Response contained no data. |
| BLE_REQUEST_CANCELLED | -5 | API Level 1.0.0 | The request was cancelled at the request of the system. |
| BLE_QUEUE_FULL | -101 | API Level 1.0.0 | Too many requests have been made. |
| BLE_REQUEST_TOO_LARGE | -102 | API Level 1.0.0 | Serialized input data for the request was too large. |
| BLE_UNKNOWN_SEND_ERROR | -103 | API Level 1.0.0 | Send failed for an unknown reason. |
| BLE_CONNECTION_UNAVAILABLE | -104 | API Level 1.0.0 | No BLE connection is available. |
| INVALID_HTTP_HEADER_FIELDS_IN_REQUEST | -200 | API Level 1.0.0 | Request contained invalid http header fields. |
| INVALID_HTTP_BODY_IN_REQUEST | -201 | API Level 1.0.0 | Request contained an invalid http body. |
| INVALID_HTTP_METHOD_IN_REQUEST | -202 | API Level 1.0.0 | Request used an invalid http method. |
| NETWORK_REQUEST_TIMED_OUT | -300 | API Level 1.0.0 | Request timed out before a response was received. |
| INVALID_HTTP_BODY_IN_NETWORK_RESPONSE | -400 | API Level 1.0.0 | Response body data is invalid for the request type. |
| INVALID_HTTP_HEADER_FIELDS_IN_NETWORK_RESPONSE | -401 | API Level 1.0.0 | Response contained invalid http header fields. |
| NETWORK_RESPONSE_TOO_LARGE | -402 | API Level 1.0.0 | Serialized response was too large. |
| NETWORK_RESPONSE_OUT_OF_MEMORY | -403 | API Level 3.0.0 | Ran out of memory processing network response. |
| STORAGE_FULL | -1000 | API Level 2.2.0 | Filesystem too full to store response data. |
| SECURE_CONNECTION_REQUIRED | -1001 | API Level 2.3.0 | Indicates an https connection is required for the request. |
| UNSUPPORTED_CONTENT_TYPE_IN_RESPONSE | -1002 | API Level 2.4.1 | Content type given in response is not supported or does not match what is expected. |
| REQUEST_CANCELLED | -1003 | API Level 2.4.2 | Http request was cancelled by the system. |
| REQUEST_CONNECTION_DROPPED | -1004 | API Level 3.0.0 | Connection was lost before a response could be obtained. |
| UNABLE_TO_PROCESS_MEDIA | -1005 | API Level 3.0.2 | Downloaded media file was unable to be read. |
| UNABLE_TO_PROCESS_IMAGE | -1006 | API Level 3.0.3 | Downloaded image file was unable to be processed. |
| UNABLE_TO_PROCESS_HLS | -1007 | API Level 3.0.10 | HLS content could not be downloaded. Most often occurs when requested and provided bit rates do not match. |

### TokenResult

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| OAUTH_RESULT_TYPE_URL | 0 | API Level 1.3.0 | How the OAuth token will be returned in the final step. |

### SigningMethod

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| OAUTH_SIGNING_METHOD_HMAC_SHA1 | 0 | API Level 1.3.0 | How the OAuth request will be signed |

### HttpRequestMethod

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| HTTP_REQUEST_METHOD_GET | 1 | API Level 1.2.0 | Specifies a request be executed using the GET method. |
| HTTP_REQUEST_METHOD_PUT | 2 | API Level 1.2.0 | Specifies a request be executed using the PUT method. |
| HTTP_REQUEST_METHOD_POST | 3 | API Level 1.2.0 | Specifies a request be executed using the POST method. |
| HTTP_REQUEST_METHOD_DELETE | 4 | API Level 1.2.0 | Specifies a request be executed using the DELETE method. |

### HttpResponseContentType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| HTTP_RESPONSE_CONTENT_TYPE_JSON | 0 | API Level 1.3.0 | Content type specifier for response is expected to be a json type. Content type string must be "application/json". |
| HTTP_RESPONSE_CONTENT_TYPE_URL_ENCODED | 1 | API Level 1.3.0 | Content type specifier for response is expected to indicate url encoding. Content type string must be "application/x-www-form-urlencoded". |
| HTTP_RESPONSE_CONTENT_TYPE_GPX | 2 | API Level 2.2.0 | Content type specifier for response is expected to be a gpx type. |
| HTTP_RESPONSE_CONTENT_TYPE_FIT | 3 | API Level 2.2.0 | Content type specifier for response is expected to be a FIT type. |
| HTTP_RESPONSE_CONTENT_TYPE_AUDIO | 4 | API Level 3.0.0 | Content type specifier for response is expected to be an audio type. Content type string must be of the "audio/*" format. |
| HTTP_RESPONSE_CONTENT_TYPE_TEXT_PLAIN | 5 | API Level 3.0.0 | Content type specifier for response is expected to be plain text type. Content type string must be "text/plain" |
| HTTP_RESPONSE_CONTENT_TYPE_HLS_DOWNLOAD | 6 | API Level 3.0.10 | Content type specifier for response is expected to be an HLS data type. Content type string must be either "application/vnd.apple.mpegurl" or "audio/mpegurl". |
| HTTP_RESPONSE_CONTENT_TYPE_ANIMATION_MANIFEST | 7 | API Level 3.1.0 | Content type specifier for response is expected to be a CIQ animation manifest data type. Content type string must be "application/vnd.garmin.connectiq.animation.manifest". |
| HTTP_RESPONSE_CONTENT_TYPE_ANIMATION | 8 | API Level 3.1.0 | Content type specifier for response is expected to be a CIQ animation data type. Content type string must be "image/vnd.garmin.connectiq.animation". |

### WifiConnectionStatus

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| WIFI_CONNECTION_STATUS_LOW_BATTERY | 1 | API Level 3.2.0 | Specifies an error condition, battery is too low to start a WIFI connection. |
| WIFI_CONNECTION_STATUS_NO_ACCESS_POINTS | 2 | API Level 3.2.0 | Specifies an error condition, no access-point is stored on the device. |
| WIFI_CONNECTION_STATUS_UNSUPPORTED | 3 | API Level 3.2.0 | Specifies an error condition, WIFI is not supported on current device. |
| WIFI_CONNECTION_STATUS_USER_DISABLED | 4 | API Level 3.2.0 | Specifies an error condition, WIFI is disabled by user. |
| WIFI_CONNECTION_STATUS_BATTERY_SAVER_ACTIVE | 5 | API Level 3.2.0 | Specifies an error condition, WIFI is disabled by battery saver. |
| WIFI_CONNECTION_STATUS_STEALTH_MODE_ACTIVE | 6 | API Level 3.2.0 | Specifies an error condition, WIFI is disabled by stealth mode. |
| WIFI_CONNECTION_STATUS_AIRPLANE_MODE_ACTIVE | 7 | API Level 3.2.0 | Specifies an error condition, WIFI is disabled by airplane mode. |
| WIFI_CONNECTION_STATUS_POWERED_DOWN | 8 | API Level 3.2.0 | Specifies an error condition, WIFI is disabled by the device. |
| WIFI_CONNECTION_STATUS_UNKNOWN | 9 | API Level 3.2.0 | Specifies an error condition, WIFI is not usable but status is unknown. |
| WIFI_CONNECTION_STATUS_CANNOT_CONNECT_TO_ACCESS_POINT | 10 | API Level 3.3.0 | Specifies an error condition, WIFI can not connect to saved AccessPoint. |
| WIFI_CONNECTION_STATUS_TRANSFER_ALREADY_IN_PROGRESS | 11 | API Level 3.3.0 | Specifies an error condition, WIFI transfer already in progress |

### HttpRequestContentType

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| REQUEST_CONTENT_TYPE_URL_ENCODED | 0 | API Level 1.2.0 | Specifies a content type of application/x-www-form-urlencoded |
| REQUEST_CONTENT_TYPE_JSON | 1 | API Level 1.2.0 | Specifies a content type of application/json |

### PackingFormat

Image packing format used for image request.

The packing format describes the encoding a requested image should use when being transmitted. The encoding used affects the transfer size, decoding time, and image quality.

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| PACKING_FORMAT_DEFAULT | 0 | API Level 4.2.0 | Image data is encoded in the device native format, a lossless encoding that available on all devices. It is very efficient to decode, but often results in large transfer sizes so is slow to download. |
| PACKING_FORMAT_YUV | 1 | API Level 4.2.0 | Image data is encoded in YUV format. This is a lossy encoding that is compressed, and is fast to load. It is ideal for photographic imagery with transparency. |
| PACKING_FORMAT_PNG | 2 | API Level 4.2.0 | Image data is encoded in PNG format. This is a lossless encoding that is compressed, but is relatively slow to load. It is ideal for non-photographic imagery. |
| PACKING_FORMAT_JPG | 3 | API Level 4.2.0 | Image data is encoded in JPG format. This is a lossy encoding that is compressed, and is reasonably fast to load. It is ideal for photographic imagery. |

### HlsBandwidth

TVM will select the HLS audio stream with the highest bandwidth that's less than or equal to the maximum

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| HLS_AUDIO_BANDWIDTH_48K | 49152 | API Level 3.0.10 |  |
| HLS_AUDIO_BANDWIDTH_128K | 131072 | API Level 3.0.10 |  |
| HLS_AUDIO_BANDWIDTH_256K | 262144 | API Level 3.0.10 |  |

### Dithering

**Since:** API Level 1.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| IMAGE_DITHERING_NONE | 1 | API Level 1.2.0 | Do not apply dithering to an image. |
| IMAGE_DITHERING_FLOYD_STEINBERG | 2 | API Level 1.2.0 | Apply Floyd-Steinberg dithering to an image. |

### PhoneAppMessageError

**Since:** API Level 6.0.0

| Name | Value | Since | Description |
| --- | --- | --- | --- |
| PHONE_APP_MESSAGE_ERROR_OUT_OF_MEMORY | 0 | API Level 6.0.0 |  |
| PHONE_APP_MESSAGE_ERROR_OUT_OF_STORAGE | 1 | API Level 6.0.0 |  |

## Typedef Summary
- **PhoneMessageCallback** as Lang.Method(msg as Communications.PhoneAppMessage) as **Void**
- **PhoneMessageErrorCallback** as Lang.Method(error as Communications.PhoneAppMessageError) as **Void**
- **TransmitKeyType** as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char
- **TransmitType** as Communications.TransmitKeyType or Lang.ByteArray or Lang.Array or Lang.Dictionary or **Null**

## Instance Method Summary
- **cancelAllRequests**() as **Void** Cancel all pending JSON and Image requests.
- **checkWifiConnection**(connectionStatusCallback as Lang.Method(result as { :wifiAvailable as Lang.Boolean, :errorCode as Communications.WifiConnectionStatus }) as **Void**) as **Void** Checks if an internet-enabled WIFI access point is visible and can be connected to.
- **emptyMailbox**() as **Void** deprecated Clear the contents of the mailbox.
- **encodeURL**(url as Lang.String) as Lang.String Convert a URL String into a percent-encoded string.
- **generateSignedOAuthHeader**(url as Lang.String, params as Lang.Dictionary, requestMethod as Communications.HttpRequestMethod, signatureMethod as Communications.SigningMethod, token as Lang.String or **Null**, tokenSecret as Lang.String, consumerKey as Lang.String, consumerSecret as Lang.String) as Lang.String deprecated Generate the value for the "Authorization" header in an OAuth 1.0a request.
- **getMailbox**() as Communications.MailboxIterator deprecated Get the MailboxIterator for this Application's mailbox.
- **makeImageRequest**(url as Lang.String, parameters as Lang.Dictionary or **Null**, options as { :palette as Lang.Array, :maxWidth as Lang.Number, :maxHeight as Lang.Number, :dithering as Communications.Dithering, :packingFormat as Communications.PackingFormat }, responseCallback as Lang.Method(responseCode as Lang.Number, data as WatchUi.BitmapResource or Graphics.BitmapReference or **Null**) as **Void**) as **Void** Initiate an image download request.
- **makeJsonRequest**(url as Lang.String, parameters as Lang.Dictionary or **Null**, options as { :method as Communications.HttpRequestMethod, :headers as Lang.Dictionary } or **Null**, responseCallback as Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or **Null**) as **Void**) as **Void** deprecated Initiate a download request.
- **makeOAuthRequest**(requestUrl as Lang.String, requestParams as Lang.Dictionary, resultUrl as Lang.String, resultType as Communications.TokenResult, resultKeys as Lang.Dictionary) as **Void** Request an OAuth sign-in through Garmin Connect Mobile.
- **makeWebRequest**(url as Lang.String, parameters as Lang.Dictionary or **Null**, options as { :method as Communications.HttpRequestMethod, :headers as Lang.Dictionary, :responseType as Communications.HttpResponseContentType, :context as Lang.Object or **Null**, :maxBandwidth as Lang.Number, :fileDownloadProgressCallback as Lang.Method(totalBytesTransferred as Lang.Number, fileSize as Lang.Number or **Null**) as **Void** } or **Null**, responseCallback as Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or **Null**) as **Void** or Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or **Null**, context as Lang.Object) as **Void**) as **Void** Initiate a download request.
- **notifySyncComplete**(errorMessage as Lang.String or **Null**) as **Void** Send a system notification to indicate that the sync completed.
- **notifySyncProgress**(percentageComplete as Lang.Number) as **Void** Send a system notification to indicate overall sync progress.
- **openWebPage**(url as Lang.String, params as Lang.Dictionary or **Null**, options as Lang.Dictionary or **Null**) as **Void** Request that GCM issue a phone notification that will open a web page.
- **registerForOAuthMessages**(method as Lang.Method(data as Communications.OAuthMessage) as **Void**) as **Void** Register a callback for receiving OAuth messages.
- **registerForPhoneAppMessageErrors**(method as Communications.PhoneMessageErrorCallback or **Null**) as **Void** Register a callback for receiving Phone App message errors.
- **registerForPhoneAppMessages**(method as Communications.PhoneMessageCallback or **Null**) as **Void** Register a callback for receiving Phone App messages.
- **setMailboxListener**(listener as Lang.Method(mailboxIterator as Communications.MailboxIterator) as **Void**) as **Void** deprecated Add a listener for mailbox events.
- **startSync**() as **Void** Exit the AppBase and launch it in sync mode.
- **startSync2**(options as { :message as Lang.String } or **Null**) as **Void** Exit the AppBase and launch it in sync mode with the provided message.
- **transmit**(content as Communications.TransmitType, options as Lang.Dictionary or **Null**, listener as Communications.ConnectionListener) as **Void** Send data across the the BLE link.

## Typedef Details

### `PhoneMessageCallback as Lang.Method(msg as Communications.PhoneAppMessage) as Void`

**Since:** API Level 1.0.0

### `PhoneMessageErrorCallback as Lang.Method(error as Communications.PhoneAppMessageError) as Void`

**Since:** API Level 1.0.0

### `TransmitKeyType as Lang.Number or Lang.Float or Lang.Long or Lang.Double or Lang.String or Lang.Boolean or Lang.Char`

**Since:** API Level 1.0.0

### `TransmitType as Communications.TransmitKeyType or Lang.ByteArray or Lang.Array or Lang.Dictionary or Null`

**Since:** API Level 1.0.0

## Instance Method Details

### `cancelAllRequests() as Void`

Cancel all pending JSON and Image requests.

The number of active requests running in parallel is limited in the Connect IQ platform. This call will cancel all outstanding requests.

**Since:** API Level 1.2.0

### `checkWifiConnection(connectionStatusCallback as Lang.Method(result as { :wifiAvailable as Lang.Boolean, :errorCode as Communications.WifiConnectionStatus }) as Void) as Void`

Checks if an internet-enabled WIFI access point is visible and can be connected to

**Parameters:**
- connectionStatusCallback — (Lang.Method) — A callback that will be invoked after the connection test has completed. This callback accepts a single dictionary parameter. This dictionary has two keys: :wifiAvailable `true` if an access point with internet access could be connected to, `false` otherwise
- :errorCode If :wifiAvailable is `false` the value will be a WIFI_CONNECTION_STATUS_* indicating why the connection is not available.

**Since:** API Level 3.2.0

### `emptyMailbox() as Void`

 **This has been deprecated**

This method may be removed after System 4.

Clear the contents of the mailbox.

_Supported on 139 devices._

**See Also:**

- Communications.registerForPhoneAppMessages()

**Since:** API Level 1.0.0

### `encodeURL(url as Lang.String) as Lang.String`

Convert a URL String into a percent-encoded string.

The reserved characters in the string will be replaced with their corresponding hex-value pairs. This follows the URI-encoding scheme as detailed by RFC 3986.

**Parameters:**
- url — (Lang.String) — The URL String to be encoded

**Returns:**
- Lang.String — A percent-encoded String

**See Also:**

- RFC 3986

**Since:** API Level 1.1.2

### `generateSignedOAuthHeader(url as Lang.String, params as Lang.Dictionary, requestMethod as Communications.HttpRequestMethod, signatureMethod as Communications.SigningMethod, token as Lang.String or Null, tokenSecret as Lang.String, consumerKey as Lang.String, consumerSecret as Lang.String) as Lang.String`

 **This has been deprecated**

This method may be removed after System 10.

Generate the value for the "Authorization" header in an OAuth 1.0a request.

The returned value can be set as the "Authorization" header for makeWebRequest().

Note:

It is recommended to use OAuth 2.0 instead of OAuth 1.0a. See Toybox::Communications#makeOAuthRequest.

**Parameters:**
- url — (Lang.String) — The request URL
- params — (Lang.Dictionary) — The parameters of the request
- requestMethod — (Communications.HttpRequestMethod) — An HTTP_REQUEST_METHOD_* value
- signatureMethod — (Communications.SigningMethod) — An OAUTH_SIGNING_METHOD_* value
- token — (Lang.String, null) — The token given by the OAuth service Can be `null`

tokenSecret

 —

(
Lang.String
)

 —

The token secret given by the OAuth service. Used to sign the request

consumerKey

 —

(
Lang.String
)

 —

The key that identifies your application

consumerSecret

 —

(
Lang.String
)

 —

The consumer secret that is used to sign the request

**Returns:**
- Lang.String — The value for the "Authorization" header

**Since:** API Level 1.3.0

### `getMailbox() as Communications.MailboxIterator`

 **This has been deprecated**

This method may be removed after System 4.

Get the MailboxIterator for this Application's mailbox.

_Supported on 139 devices._

**Returns:**
- Communications.MailboxIterator — Iterator for the mailbox

**See Also:**

- Communications.registerForPhoneAppMessages()

**Since:** API Level 1.0.0

### `makeImageRequest(url as Lang.String, parameters as Lang.Dictionary or Null, options as { :palette as Lang.Array, :maxWidth as Lang.Number, :maxHeight as Lang.Number, :dithering as Communications.Dithering, :packingFormat as Communications.PackingFormat }, responseCallback as Lang.Method(responseCode as Lang.Number, data as WatchUi.BitmapResource or Graphics.BitmapReference or Null) as Void) as Void`

Initiate an image download request.

GCM will scale and dither the image based on the capabilities of the device, but the user will be able to pass additional options (like dithering it down to a one color image)

Note:

This method can be used when connected to WiFi or a mobile device over Bluetooth.

**Parameters:**
- url — (Lang.String) — The URL of an image to request
- parameters — (Lang.Dictionary, null) — The Dictionary of keys and values Appended to the URL
- Can be `null`

options

 —

(
Lang.Dictionary
)

 —

Additional image options

- :palette — (Lang.Array) — The color palette to restrict the image dithering to. Using a smaller palette can reduce the size of the image data to speed up transfers
- :maxWidth — (Lang.Number) — The maximum width an image should be scaled to
- :maxHeight — (Lang.Number) — The maximum height an image should be scaled to
- :dithering — (Communications.Dithering) — The type of dithering to use when processing the image. Defaults to IMAGE_DITHERING_FLOYD_STEINBERG
- :packingFormat — (Communications.PackingFormat) — The format of the image data to request. Defaults to PACKING_FORMAT_DEFAULT

responseCallback

 —

(
Lang.Method
)

 —

A reference to a callback method which must accept two arguments:

- responseCode: The server response code or a BLE_* error type
- data: A BitmapResource or BitmapReference from a successful request, or `null` on error

**Example:**
```
using Toybox.System;
using Toybox.Communications;

var image;
var responseCode;

    // Set up the responseCallback function to return an image or null
    function responseCallback(responseCode, data) {
        responseCode = responseCode;
        if (responseCode == 200) {
            image = data;
        } else {
            image = null;
        }
    }

    // wrap the request in a function
    function makeRequest() {
        var url = "http://www.garmin.com/image-path";           // set the image url
        var parameters = null;                                  // set the parameters
        var options = {                                         // set the options
            :palette => [ Gfx.COLOR_ORANGE,                     // set the palette
                          Gfx.COLOR_DK_BLUE,
                          Gfx.COLOR_BLUE,
                          Gfx.COLOR_BLACK ],
            :maxWidth => 100,                                   // set the max width
            :maxHeight => 100,                                  // set the max height
            :dithering => Communications.IMAGE_DITHERING_NONE   // set the dithering
        };

        // Make the image request
        Communications.makeImageRequest(url, parameters, options, method(:responseCallback));
    }
```

**Since:** API Level 1.2.0

### `makeJsonRequest(url as Lang.String, parameters as Lang.Dictionary or Null, options as { :method as Communications.HttpRequestMethod, :headers as Lang.Dictionary } or Null, responseCallback as Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or Null) as Void) as Void`

 **This has been deprecated**

This method may be removed after System 4.

Initiate a download request.

The request is asynchronous; the responseCallback will be called when the request returns.

Note:

This method can be used when connected to WiFi or a mobile device over Bluetooth.

**Parameters:**
- url — (Lang.String) — The URL being requested
- parameters — (Lang.Dictionary) — A Dictionary of keys and values Appended to the URL for GET/DELETE request
- Set as the body for a POST/PUT request
- These values must be URL encoded
- Can be `null`

options

 —

(
Lang.Dictionary
)

 —

A Dictionary of options

- Can be `null`

- :method — (Communications.HttpRequestMethod) — The HTTP method of the request. This option should be an HTTP_REQUEST_METHOD_* value.
- :headers — (Lang.Dictionary) — A Dictionary of HTTP headers to include in the request The "Content-Type" header for the body of the request can be specified using a REQUEST_CONTENT_TYPE_* value
- This is only valid for methods PUT and POST (you cannot set a body for a GET or DELETE request)
- If the content type is not specified, it will default to "application/json" for GET and DELETE requests, and will default to "application/x-www-form-urlencoded" for POST and PUT requests

responseCallback

 —

(
Lang.Method
)

 —

A reference to a callback method which must accept two arguments:

- responseCode: the server response code
- data: the content if the request was successful, or `null`

_Supported on 163 devices._

**See Also:**

- Communications.makeWebRequest().

**Since:** API Level 1.0.0

### `makeOAuthRequest(requestUrl as Lang.String, requestParams as Lang.Dictionary, resultUrl as Lang.String, resultType as Communications.TokenResult, resultKeys as Lang.Dictionary) as Void`

Request an OAuth sign-in through Garmin Connect Mobile.

A notification will trigger on the phone, that when clicked, provides a web view that shows `requestUrl`. If the user grants permission to the app, then the callback registered by registerForOAuthMessages() will be called with an OAuthMessage from the OAuth response.

Note:

This method can only be used when connected to a mobile device over Bluetooth.

**Parameters:**
- requestUrl — (Lang.String) — The URL to load in the web view to begin authentication
- requestParams — (Lang.Dictionary) — Non-URL encoded parameters for the `requestUrl`
- resultUrl — (Lang.String) — The URL of the final page of authentication that contains the `resultKeys`
- resultType — (TokenResult) — An OAUTH_RESULT_TYPE_* value that specifies the format of the result
- resultKeys — (Lang.Dictionary) — The desired OAuth response values passed to the callback method. The keys map to the actual OAuth response keys, and the values map to the keys of the OAuthMessage data.

**Example:**
```
using Toybox.Communications;
using Toybox.System;

const CLIENT_ID = "myClientID";
const OAUTH_CODE = "myOAuthCode";
const OAUTH_ERROR = "myOAuthError";

// register a callback to capture results from OAuth requests
Communications.registerForOAuthMessages(method(:onOAuthMessage));

// wrap the OAuth request in a function
function getOAuthToken() {
   status = "Look at OAuth screen\n";
   Ui.requestUpdate();

   // set the makeOAuthRequest parameters
   var params = {
       "scope" => Comm.encodeURL("https://www.serviceurl.com/"),
       "redirect_uri" => "https://localhost",
       "response_type" => "code",
       "client_id" => $.CLIENT_ID
   };

   // makeOAuthRequest triggers login prompt on mobile device.
   // "responseCode" and "responseError" are the parameters passed
   // to the resultUrl. Check the oauth provider's documentation
   // to determine the correct strings to use.
   Comm.makeOAuthRequest(
       "https://requesturl.com",
       params,
       "http://resulturl.com",
       Comm.OAUTH_RESULT_TYPE_URL,
       {"responseCode" => $.OAUTH_CODE, "responseError" => $.OAUTH_ERROR}
   );
}

// implement the OAuth callback method
function onOAuthMessage(message) {
    if (message.data != null) {
        var code = message.data[$.OAUTH_CODE];
        var error = message.data[$.OAUTH_ERROR];
    } else {
        // return an error
    }
}
// the OAuth service can now be used with a makeWebRequest() call
```

**Since:** API Level 1.3.0

### `makeWebRequest(url as Lang.String, parameters as Lang.Dictionary or Null, options as { :method as Communications.HttpRequestMethod, :headers as Lang.Dictionary, :responseType as Communications.HttpResponseContentType, :context as Lang.Object or Null, :maxBandwidth as Lang.Number, :fileDownloadProgressCallback as Lang.Method(totalBytesTransferred as Lang.Number, fileSize as Lang.Number or Null) as Void } or Null, responseCallback as Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or Null) as Void or Lang.Method(responseCode as Lang.Number, data as Lang.Dictionary or Lang.String or PersistedContent.Iterator or Null, context as Lang.Object) as Void) as Void`

Initiate a download request.

Web requests are asynchronous. The supplied response callback method will be called when the request returns.

Note:

This method can be used when connected to WiFi or a mobile device over Bluetooth.

**Parameters:**
- url — (Lang.String) — The URL being requested
- parameters — (Lang.Dictionary) — A Dictionary of keys and values. These values should not be URL encoded.
- Can be `null`.

options

 —

(
Lang.Dictionary
)

 —

A Dictionary of options.

- :method — (Communications.HttpRequestMethod) — The HTTP method of the request. This should be an HTTP_REQUEST_METHOD_* value.
- :headers — (Lang.Dictionary) — A Dictionary of HTTP headers to include in the request. The "Content-Type" header for the body of the request can be specified using a REQUEST_CONTENT_TYPE_* value.
- If the content type is not specified, it will default to "application/json" for GET and DELETE requests, and will default to "application/x-www-form-urlencoded" for POST and PUT requests.
- By default, DELETE requests will have their parameters appended to the URL.
- Setting the method as DELETE as well as a "Content-Type" header will result in the parameters being set in the body of the request and they will not be appended to the URL.
- GET requests can only have their parameters appended to the URL, specifying the "Content-Type" header will not set the body.

:responseType

 —

(
Communications.HttpResponseContentType
)

 —

The format of the response.

- This should be an HTTP_RESPONSE_CONTENT_TYPE_* value.
- If HTTP_RESPONSE_CONTENT_TYPE_FIT or HTTP_RESPONSE_CONTENT_TYPE_GPX is given, the system will attempt to download and parse a FIT or GPX file and store the contained data in the device, based on the contents of the file.
- If not given, the system will use the Content-Type header from the server response to determine the format of the response body. If the Content-Type header from the response is not one of the known HTTP_RESPONSE_CONTENT_TYPE_* types, an error will occur.

:context

 —

(
Lang.Object
)

 —

A user-specific context object to be passed to the response callback. The callback will need to accept a third parameter if this value is populated.

:mediaEncoding

 —

(
Media.Encoding
)

 —

The encoding of the audio content that is being downloaded. Should be a Media.ENCODING_* value.

:maxBandwidth

 —

(
Lang.Number
)

 —

maximum bandwidth. TVM will select the audio stream with the highest bandwidth that's less than or equal to the maximum This option is only effective when processing HLS content

:fileDownloadProgressCallback

 —

(
Lang.Method
)

 —

a callback method which must accept two parameters

- totalBytesTransferred: The total number of bytes transferred for the current file download
- fileSize: The size of the file being downloaded. Note that this can be `null` if file size cannot be determined from the server.
- This option is only supported for media file download progress
- This option is supported since CIQ 3.2.0

responseCallback

 —

(
Lang.Method
)

 —

A reference to a callback method which must accept two arguments:

- responseCode: The server response code or a BLE_* error type
- data: The content if the request was successful, or `null`

**Example:**
```
// It is common for developers to wrap a makeWebRequest() call in a function
// as displayed below. The function defines the variables for each of the
// necessary arguments in a Communications.makeWebRequest() call, then passes
// these variables as the arguments. This allows for a clean layout of your web
// request and expandability.
using Toybox.System;
using Toybox.Communications;

   // set up the response callback function
   function onReceive(responseCode, data) {
       if (responseCode == 200) {
           System.println("Request Successful");                   // print success
       }
       else {
           System.println("Response: " + responseCode);            // print response code
       };

   };

   function makeRequest() {
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
       Communications.makeWebRequest(url, params, options, responseCallback);
  }
```

**Since:** API Level 1.3.0

**Throws:**
- (Lang.InvalidOptionsException) — Thrown if a required option for a particular request is omitted
- (Lang.SymbolNotAllowedException) — Thrown if a given :responseType option is not supported for the device the request is being made from. An example would be using HTTP_RESPONSE_CONTENT_TYPE_AUDIO on a device that does not support audio content provider apps

### `notifySyncComplete(errorMessage as Lang.String or Null) as Void`

Send a system notification to indicate that the sync completed.

**Parameters:**
- errorMessage — (Lang.String) — A descriptive error message if a failure occurred. If the sync completes successfully, `null` should be passed to this method.

_Supported on 102 devices._

**Since:** API Level 3.1.0

### `notifySyncProgress(percentageComplete as Lang.Number) as Void`

Send a system notification to indicate overall sync progress.

**Parameters:**
- percentageComplete — (Lang.Number) — An integer from 0 to 100 indicating the completion percentage.

_Supported on 102 devices._

**Since:** API Level 3.1.0

### `openWebPage(url as Lang.String, params as Lang.Dictionary or Null, options as Lang.Dictionary or Null) as Void`

Request that GCM issue a phone notification that will open a web page.

This method will push a phone notification that must be accepted by the user. If the used accepts it, a web page defined by this method will be opened in the default browser on the phone.

Note:

This method can only be used when connected to a mobile device over Bluetooth.

**Parameters:**
- url — (Lang.String) — The URL to open.
- params — (Lang.Dictionary) — The URL parameters used to add to the pages web page URL. Parameters should not be URL encoded.
- options — (Lang.Dictionary) — Additional options for the request

**Example:**
```
using Toybox.Communications;
Communications.openWebPage(
   "http://www.bing.com/images/search",
   {"q" => "cute kitten"},
   null
);
// passes the url: http://bing.com/images/search?q=cute kitten to the
// browser on the phone
```

**Since:** API Level 1.3.0

### `registerForOAuthMessages(method as Lang.Method(data as Communications.OAuthMessage) as Void) as Void`

Register a callback for receiving OAuth messages.

The callback will be called once for each received OAuth message. If there are messages waiting for the app when this function is called, the callback will immediately be called once for each waiting message.

**Parameters:**
- method — (Lang.Method) — A reference to a callback, which must receive a `data` argument of the type OAuthMessage.

**Example:**
```
using Toybox.Communications;

function onOAuthMessage(message) {
    if (message.data != null) {
        var code = message.data[OAUTH_CODE];
        var error = message.data[OAUTH_ERROR];
    } else {
        // return an error
    }
}
Communications.registerForOAuthMessages(method(:onOAuthMessage));
```

**Since:** API Level 1.3.0

### `registerForPhoneAppMessageErrors(method as Communications.PhoneMessageErrorCallback or Null) as Void`

Register a callback for receiving Phone App message errors.

The callback will be called when a message cannot be received. If there are messages waiting for the app when this function is called, the callback will immediately be called.

**Example:**
```
using Communications;

function phoneMessageErrorCallback(err as PhoneAppMessageError) as Void {
   System.println(Lang.format("Error: $1$", [ err ]));
}

// register for message errors where supported
if (Communications has :registerForPhoneAppMessageErrors) {
  Communications.registerForPhoneAppMessageErrors(method(:phoneMessageErrorCallback));
}
```

**See Also:**

- Communications.registerForPhoneAppMessages()

**Since:** API Level 6.0.0

### `registerForPhoneAppMessages(method as Communications.PhoneMessageCallback or Null) as Void`

Register a callback for receiving Phone App messages.

The callback will be called once for each message received. If there are messages waiting for the app when this function is called, the callback will immediately be called once for each waiting message.

**Parameters:**
- method — (Lang.Method) — A reference to a callback, which must receive a `data` argument of the type PhoneAppMessage.

**Example:**
```
using Communications;

function phoneMessageCallback(msg as PhoneAppMessage) as Void {
   System.println(Lang.format("Data: $1$", [ msg.data ]));
}

// register for messages
Communications.registerForPhoneAppMessages(method(:phoneMessageCallback));
```

_Supported on 151 devices._

**See Also:**

- Toybox.Communications.PhoneAppMessage
- Communications.registerForPhoneAppMessageErrors()

**Since:** API Level 1.4.0

### `setMailboxListener(listener as Lang.Method(mailboxIterator as Communications.MailboxIterator) as Void) as Void`

 **This has been deprecated**

This method may be removed after System 4.

Add a listener for mailbox events.

The listener method is called whenever a new message is received.

**Parameters:**
- listener — (Lang.Method) — A reference to a callback method which must accept an iterator. The iterator is the mailbox iterator for the app

_Supported on 139 devices._

**See Also:**

- Communications.registerForPhoneAppMessages()

**Since:** API Level 1.0.0

### `startSync() as Void`

Exit the AppBase and launch it in sync mode.

_Supported on 102 devices._

**Since:** API Level 3.1.0

### `startSync2(options as { :message as Lang.String } or Null) as Void`

Exit the AppBase and launch it in sync mode with the provided message.

**Parameters:**
- options — (Lang.Dictionary) — a dictionary of options, can be null :message — (Lang.Number) — the sync message to display

_Supported on 61 devices._

**Since:** API Level 4.0.4

### `transmit(content as Communications.TransmitType, options as Lang.Dictionary or Null, listener as Communications.ConnectionListener) as Void`

Send data across the the BLE link.

Support for transmittable types has been expanded over time.

- ByteArray (Since 6.0.0)

**Parameters:**
- content — (Communications.TransmitType) — The object to be sent
- options — (Lang.Dictionary) — Additional transmit options for future proofing. For now, an empty Dictionary is used.
- listener — (Communications.ConnectionListener) — An extension of the ConnectionListener class

_Supported on 152 devices._

**Since:** API Level 1.0.0
