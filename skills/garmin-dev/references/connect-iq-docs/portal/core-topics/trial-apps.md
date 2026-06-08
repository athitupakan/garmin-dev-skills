---
source: https://developer.garmin.com/connect-iq/core-topics/trial-apps/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Trial_Apps.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# App Trials

*Since API level 2.3.0*

The app trials feature allows developers to enable a special "trial" mode for their app. Enabling trial mode is accomplished by adding a new tag to the manifest under the application tag as follows:

```
<iq:application entry="CommExample" id="a3421feed289106a538cb9547ab12095"
        name="AppName" launcherIcon="LauncherIcon" type="widget" minSdkVersion="1.3.1">
    <iq:trialMode enable="true">
        <iq:unlockURL>https://a.custom.unlock.url.info</iq:unlockURL>
    </iq:trialMode>
</iq:application>
```

The unlock URL provides an endpoint for the app store to redirect the user to in order go through whatever you want your app "unlock" process to be. The app store will only accept secured HTTPS-URLs when uploading your iq-file. Also make sure that the enable-attribute of the `trialMode` tag is set to "true".

The app trials feature is not supported for watch faces.

## Trial Mode Functionality

Developers can query the AppBase.isTrial() method to determine if trial mode is active for their app, which can be used to trigger special trial-mode functionality. App trials can also be time-based. The method AppBase.getTrialDaysRemaining() should be overridden if you wish to support a time-based trial. AppBase.getTrialDaysRemaining() must return a Lang.Number that represents how many days are remaining in the trial, or null if time-based trials are to be disabled. If `0` is returned, the app will be prevented from running as the trial will be considered "expired".

By default, when an app is in trial mode, the system will push special trial notifications to the use either to inform them of how many days remain in their trial (if you've overridden AppBase.getTrialDaysRemaining() to return a non-null value), or more generally that trial mode is active. If you do not wish for these notifications to be displayed to the user, you can override to return `false`.

## Trial App Server API

Once the app is available in the store, the user can unlock the app by clicking on the unlock button in the store. At this point, the app store will redirect to the provided unlock-URL, adding these parameters to the URL:

| Parameter Name | Description |
| --- | --- |
| `callbackUrl` | The URL that has to be called back when the unlock-process on your side successfully finished. |
| `appUnlockRequestId` | The app store's internal unlock-ID which can be stored by the app-developer as reference. |
| `appPageUrl` | The app details page of the app to be unlocked. You should redirect to this page after a successful call to the callback-URL, and ask the user to download the unlocked app for his desired device. |

So this is what a typical/complete call from the app store to your unlock-URL will look like:

```
https://your.unlock.url.com?appUnlockRequestId=1fe443e5-e76c-4e1c-b82b-2d084bd4c4fe
    &callbackUrl=https%3A%2F%2Fapps.garmin.com%2FappUnlock%3FappUnlockRequestId%3D1fe443e5-e76c-4e1c-b82b-2d084bd4c4fe
    &appPageUrl=https%3A%2F%2Fapps.garmin.com%2Fen-US%2Fapps%2Fbf1d944a-8a54-41fa-b7b0-24e651dc88e1
```

Both the `callbackUrl` and the `appPageUrl` will be passed in URL-encoded form.

## How to use the `callbackUrl`

The `callbackUrl`-endpoint is secured and can only be used with a (one-legged) OAuth1-signed request.

For this you'll need to obtain your individual set of key/secret credentials from the app store's "Developer Dashboard":

With these credentials you simply create a standard OAuth1-request and fire it to the callback-URL. (Using a framework which generates all the necessary OAuth-HTTP-Headers is recommended.)

A straightforward Java example (using the Signpost-library, and Apache's HttpClient) would look like this:

```
HttpGet request = new HttpGet("callbackUrl");

OAuthConsumer consumer = new CommonsHttpOAuthConsumer("yourKey", "yourSecret");
consumer.sign(request);

HttpClient client = HttpClientBuilder.create().build();
HttpResponse response = client.execute(request);

System.out.println("Return code: " + org.springframework.http.HttpStatus.valueOf(response.getStatusLine().getStatusCode()));
```

The following return-codes can be expected:

| Status Code | Status Phrase | Description |
| --- | --- | --- |
| 200 | OK | Everything worked just fine; the app got marked as "unlocked" for the user. |
| 202 | Accepted | When making a successful test-request (see below). |
| 401 | Unauthorized | When the authorization (OAuth) was incorrect. |
| 404 | Not Found | When the requested unlock item was not found. |
| 409 | Conflict | When an app is already being marked as unlocked in the app store. |
| 410 | Gone | When an app is orphaned (e.g. because the app changed ownership due to GDPR). |
| 510 | Internal Server Error | When an unexpected error occurred. |

You can test your OAuth-implementation without the need of an actual unlock-request.

Just make a signed call using your credentials and "test" as `appUnlockRequestId`.

```
https://apps.garmin.com/appUnlock?appUnlockRequestId=test
```

When receiving a 202, you can be sure that your OAuth-handling is working.
