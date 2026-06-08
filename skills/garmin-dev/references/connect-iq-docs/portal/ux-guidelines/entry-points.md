---
source: https://developer.garmin.com/connect-iq/user-experience-guidelines/entry-points/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/User_Experience_Guidelines/Entry_Points.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Entry Points

Connect IQ exposes multiple ways for developer content to integrate with the device. Based on the app type, there may be multiple touchpoints where your app will appear. Here is a comprehensive list:

**Activity Data Field Screen** (*Data fields*) – In native Garmin activities, the user has a page loop of metrics available to them. Users can edit the contents of the pages for the activity. One option is to add a Connect IQ data field as a metric in a page. Once added, the data field can render itself inside of its designated area.

On API level 3.2 products and above, the user can configure settings for the data field on the device. This launches into an application-defined workflow.

**Activity List** (*Device apps*) – From the home page of the device, the user can get to the list of supported activities either by pressing the start button or tapping the appropriate place on the touchscreen. Connect IQ apps are listed along with the natively supported Garmin activities. The user can edit the list order on device or in the Garmin Connect mobile app.

When a user launches an app from the activity list, the app will run until the user explicitly backs out from the first page.

**Glance List** (*Device apps, Widgets*) – Glances are an evolution of the widget concept. The information of a widget is condensed into a glanceable item, and the collection is presented to the user as a list. Selecting an item from the list launches into the experience. The user can exit by backing out of the base page, but after a period of inactivity, the system will terminate the launched app, as well.

On API level 3.1 products, widgets were the only app type to support glances. In API level 4.0, device apps were given the ability to support glances, as well.

**Media Player** (*Audio content providers*) – On products that support music, users can select a music source. The source can be music files on the device, controlling the music player on their phone or music from the audio content provider’s app.

When the user switches to a Connect IQ audio content provider, the initial view is displayed. This gives an opportunity to provide onboarding, including authenticating into a cloud service and guiding the user to download music. When the user returns to the media player, they will get the media controls and have a way to return to your interface if they want to change playlists or download more content.

**Watch Face** (*Watch faces*) – On Garmin wearables, the user can choose a watch face to run as the home screen, including installed Connect IQ watch faces. When the user returns to the home screen, the watch face application will launch. The watch face does not take user input.

Watch faces render in different ways based on what the device supports:

- *MIP standard **–*** The watch face will request an update every minute. When the user gestures to look at the watch face, the watch face will begin requesting updates every second for a short period.
- *MIP always active **–*** The watch face will request a full update every minute but will allow a small portion of the screen to be updated every second. When the user gestures to look at the watch face, the watch face will begin requesting updates every second for a short period.
- *AMOLED standard **–*** The screen is off by default. When the user gestures to look at the watch face, the display will enable, and the watch face will begin requesting updates every second for a short period.
- *AMOLED always active (version 1)* – The watch face operates with a burn-in detection mechanism that will prevent any pixel from being enabled for more than four minutes, or for the watch face from using more than 10% of the screen pixels. When the user gestures to look at the watch face, the display will turn on, the pixel limits are disabled, and the watch face will begin requesting updates every second for a short period.
- *AMOLED always active (version 2)* - The watch face is prevented from using more than 10% of the screen pixels. When the user gestures to look at the watch face, the display will turn on, the pixel limits are disabled, and the watch face will begin requesting updates every second for a short period.

**Widget Loop** (*Widgets*) – On wearables that have widgets, the widget loop is available by performing the next/previous behavior from the watch face. On cycling computers, the widget loop is available by swiping down from the top of the screen, then swiping right or left or using the navigation arrows to move between widget pages.

The user can use the next/previous behaviors to navigate the widget loop if the widget is on the base page. Other interactions can be captured by the widget and used to push pages onto the page loop. After a period of inactivity, the widget will be terminated, and the user will return to the home screen.

## Best Practices

- When designing a widget, make sure to design both a launch from widget (full screen) and launch from glance (list item to full screen).
- When launching from a glance, the base page of your widget/app will not have the input restrictions when launching as a widget.
- On certain devices, device apps can be launched from a glance. If your app has a trackable metric, consider creating a glance for it.
