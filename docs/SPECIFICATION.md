# Simple Calendar Widget - Specification

## Overview

A macOS widget for Desktop / Notification Center that displays a single month calendar view. Designed to be used standalone or as a set (e.g., three widgets showing previous, current, and next month).

## Platform

- **Target**: macOS (WidgetKit - Notification Center / Desktop)
- **Size**: Small widget (`.systemSmall` — two fit side-by-side in the Notification Center)
- **Framework**: SwiftUI + WidgetKit

## Layout

From top to bottom:

1. **Month name** — displayed prominently at the top (e.g., "February")
2. **Year** — displayed below the month name, same font as the day numbers (e.g., "2026")
3. **Day-of-week headers** — abbreviated labels (e.g., Su, Mo, Tu, We, Th, Fr, Sa)
4. **Day grid** — 7 columns (one per day of the week), up to 6 rows of day numbers

## Day Grid Rules

- Days of the current month are displayed normally
- **Today's date** is visually highlighted (e.g., circle, bold, or accent color) when viewing the current month
- **Adjacent month days** (days from previous/next month that fill the grid) are shown in a lighter/grayed-out style
- Grid always has 7 columns; rows vary by month (4–6 rows)

## Configuration (Widget Edit UI)

| Setting | Type | Default | Range |
|---|---|---|---|
| **Start day of week** | Picker | Sunday | Sunday through Saturday |
| **Month offset** | Integer stepper | 0 (current month) | -12 to +12 |

- **Start day of week**: Determines which day appears in the first column of the grid
- **Month offset**: Shifts the displayed month relative to the current month. Examples: `-1` = previous month, `0` = current month, `+1` = next month

## Theming

- Supports **light and dark mode** automatically, following the system appearance
- Uses system-appropriate colors and contrasts for both themes

## Example Use Case

A user places three small widgets on their desktop:

| Widget 1 | Widget 2 | Widget 3 |
|---|---|---|
| Month offset: -1 | Month offset: 0 | Month offset: +1 |
| Previous month | Current month | Next month |
