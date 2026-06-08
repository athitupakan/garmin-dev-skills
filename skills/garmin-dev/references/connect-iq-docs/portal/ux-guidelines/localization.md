---
source: https://developer.garmin.com/connect-iq/user-experience-guidelines/localization/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/User_Experience_Guidelines/Localization.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Localization

Garmin devices are available all over the world, and Connect IQ is a global marketplace. A single Connect IQ product may have different localized variants that support different languages or may have languages that have different character sets. Connect IQ allows a single device app to accommodate all of these variations.

The Connect IQ tools allows for application resources, including text and graphics, to be overridden based on language. The following languages are supported:

- Arabic
- Bulgarian
- Czech
- Danish
- German
- Dutch
- English
- Estonian
- Finnish
- French
- Croatian
- Hungarian
- Indonesian
- Italian
- Japanese
- Korean
- Latvian
- Lithuanian
- Norsk Bokmål
- Polish
- Portuguese
- Slovak
- Slovenian
- Spanish
- Swedish
- Russian
- Romanian
- Thai
- Turkish
- Ukrainian
- Vietnamese
- Standard Malay
- Simplified Chinese
- Traditional Chinese

When developing a Connect IQ app, you should consider what is necessary to adapt your app for other countries and languages.

## Best Practices

- All Connect IQ devices support English, but not all devices support all languages. Supporting only English is not a localization strategy.
- Garmin devices allow the user to customize their preferred units for distance, elevation, height, pace, temperature and weight. Look at their preference before displaying any metric of those types.
- Leave enough space for translated text. The height and width of the text may expand or contract based on which language is displayed. The Connect IQ simulator can be used to test your text in multiple languages.
- Use iconography when possible, but be cautious about the cultural significance of images and colors in different cultures.
- Support multiple presentations of the date based on locale.
- Avoid text entry steps when possible.
