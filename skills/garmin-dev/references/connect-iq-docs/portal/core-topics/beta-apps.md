---
source: https://developer.garmin.com/connect-iq/core-topics/beta-apps/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Beta_Apps.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Beta Apps

Connect IQ beta apps allows developers to test app settings and Garmin Connect integration in production without releasing the app.

Uploading a beta app will let you stage your app in production. To use this feature, you will need to create an alternate app id in your manifest using a UUID creator. Beta apps will show up in your uploaded apps, and you can download them to your Garmin device. Once downloaded you can edit app settings in Garmin Connect and Garmin Express and test your developer fields in Garmin Connect. After you upload the beta app, you can update the beta version as many times as you want. When you are ready to release the app, change the app id to your production version in the manifest and upload it without checking the "Beta App" checkbox. Note that the app will have a separate store identifier from your final app, and URLs to the beta will not be visible outside of your account.
