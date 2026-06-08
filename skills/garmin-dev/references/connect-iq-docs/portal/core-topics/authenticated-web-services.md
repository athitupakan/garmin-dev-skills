---
source: https://developer.garmin.com/connect-iq/core-topics/authenticated-web-services/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Authenticated_Web_Services.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Authenticated Web Services

There are countless web services available to developers that use either OAuth to provide access control. Connect IQ has OAuth APIs in the **Communications** module that allow widgets and device apps to make authenticated calls.

## OAuth 101

OAuth provides a standard way for developers to authenticate to gain access to web APIs. Before an app can access the web API, the developer must register the app with the service. During registration you must provide a redirect URL that will be used to retrieve the credentials. Once registered the app will provide a *client id* and *secret*, which are necessary for the login process.

To access the web service, the app must authenticate the user. To do this, the app redirects the user's web browser to the web service authentication page, providing the secret, the client id, and the redirect URL. After the service has authenticated the user, it redirects their browser back to the client providing an access token. The access token can then be used in subsequent calls to the web service.

## OAuth and Wearables

The OAuth standard is based on the world of web browsers and mobile applications, but in general people don't want to enter their username and password on their watch. Connect IQ has added some new APIs to allow you to write OAuth enabled apps:

| Operation | Function | API Level |
| --- | --- | --- |
| Request credentials from an OAuth 2.0 web endpoint | Communications.makeOAuthRequest() | 1.3.0 |
| Request credentials from an OAuth 2.0 web endpoint | Authentication.makeOAuthRequest() | 3.3.0 |
| Register a callback to receive OAuth credentials upon user completion | Communications.registerForOAuthMessages() | 1.3.0 |
| Register a callback to receive OAuth credentials upon user completion | Authentication.registerForOAuthMessages() | 3.3.0 |

The Communications.makeOAuthRequest() and Authentication.makeOAuthRequest() calls are intended for implementing credential entry step of the OAuth 1.0 & 2.0 standard. Be sure to use the following redirects when using the `makeOAuthRequest` call:

| API | Redirect |
| --- | --- |
| Communications.makeOAuthRequest() | `http://localhost` |
| Authentication.makeOAuthRequest() | `connectiq://oauth` |

When called, the user will receive a phone notification that your app wants to log into a web service. Clicking on this notification will take the user to a web view within Garmin Connect mobile app (`Communications.makeOAuthRequest()`) or the Connect IQ Store mobile app (`Authentication.makeOAuthRequest()`), where they can enter their log in information.

During this time, the Connect IQ app should display a page directing the user to open the respective application. Once the user has completed credential entry, Connect will send back the tokens specified in the `resultKeys` option, and direct them back to the wearable.

Your app should call Communications.registerForOAuthMessages() or Authentication.registerForOAuthMessages() to receive the result of the login process. Logging in can take a long time, and a widget may time out before the user completes the login step. If your app closes before the login process completes, the result will be cached on the device until the next time your app calls Communications.registerForOAuthMessages(), at which point the result will be passed to your callback immediately. Once you have the access token, you can use it as an argument to Communications.makeWebRequest().
