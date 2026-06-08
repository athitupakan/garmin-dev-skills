---
source: https://developer.garmin.com/connect-iq/core-topics/publishing-to-the-store/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Publishing_to_the_Store.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Publishing to the Connect IQ Store

We're glad you want to develop for Garmin devices, and we want you to be successful. Be sure to review our guidelines and keep them in mind as you develop your apps.

Once your apps are fully tested and ready to go, you can publish and promote your apps to the Garmin Connect IQ App Store. Here's how to prepare your apps for submission.

1. Make sure the manifest file specifies all products supported by the app
2. Use the *Monkey C: Export Project* command to generate an IQ file, which will contain binaries for each supported device
3. Upload the app to the App Store

## Check Supported Products

It is easy to quickly check the products supported by an app by viewing the manifest XML file in the project root:

```
<iq:products>
    <iq:product id="fenix3"/>
    <iq:product id="vivoactive"/>
    <iq:product id="fr920xt"/>
    <iq:product id="epix"/>
</iq:products>
```

## Exporting the App

Launch the Export Wizard with the *Monkey C: Export Project* command in the command palette. After setting the export destination folder the Monkey C extension will generate the `.iq` file of your project.

## Publishing the First Version

To upload the IQ file to your developer account, start by visiting the Submit an App page of the Garmin Developer site. Click on the *Submit an App* button to fill out the form shown below:

Once the IQ file has been validated, add in a description, screen shots, and other details about your app:

## GDPR

In April of 2016, the EU Parliament passed the General Data Protection Regulation (GDPR), an act that was designed to harmonize data privacy laws across the European Union (EU). The GDPR provides requirements for the lawful processing of EU Personal Data, including requirements related to data privacy, consent, and digital services. GDPR generally applies to the processing of EU Personal Data, and it may apply to you or your company even if you are not in the EU. Data protection authorities may issue fines up to 4% of annual global turnover or €20 Million, whichever is greater, for non-compliance. . This isn't legal advice and we encourage you to consult with your legal counsel for guidance.

Connect IQ is a global platform, and, as stated in the Connect IQ license agreement, developers are responsible for their apps' compliance with all applicable laws, including those related to data protection and privacy. Specific responsibilities related to privacy can be found in Section 2 of the Connect IQ license agreement. Developers should review the GDPR to determine what obligations they may have under the GDPR. These obligations may include the following:

- Asking for consent for collection of personal data.
- Providing access to information on what personal data concerning them is being processed, where and for what purpose.
- Providing access to any personal data collected from them free of charge.
- Ability for a user to erase their presence entirely within your product, including the ability to halt third party processing of personal data.

If your solution collects personal data in any way, including using the `Communications` permission to collect or retain personal data (potentially in conjunction with `Sensor`, `Sensor History`, or `Position` permissions) or using any other mechanism, you are responsible for ensuring that your solution is in compliance with GDPR.

## Approval Process

After your app is successfully uploaded to the app store, the Connect IQ team will review your submission. Aside from special circumstances, such as national holidays, reviews are completed within 72 hours.

If you indicate your app uses one or more ANT+ profiles, an additional 48 hours is typically required to complete ANT+ certification. Once certification is complete, we'll provide ANT+ branding information and a link to the ANT+ Directory to add to your app's description on the store.

While approval is pending, your app will not appear on the Garmin Connect App Store, but you will be able to preview your app and download it yourself for testing. Once it's approved, you will receive a notification and it will appear on the Connect IQ App Store for all users to download and load to their devices!

If for some reason your app is rejected, don't despair! The Connect IQ team will provide specific reasons for the rejection via email, and may work with you to resolve issues. The app will continue to be available for you to update as needed and re-submit for approval, but it will not be displayed on the Connect IQ App Store until approved.
