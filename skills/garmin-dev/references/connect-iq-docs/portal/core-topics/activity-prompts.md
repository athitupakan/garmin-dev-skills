---
source: https://developer.garmin.com/connect-iq/core-topics/activity-prompts/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Core_Topics/Activity_Prompts.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Activity Prompts

*Since API 5.2.0*

The Toybox.ActivityPrompts module allows for a data field to intercept and suppress the voice prompts of an activity. This can be used to integrate a device with its own text-to-speech (TTS) engine with the activity experience.

When installing an app that uses the Toybox.ActivityPrompts API, the user will be presented with a confirmation asking if they agree to allow the app to control the voice prompts. The user can always select the app as the audio prompts handler either in the audio prompts menu or through device settings. Note that not all devices have an on-device audio prompts menu.

You can call ActivityPrompts.registerActivityPromptsListener() to register your app to handle activity prompts. This call will return true if the user has selected your app to handle activity prompts. If the user chooses to enable or disable your apps’ handling of activity prompts during the activity, your ActivityPromptDelegate.onAudioOutputChange() delegate function will be called with the status change.

When active, your ActivityPromptDelegate.onPrompt() will be passed an ActivityPrompt object when the user triggers lap, workout and other audio prompts. The ActivityPrompt.text will contain a TTS-friendly string in the current language. You can use to change the language of the text string. This will return `false` if the language is not supported. Calling does not change the system language.

If your external TTS engine is not available, calling ActivityPrompts.unregisterActivityPromptsListener() will disable the audio prompt handler. The device will fall back to the system audio prompt handler.

These APIs require the `ActivityPrompts` permission:

| Function or Class | Purpose | API Version |
| --- | --- | --- |
| ActivityPrompts.registerActivityPromptsListener() | Register a as the activity prompt output provider | 5.2.0 |
| ActivityPrompts.setActivityPromptTextLanguage() | Set the language for ActivityPrompt.text | 5.2.0 |
| ActivityPrompts.unregisterActivityPromptsListener() | Unregister as the activity prompt output handler | 5.2.0 |
