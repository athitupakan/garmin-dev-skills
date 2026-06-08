---
source: https://developer.garmin.com/connect-iq/core-topics/requesting-reviews/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Requesting_Reviews.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Requesting Reviews

As a developer, you want your users to review your apps after they've had positive experiences. Ideally this would be a low-friction experience to maximize the number of users who leave positive reviews.

For compatible devices, the steps to leave a review are as follows:

- Request a review token
- Receive a token from the store
- Initiate the review process

## Requesting a Review Token

To prevent user harassment, apps must request permission from the app store to perform a review request. The app store validates a number of factors, including if you have recently requested a review from a user and if the user is using the most recent version of the app. The token request can be made with the WatchUi.makeReviewTokenRequest() call. This call is asynchronous, and you must provide this call with a Lang.Method callback to capture the response.

## Receiving the Token

When the server responds to your review request, your callback will be invoked with the server response code and optionally the review tokens. The response codes are as follows:

| Response | Description | API Level |
| --- | --- | --- |
| REVIEW_REQUEST_STATUS_GRANTED | Request is granted, and token has been provided | 4.2.0 |
| REVIEW_REQUEST_STATUS_DENIED | User does not meet review requirements | 4.2.0 |
| REVIEW_REQUEST_STATUS_FAILED | Cannot make review request at this time | 4.2.0 |

If you receive a token it should be valid for the current day.

## Requesting the Review

When you are ready for the user to review the app, you can use WatchUi.startUserReview() with the valid token from a token response. This will transition the user to the review flow.

## Tips

Keep track of the user's positive and negative experiences, and request reviews only if the user is having a net positive experience with the app. Harassing the user to leave positive reviews can lead them to leave negative reviews, which defeats the purpose of asking them to review your app.
