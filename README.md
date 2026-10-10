# BucketList

![Swift](https://img.shields.io/badge/Swift-5.0+-FA7343?logo=swift&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-18.0+-000000?logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-16.0+-147EFB?logo=xcode&logoColor=white)
![Framework](https://img.shields.io/badge/Framework-SwiftUI-007AFF)
![Framework](https://img.shields.io/badge/Framework-MapKit-34C759)
![Security](https://img.shields.io/badge/Security-LocalAuthentication-5856D6)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-8A2BE2)

An interactive geolocation tracking and discovery iOS application built natively with SwiftUI and MapKit, featuring hardware-level biometric authentication, encrypted document persistence, and dynamic point-of-interest discovery via Wikipedia.

BucketList enables users to drop custom location pins on an interactive map, inspect surrounding geographic points of interest fetched asynchronously from Wikipedia's MediaWiki API, configure metadata, and protect stored private places behind Face ID or Touch ID security policies. The project combines modern SwiftUI declarative layouts with a clean, decoupled MVVM architecture adhering to SOLID principles.

## Preview

<img width="23%" alt="Standart" src="https://github.com/user-attachments/assets/09434949-509c-48ed-b183-778d878cc96d" />
<img width="23%" alt="Hybrid" src="https://github.com/user-attachments/assets/4ba93782-be2a-4e2d-91d4-ab8f4f16e40b" />
<img width="23%" alt="Detail" src="https://github.com/user-attachments/assets/8c2e9828-0c91-49bf-98b6-15985e378bcd" />

## Features

- **Interactive Map Canvas:** Smooth coordinate navigation and pin placement using MapKit's `MapReader` and native gesture interaction with dynamic camera tracking.
- **Biometric Security:** Strict hardware-level authorization via `LocalAuthentication` (`LAContext`), securing sensitive user location data behind Face ID / Touch ID evaluations.
- **Encrypted Local Persistence:** Automatic filesystem serialization to the app's documents directory via `FileManager` using `Data.write(to:options: [.atomic, .completeFileProtection])`.
- **Wikipedia Geosearch Integration:** Asynchronous coordinate querying against the MediaWiki API to locate, rank, and present nearby cultural and historical places.
- **Map Layer Toggling:** Instant runtime switching between standard vector schema and hybrid satellite imagery overlays via a floating control panel.
- **Resilient Network Handling:** Complete view state tracking with progress indicators, localized error handling, and inline retry mechanisms for failed network calls.

## About the Project & Challenge

This application was developed as **Project 14 (Days 68-73)** of Paul Hudson's 100 Days of SwiftUI curriculum.

The baseline tutorial covered building interactive map pins, integrating `LocalAuthentication` for protected content, persisting data securely using file protection attributes, and consuming Wikipedia's web API using Swift concurrency (`async/await`).

Beyond the baseline requirements, the codebase underwent comprehensive architectural refactoring to meet production engineering standards and address all milestone challenges:

- **Protocol-Oriented Service Layer:** Extracted URL construction, `URLSession` data tasks, HTTP status validation, and JSON decoding out of view models into an isolated `WikipediaService` governed by `WikipediaServiceProtocol`.
- **Dependency Injection (DI):** Injected service dependencies through initializers into `EditViewModel`, decoupling business rules from networking implementations and enabling testability.
- **View Composition (Dumb Views):** Decomposed monolithic views into reusable, single-responsibility components (`LocationAnnotationView`, `MapStylePickerView`, `NearbyPlaceRowView`) using closures and `@Binding` connections.
- **Type Safety & Model Cleanliness:** Refactored raw API structures into `WikipediaResult` and `WikipediaQuery` to avoid shadowing the standard library's `Swift.Result` type.
- **Challenge 1 (Map Style Switcher):** Implemented an isolated map style toggle supporting standard and hybrid layers with state management encapsulated in the view model.
- **Challenge 2 (Biometric Error Presentation):** Replaced silent authentication failures with user-facing alerts presenting localized biometric error reasons on the main thread.
- **Challenge 3 (EditView MVVM Refactoring):** Migrated state, Wikipedia loading phases (`LoadingState`), and location mutation logic out of `EditView` into a dedicated `@Observable` `EditViewModel`.

🔗 **[Full project challenge description (Day 73)](https://www.hackingwithswift.com/books/ios-swiftui/bucket-list-wrap-up)**

## Project Versioning & Changelog

- **v1.2.0 (Clean Architecture, Networking Layer & View Composition)** — `commit: 05bc41d`  
  Reorganized project into layered groups (App, Models, ViewModels, Views, Services). Decoupled networking into `WikipediaService` using `WikipediaServiceProtocol` with DI. Extracted `LocationAnnotationView`, `MapStylePickerView`, and `NearbyPlaceRowView` dumb components. Renamed models to prevent shadowing `Swift.Result`.

- **v1.1.0 (Course Challenges Completion & EditView MVVM)** — `commit: 8f50678`  
  Completed all three curriculum challenges: added hybrid map style toggle, added biometric authentication error alerts, and extracted `EditViewModel` with isolated state and Wikipedia loading.

- **v1.0.0 (Functional MVP Release)** — `commit: 1d1e18a`  
  Initial baseline release matching the course curriculum. Implemented interactive map annotations, encrypted file persistence in documents directory, biometric authentication gate, and Wikipedia place fetching.
