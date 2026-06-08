---
source: https://developer.garmin.com/connect-iq/personality-library/personality-ui/
sdk: 9.1.0
fetched: 2026-05-30
generated: auto-converted from SDK doc/docs/Personality_Library/Personality_UI.html via _refresh/htmlmd.js — faithful mirror, not hand-curated
---

# Personality UI

Each Garmin® product has a unique device personality. This personality can be a combination of the industrial design, the screen technology, the inputs available, and the graphic styling of the system software. While there are often common components and patterns across Garmin products, the device personality alters how the user interfaces with those components. This makes it difficult for developers to make apps that feel native to the device.

The goal of Personality UI is to help you navigate these design variations by providing a style system to adapt your design language to Garmin devices, along with a set of reusable components for your apps.

## Monkey Style

Monkey style is a domain-specific property language for managing style elements. It borrows heavily from CSS, but has been tailored for Monkey C. Monkey C allows developers to create style property constants that can adapt among different Garmin products.

## Personality Components

The personality components are a library of assets and monkey style definitions you can build upon when creating your apps.

## How to Read this Guide

The components outlined in this guide use a combination of the resource system, Toybox.WatchUi classes, and personality selectors. Each component has a set of examples that outlines how to create it. The sample code examples are broken down with the headers listed below.

| Header | Explanation |
| --- | --- |
| `layout.xml` | Belongs in the layouts portion of your resource definitions. |
| `menus.xml` | Belongs within the menus element of your resource definitions. |
| `InputDelegate.mc` | Belongs in your input handler implementation. |
| `View.mc` | Belongs in your view implementation. |

## Component Overview

| Chapter | Description |
| --- | --- |
| Colors | Learn how colors are expressed in the design system. |
| Iconography | Integrate system iconography into your app. |
| Typography | Choose the appropriate font. |
| Input Hints | Provide visual guidance to users for actions. |
| Prompts | Provide textual information to the user. |
| Confirmations | Ask the user if they want to proceed. |
| Toasts | Provide a small status update. |
| Action Views | Create pages with interactive information. |
| Page Loops | Break information across multiple pages. |
| Progress Indicators | Give the status of a long-running action. |
