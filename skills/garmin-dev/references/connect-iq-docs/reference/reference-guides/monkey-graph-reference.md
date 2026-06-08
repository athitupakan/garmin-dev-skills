---
source: https://developer.garmin.com/connect-iq/reference-guides/monkey-graph-reference/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Reference_Guides/Monkey_Graph_Reference.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Monkey Graph Reference

We can use the Monkey Graph tool to create a preview of data recorded in an activity. The Monkey Graph tool requires the following:

1. A FIT file with the recorded developer data
2. An IQ file of the app (you can acquire an IQ file via the App Export Wizard).

The tool will allow you to test how charts will look before uploading your app for review.

There are two ways that you can use the Monkey Graph tool included with the SDK:

## Launching the Monkey Graph tool in Visual Studio Code:

1. Summon the command palette
2. Select *Monkey C: Open Monkey Graph*

This launches a new window for the Monkey Graph tool.

## Launching the Monkey Graph tool with the command line:

You can start the Monkey Graph tool with following from the command line:

```
$ monkeygraph
```

## Using the Monkey Graph tool:

1. Click on "File"

1. Click "Open IQ File"
2. Select the IQ File generated from your project
3. Click "Open FIT File"
4. Select the Fit file with the recorded developer data

A new view will launch a graph showing the data:

And here we see some secondary data on another page:
