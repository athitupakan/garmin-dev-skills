---
source: https://developer.garmin.com/connect-iq/user-experience-guidelines/menus/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/User_Experience_Guidelines/Menus.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Menus

The app can create a menu with a default presentation style that matches the device’s look and feel. If you want to match your branded look and feel, you can use a custom menu instead.

By default, menus loop from the last element on the list back to the first but can also continue into a new menu. If you have a very long list of options, consider ways to sort in a predictable and meaningful way, such as alphabetically. Or consider grouping into related categories. Users would then see the category name in the parent menu, and then can select a “parent” option to see the options in a “child” menu.

## Selection Menu

Use the selection menu when there is a selectable list of items for the user to navigate. A header and footer at the top and bottom of the menu can give context to the selection.

Optional use of icons or images is recommended to highlight the meaning of the selection:

For graphic guidance, including the use of color, fonts and icons, see the Product Design Appendix.

## Settings Menu

Typically, a menu behavior from the base page will provide access to a settings menu. Settings menus allow users to customize global settings within your application. A header and footer at the top and bottom of the menu can give context to the selection.

For graphic guidance, including the use of color, fonts and icons, see the Product Design Appendix.

## Best Practices

- Group menus into categories as needed. A general rule of thumb is to try to have a maximum of seven items in each list.
- Use toggles for options with on/off choices in settings menus.
- Use checkboxes for multiple selections in settings and selection menus.
- For other selections, provide a secondary menu for users to see all their choices. Show the current selection as subtext in the parent menu list item.
- A common pattern to break up long sets of information is to draw a custom footer element that hints at what lies beneath, and then switch to a new menu if the user goes past the end.
