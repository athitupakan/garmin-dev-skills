---
source: https://developer.garmin.com/connect-iq/core-topics/exception-reporting-tool/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Exception_Reporting_Tool.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Error Reporting Application (ERA)

The ERA tool can be used to view your app's crashes after it has been released on the store. If your app crashes on a device the error report will be collected and aggregated by the ERA server. These reports can be viewed for up to 30 days after a crash occurs. This tool is available in the bin folder of the SDK.

## Getting Started

To launch the graphical ERA tool, either run the *Monkey C: Start ERA Viewer* command from the command palette of Visual Studio Code or use the Command Line. When first running the tool, the *Login Prompt* window will appear asking you to log in to your developer account. Once you have completed the login process, the list of apps will download and the app selection list will be populated.

### Command Line

You can launch the Graphical ERA tool from the command line by simply running `java -jar era.jar` inside the **bin** folder of your current SDK.

The ERA tool can also retrieve crash reports for a single app directly from the command line by running the `era` command inside the **bin** folder of your current SDK. This will output the crashes for the given app in a JSON format. Note that the first time you launch the ERA tool via either method mentioned above, you may be prompted to log in to your developer account if you've not done so previously.

```
> era [-a <arg>]
```

| Argument | Definition |
| --- | --- |
| `-a ` | The app UUID to retrieve crashes for |
| `-h` | Prints help text |

## Viewing App Settings

The Manage Apps window allows you to see the apps associated with your developer account. You can launch this window by selecting **Settings > Manage Apps** in the menu. The list of apps is color coded to allow easy identification of an app's status.

| Font Style | App Status | Crashes Viewable |
| --- | --- | --- |
| Normal | Released app | Yes |
| Gold | Beta app | Yes |
| Strikethrough | App is hidden | No |

In this window you can rearrange the apps and change an app's settings. To rearrange the order of the apps, click on an app and click on the **∧** or **∨** buttons. The order of the apps in this window are reflected in the app selection box in the crash report view. To change an app's settings choose the app in the list and click on the **i** button.

In the Application Settings window you can hide the app from the drop down box in the crash report view. If the **Hide this app** box is checked then the app will not be shown in the crash report view app list.

## Viewing Crash Reports

The crash report view allows you to view all uploaded crash reports for an app in the last 30 days. At the top of this window you can select which app's crash reports to view. After selecting an app the latest reports will be downloaded from the server. In the left pane of the window a list of crash reports will be shown. Each unique crash will be identified by file name, function, and line number where the crash occurred. Choosing a crash in the left pane causes the details for the crash to be shown in the right pane. At the top of the right pane the **Fixed** checkbox can be used to indicate that this particular crash has been fixed. The fixed status will persist across application runs and SDK upgrades. You can change the sort order of the crash reports you are viewing by changing the value in the **Sort By** selector.

| Font Style | Crash Status |
| --- | --- |
| Normal | Crash has been viewed. |
| Bold | Crash has not been viewed. |
| Strikethrough | Crash has been marked as fixed. |
