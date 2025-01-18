WeatherApp
A SwiftUI + SwiftData iOS application that allows users to search for cities, view detailed weather information, and persist saved cities locally.

Table of Contents
Overview
Key Features
Architecture
Requirements
Setup & Installation
Usage
API Integration
SwiftData Persistence
License
Overview
WeatherApp is an iOS project demonstrating:

Real-time autocomplete for city names using WeatherAPI.com’s Search endpoint.
Current weather details, including temperature, humidity, UV index, and an icon representing the weather condition.
Local persistence of saved cities via SwiftData, so users can revisit them quickly.
A clean, modern user interface built in SwiftUI.
Key Features
Search Bar with Autocomplete

As the user types, the app queries the WeatherAPI to display matching city suggestions.
City Detail Screen

Displays up-to-date weather information:
Temperature
Condition icon
Humidity
UV index
“Feels like” temperature
Offers a button to Save the city locally.
Saved Cities

Maintains a list of previously saved cities (persisted using SwiftData).
Users can delete saved entries as needed.
Keyboard Dismissal & Minimalist UI

Tapping outside the text field dismisses the keyboard.
The app uses a transparent List style to keep the UI clean and focus on the content.
Architecture
SwiftUI for all UI layers.
SwiftData (iOS 17+) for local persistence.
Combine for reactive network calls (optional, if used).
MVVM pattern to separate UI (Views) from business logic (ViewModels).
Folder Structure (example):

scss
Copiar
WeatherApp
├─ Models/
│   ├─ SavedCity.swift
│   └─ (Other model files)
├─ ViewModels/
│   ├─ WeatherViewModel.swift
│   └─ (Others, if needed)
├─ Views/
│   ├─ HomeView.swift
│   ├─ CityDetailView.swift
│   ├─ SearchBar.swift
│   └─ (Other UI components)
├─ Services/
│   └─ WeatherAPIService.swift
├─ WeatherAppApp.swift
└─ README.md
Requirements
Xcode 15 or later (because of SwiftData).
iOS 17 Deployment Target.
A valid WeatherAPI key (free tier is sufficient).
Setup & Installation
Clone the repository:
bash
Copiar
git clone https://github.com/YourUsername/WeatherApp.git
Open the project in Xcode 15 or later:
bash
Copiar
cd WeatherApp
open WeatherApp.xcodeproj
Insert your API Key:
In WeatherAPIService.swift, replace SUA_API_KEY_AQUI (or similar placeholder) with your own WeatherAPI key.
Run the project on an iOS 17 simulator or device.
Usage
Launch the app.
Search for a city in the top Search Bar:
Type a few letters; autocomplete suggestions appear.
Tap one suggestion to navigate to the City Detail screen.
City Detail screen:
Shows current weather data (icon, temperature, humidity, UV, etc.).
Tap “Save City” to store it locally.
Home Screen:
If the search bar is empty, you will see Saved Cities listed.
Tap a saved city to revisit its details.
Swipe to delete any saved city you no longer want.
API Integration
WeatherAPI.com is used to fetch:

Autocomplete (search.json): returns a list of potential matches for partial queries.
Current Weather (current.json): given a city name (or lat/lon), returns detailed weather info.
Endpoints:

GET https://api.weatherapi.com/v1/search.json?key=YOUR_API_KEY&q=QUERY
GET https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&q=QUERY
SwiftData Persistence
A SavedCity model is declared with @Model.
ModelContainer(for: SavedCity.self) is created in App and injected via .modelContainer(...).
The ViewModel handles all CRUD operations (insert, delete, etc.) on the ModelContext.
@Published properties (e.g., savedCities) automatically update SwiftUI when the data changes.
License
This project is provided under the MIT License (or whichever license you prefer). You’re free to modify and distribute it. See LICENSE for details.
