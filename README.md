# WeatherApp

A **SwiftUI** + **SwiftData** iOS application that allows users to search for cities, view detailed weather information, and persist saved cities locally.

## Overview

**WeatherApp** demonstrates:

- **Real-time autocomplete** for city names using [WeatherAPI.com’s Search endpoint](https://www.weatherapi.com/docs/).  
- **Current weather details** (temperature, condition icon, humidity, UV index, and feels-like temperature).  
- **Local persistence** of cities with **SwiftData** (iOS 17+).  
- A straightforward **MVVM** architecture, with SwiftUI for the UI layer.

## Requirements

- **Xcode 15** or later (because of SwiftData).  
- **iOS 17** Deployment Target.  
- A valid **WeatherAPI** key (free tier is sufficient).

## Setup & Installation

1. **Clone** the repository:
   ```bash
   git clone https://github.com/YourUsername/WeatherApp.git
   
2. **Open** the project in Xcode 15 or later:
   ```bash
   cd WeatherApp
   open WeatherApp.xcodeproj
   
3. **Insert** your API Key:
    In WeatherAPIService.swift, replace the placeholder (e.g., SUA_API_KEY_AQUI) with your WeatherAPI key.

4. **Run** on an iOS 17 simulator or device.

# USAGE

1. **Launch the app**.
2. **Search for a city in the top Search Bar**:
  - Type a few letters; autocomplete suggestions appear.
  - Tap one suggestion to navigate to the City Detail screen.
3. **City Detail screen:**
  - Shows current weather data (icon, temperature, humidity, UV, etc.).
  - Tap “Save City” to store it locally.
4. **Home Screen:**
  - When the search bar is empty, you see Saved Cities.
  - Tap a saved city to revisit its details.
  - Swipe to delete any saved city you no longer need.

# API Integration
This project integrates with WeatherAPI.com to fetch:
  - **Autocomplete** (search.json): returns potential matches for partial queries.
  - **Current Weather** (current.json): given a city name (or lat/lon), returns weather details.
**Endpoints:**
  - **GET** https://api.weatherapi.com/v1/search.json?key=YOUR_API_KEY&q=QUERY
  - **GET** https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=QUERY

# SwiftData & Architecture
  - A SavedCity model is declared with @Model.
  - ModelContainer is initialized in the App and provided via .modelContainer(...).
  - A single ViewModel handles:
    - Autocomplete fetches (real-time suggestions).
    - Current Weather fetches (to display city details).
    - Local persistence of saved cities (using SwiftData).
  - @Published properties keep the UI reactive.
  - All UI is built with SwiftUI following MVVM separation of concerns.
