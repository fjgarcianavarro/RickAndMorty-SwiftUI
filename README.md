# RickAndMorty-SwiftUI

## 🚀 SwiftUI Application with Clean Architecture and SOLID Principles

This project is a **Rick and Morty** application built using **SwiftUI**, following **Clean Architecture** and **SOLID** principles.  
It implements a modular architecture with **dependency injection, repositories, use cases, and image caching**.

Additionally, the app uses **SwiftData** for local storage and **NSCache** for image caching.

---

## 📸 Screenshots & Previews

| App Screenshots | App Screenshots | App Screenshots |
|----------------|----------------|----------------|
| <a href="https://github.com/user-attachments/assets/a43928bc-a2a0-4c4e-9688-9146d5ba3bab" target="_blank"><img src="https://github.com/user-attachments/assets/a43928bc-a2a0-4c4e-9688-9146d5ba3bab" width="400"></a> | <a href="https://github.com/user-attachments/assets/21a67dfb-854f-414c-9f5a-2dc34f83f14a" target="_blank"><img src="https://github.com/user-attachments/assets/21a67dfb-854f-414c-9f5a-2dc34f83f14a" width="400"></a> | <a href="https://github.com/user-attachments/assets/bb44966e-18df-47b3-9369-dac303a622ed" target="_blank"><img src="https://github.com/user-attachments/assets/bb44966e-18df-47b3-9369-dac303a622ed" width="400"></a> |

| App Screenshots | App Screenshots | Tests |
|----------------|----------------|----------------|
| <a href="https://github.com/user-attachments/assets/ef754ffd-06f1-4144-9455-3bad7b01827c" target="_blank"><img src="https://github.com/user-attachments/assets/ef754ffd-06f1-4144-9455-3bad7b01827c" width="400"></a> | <a href="https://github.com/user-attachments/assets/4d9e19b9-b04a-4110-aa50-eaa50107fafd" target="_blank"><img src="https://github.com/user-attachments/assets/4d9e19b9-b04a-4110-aa50-eaa50107fafd" width="400"></a> | <a href="https://github.com/user-attachments/assets/4ca2de26-cb09-4dc2-bc1b-5d4616b5949e" target="_blank"><img src="https://github.com/user-attachments/assets/4ca2de26-cb09-4dc2-bc1b-5d4616b5949e" width="400"></a> |

| App Screenshots | App Screenshots |
|----------------|----------------|
| <a href="https://github.com/user-attachments/assets/53f43f93-62b4-4a2d-9384-ab196de63828" target="_blank"><img src="https://github.com/user-attachments/assets/53f43f93-62b4-4a2d-9384-ab196de63828" width="400"></a> | <a href="https://github.com/user-attachments/assets/a1aea65d-e9b4-4d01-89e4-057d94b7ba18" target="_blank"><img src="https://github.com/user-attachments/assets/a1aea65d-e9b4-4d01-89e4-057d94b7ba18" width="400"></a> |


| Code Coverage | SQLite Data (CoreData Cache) |
|--------------|----------------------|
| <a href="https://github.com/user-attachments/assets/60ada7a4-7651-4b12-bf2a-a111df324674" target="_blank"><img src="https://github.com/user-attachments/assets/60ada7a4-7651-4b12-bf2a-a111df324674" width="800"></a> | <a href="https://github.com/user-attachments/assets/ac12359e-7c70-47c2-9827-e0b362f8fd0c" target="_blank"><img src="https://github.com/user-attachments/assets/ac12359e-7c70-47c2-9827-e0b362f8fd0c" width="800"></a> |

| Localized Preview (EN & ES, Dark & Light) |
|------------------------------------------|
| <a href="https://github.com/user-attachments/assets/871d093e-a5a8-49c1-b911-c04c2bfad6b5" target="_blank"><img src="https://github.com/user-attachments/assets/871d093e-a5a8-49c1-b911-c04c2bfad6b5" width="960"></a> |

| Character Image View Preview (Collapsed, Expanded, With & Without Overlay) |
|----------------------------------------------------------------------------|
| <a href="https://github.com/user-attachments/assets/65f7b310-e0c1-4c0d-952c-63763037af24" target="_blank"><img src="https://github.com/user-attachments/assets/65f7b310-e0c1-4c0d-952c-63763037af24" width="960"></a> |

---

## 🏗 Architecture

The application is structured based on **Clean Architecture**, separating business logic from infrastructure and UI layers.

### 📂 Project Structure:

```
RickAndMorty-SwiftUI/
│── CompositionRoot/
│   ├── CharacterDetailFactory.swift
│   ├── CharacterListFactory.swift
│   ├── DependencyContainer.swift
│── Data/
│   ├── Cache/
│   │   ├── CharacterCacheDataSourceType.swift
│   │   ├── CharacterImageCache.swift
│   │   ├── CharacterImageCacheType.swift
│   │   ├── CharacterListCacheDataSourceType.swift
│   │   ├── CompositeCharacterCacheDataSource.swift
│   │   ├── CompositeCharacterListCacheDataSource.swift
│   │   ├── InMemoryCharacterCacheDataSource.swift
│   │   ├── InMemoryCharacterListCacheDataSource.swift
│   │   ├── SearchCacheDataSourceType.swift
│   │   ├── TTLInMemorySearchCacheDataSource.swift
│   ├── DTOs/
│   │   ├── CharacterDTO.swift
│   │   ├── CharacterResponseDTO.swift
│   │   ├── LocationDTO.swift
│   ├── Networking/
│   │   ├── CharacterDetailRemoteDataSource.swift
│   │   ├── CharacterImageRemoteDataSource.swift
│   │   ├── Endpoint.swift
│   │   ├── HTTPClient.swift
│   │   ├── HTTPClientError.swift
│   │   ├── HTTPMethod.swift
│   │   ├── RemoteDataSource.swift
│   │   ├── RemoteDataSourceType.swift
│   ├── Repositories/
│   │   ├── CharacterDetailRepository.swift
│   │   ├── CharacterImageRepository.swift
│   │   ├── CharacterRepository.swift
│   ├── CharacterDomainErrorMapper.swift
│   ├── CharacterDomainMapper.swift
│   ├── CharacterImageErrorMapper.swift
│── Domain/
│   ├── Entities/
│   │   ├── CharacterEntity.swift
│   │   ├── LocationEntity.swift
│   ├── Interfaces/
│   │   ├── CharacterDetailRepositoryType.swift
│   │   ├── CharacterImageRepositoryType.swift
│   │   ├── CharacterRepositoryType.swift
│   ├── UseCases/
│   │   ├── DownloadCharacterImageUseCase.swift
│   │   ├── GetAllCharactersUseCase.swift
│   │   ├── GetCharacterDetailUseCase.swift
│   │   ├── SearchCharactersUseCase.swift
│   ├── CharacterDomainError.swift
│   ├── CharacterImageError.swift
│── Infraestructure/
│   ├── Data/
│   │   ├── CharacterData.swift
│   │   ├── CharacterDataStorageMapper.swift
│   │   ├── CharacterListStorage.swift
│   │   ├── CharacterListStorageType.swift
│   │   ├── CharacterStorage.swift
│   │   ├── CharacterStorageDTO.swift
│   │   ├── CharacterStorageDTOMapper.swift
│   │   ├── CharacterStorageType.swift
│   │   ├── LocationData.swift
│   │   ├── PersistentCharacterCacheDataSource.swift
│   │   ├── PersistentCharacterListCacheDataSource.swift
│   ├── Networking/
│   │   ├── APIConstants.swift
│   │   ├── URLSessionErrorResolver.swift
│   │   ├── URLSessionHTTPCLient.swift
│   │   ├── URLSessionRequestMaker.swift
│── Presentation/
│   │   ├── CharacterDetailViewModel.swift
│   │   ├── CharacterListDisplayMode.swift
│   │   ├── CharacterListViewModel.swift
│   │   ├── CharacterPresentable.swift
│   │   ├── View+Modifiers.swift
│   │   ├── CharacterPresentableErrorMapper.swift
│   │   ├── LocalizedErrorKey.swift
│── Preview Content/
│   ├── ModifierPreview.swift
│   ├── PreviewData.swift
│── UI/
│   │── Components/
│   │   ├── AlertModifier.swift
│   │   ├── BottomNameView.swift
│   │   ├── CharacterDetailCell.swift
│   │   ├── CharacterDetailStackCell.swift
│   │   ├── CharacterGridItemView.swift
│   │   ├── CharacterImageView.swift
│   │   ├── CharacterListItemView.swift
│   │   ├── CharacterListLoadingView.swift
│   │   ├── CharacterListTypeSwitcherView.swift
│   ├── CharacterDetailView.swift
│   ├── CharacterDetailViewFactory.swift
│   ├── CharacterListView.swift
│   ├── Image+Styles.swift
│   ├── Font+Styles.swift
│── Utils/
│   ├── Foundation+Extensions.swift
│── Localizations/
│   │   ├── Localizable.xcstrings
│   │   ├── RickAndMorty-SwiftUI-InfoPlist.xcstrings
│── RickAndMorty_SwiftUIApp.swift
│── RickAndMorty-SwiftUITests/
│   ├── Data/
│   │   ├── CharacterDomainErrorMapperTests.swift
│   │   ├── CharacterDomainMapperTests.swift
│   │   ├── CharacterRepositorySearchTests.swift
│   │   ├── CharacterRepositoryTests.swift
│   │   ├── CompositeCharacterListCacheDataSourceTests.swift
│   │   ├── RemoteDataSourceTests.swift
│   │   ├── TTLInMemorySearchCacheDataSourceTests.swift
│   ├── Domain/
│   │   ├── GetAllCharactersUseCaseTests.swift
│   │   ├── SearchCharactersUseCaseTests.swift
│   ├── Presentation/
│   │   ├── CharacterListViewModelTests.swift
│   ├── Helpers/
│   │   ├── CharacterDTOTestData.swift
│   │   ├── CharacterDataTestData.swift
│   │   ├── CharacterEntityTestData.swift
│   │   ├── CharacterListCacheDataSourceStub.swift
│   │   ├── CharacterListRemoteDataSourceStub.swift
│   │   ├── CharacterListStorageStub.swift
│   │   ├── CharacterRepositoryStub.swift
│   │   ├── CharacterStorageDTOTestData.swift
│   │   ├── DownloadCharacterImageUseCaseStub.swift
│   │   ├── Equatable.swift
│   │   ├── GetAllCharactersUseCaseStub.swift
│   │   ├── HTTPClientStub.swift
│   │   ├── SearchCacheDataSourceStub.swift
│   │   ├── SearchCharactersUseCaseStub.swift
│   ├── Infraestructure/
│   │   ├── PersistentCharacterListCacheDataSourceTests.swift
│   ├── Utils/
│   │   ├── ResultExtensionTests.swift
```

✅ **Composition Root (`CompositionRoot`)**  
Defines the dependency injection structure for the app.

✅ **Infrastructure (`Infrastructure`)**  
Manages networking, caching, and system services.

✅ **Data (`Data`)**  
Contains **DTOs**, **repositories**, and data sources.

✅ **Domain (`Domain`)**  
Includes **entities, interfaces, and use cases** for business logic.

✅ **Presentation (`Presentation`)**  
Contains **ViewModels, Views, Modifiers, Mappers, and Extensions**.

✅ **UI (`UI`)**  
SwiftUI components that structure the user interface.

✅ **Utils (`Utils`)**  
Extensions and utilities to support the application.

### Persistence Boundary (StorageDTO Pattern)

The `@Model` class `CharacterData` is confined to the `ModelActor` and is not `Sendable`. `LocationData` is a `Codable` struct stored inline within `CharacterData`, avoiding a separate table and preventing orphaned records on updates. To safely cross the actor boundary under Swift 6 strict concurrency:

- **`CharacterStorageDTO` / `LocationStorageDTO`** are lightweight `Sendable` value types that carry the same data as `@Model` but can be passed freely between isolation domains.
- **`CharacterDataStorageMapper`** converts `@Model ↔ StorageDTO` **inside** the `ModelActor`.
- **`CharacterStorageDTOMapper`** converts `StorageDTO ↔ Entity` **outside** the actor, at the persistence boundary.

This two-step mapping keeps `@Model` types safely isolated while giving the rest of the architecture `Sendable` data to work with.

---

### 🎨 UI Customization

The project includes **custom font styles** to ensure a consistent and visually appealing design:

```swift
extension Font {
    static let rmCharacterNameList = Font.system(.caption, design: .rounded)
        .weight(.bold)
    
    static let rmCharacterNameDetail = Font.system(.title, design: .rounded)
        .weight(.bold)
    
    static let rmLoadingText = Font.system(.headline, design: .rounded)
        .weight(.semibold)
    
    static let rmAlertTitle = Font.system(.title3, design: .rounded)
        .weight(.bold)
    
    static let rmAlertButton = Font.system(.body, design: .rounded)
        .weight(.semibold)
    
    static let rmSectionHeader = Font.system(.headline, design: .rounded)
        .weight(.bold)
    
    static let rmDetailTitle = Font.system(.body, design: .rounded)
        .weight(.semibold)
    
    static let rmDetailValue = Font.system(.body, design: .rounded)
        .weight(.regular)
}
```

These styles are applied across the UI:

- **rmCharacterNameList**: Used for character names in the character list.
- **rmCharacterNameDetail**: Used for the character name in the detail screen.
- **rmLoadingText**: Used for the "Loading..." text in loading states.
- **rmAlertTitle**: Used for alert titles.
- **rmAlertButton**: Used for alert action buttons.
- **rmSectionHeader**: Used for section headers in the character detail screen.
- **rmDetailTitle**: Used for detail titles in the character detail screen.
- **rmDetailValue**: Used for the values displayed in character details.
    
---

### 📱 SwiftUI Previews

All **SwiftUI views** include **previews with mock data** to facilitate real-time editing within **Xcode Canvas**.

This allows working visually without needing to run the app on a simulator or device, speeding up development and improving the design experience.

Additionally:
- ✅ **Previews are available in both Light Mode and Dark Mode** for necessary cases, ensuring proper UI adaptation.
- ✅ **Localized previews**: Developers can test how the UI adapts to different languages (English & Spanish) in real-time.
- ✅ **The AlertModifier also includes a preview**, allowing for easy visualization and adjustments of the custom alert component.
- ✅ **Reusable components, such as CharacterImageView, include previews demonstrating different states** (expanded, collapsed, with/without overlay), making them easier to test and integrate.

#### Example of a **SwiftUI Preview**:

```swift
#Preview {
    CharacterListView(viewModel: .preview,
                      createCharacterDetailView: CharacterDetailFactory(container: DependencyContainer()))
        .environment(\.locale, .init(identifier: "es")) // Example for Spanish preview
}
```

---

## 🧵 Concurrency Model

The project targets **Swift 6 with complete strict concurrency checking** (`SWIFT_STRICT_CONCURRENCY = complete`) and adopts the **approachable concurrency** upcoming features (`SWIFT_APPROACHABLE_CONCURRENCY = YES`, which enables `NonisolatedNonsendingByDefault`).

Key architectural decisions driven by this choice:

- ✅ **Data-layer protocols explicitly conform to `Sendable`** (`CharacterCacheDataSourceType`, `CharacterRepositoryType`, …). This is a defensive contract: under `NonisolatedNonsendingByDefault`, `async` methods inherit the caller's isolation, so the compiler may not enforce `Sendable` today because the entire repository chain currently runs on `@MainActor`. Declaring it explicitly keeps the architecture safe the moment any caller introduces `Task.detached` or a non-main-actor context.
- ✅ **Mutable caches are modeled as `actor` types** (`InMemoryCharacterCacheDataSource`, `InMemoryCharacterListCacheDataSource`, `CharacterImageCache`), guaranteeing serialized access to shared state without locks.
- ✅ **SwiftData persistence uses `ModelActor`** (`CharacterStorage`, `CharacterListStorage`), isolating `ModelContext` in its own actor as Apple recommends.
- ✅ **ViewModels are `@MainActor`-isolated**, and the asynchronous chain from view model → use case → repository → cache runs without unnecessary hops thanks to `NonisolatedNonsendingByDefault`.

---

## 🛠 Technologies and Tools

- ✅ **Swift 6.0 with complete strict concurrency**
- ✅ **SwiftUI**
- ✅ **Async/Await, actors, and approachable concurrency (`NonisolatedNonsendingByDefault`)**
- ✅ **Clean Architecture + SOLID**
- ✅ **URLSession for networking**
- ✅ **NSCache for image caching**
- ✅ **SwiftData for local storage**
- ✅ **ViewModifiers for UI customization**
- ✅ **Dependency Injection**
- ✅ **XCTest** for unit testing across all architecture layers

---

## 🌍 Localization Support

The application supports multiple languages (English and Spanish) using Apple’s latest localization technology: String Catalogs.

- ✅ **Localized App Name and UI Elements**: The app dynamically adjusts its name and UI texts based on the selected language.
- ✅ **Error Messages and System Alerts**: All user-facing error messages are fully localized for a better user experience.
- ✅ **Seamless Integration with Xcode**: Using String Catalogs ensures an easy and efficient way to manage and expand localization.
- ✅ **Future Language Support**: Additional languages can be easily added without modifying the core codebase.

🔗 [Apple WWDC23: String Catalogs Overview](https://developer.apple.com/videos/play/wwdc2023/10155/)

---

## 📡 API Used

This application consumes the **Rick and Morty API**:
🔗 [https://rickandmortyapi.com](https://rickandmortyapi.com)

📌 **Endpoints used:**
```http
GET https://rickandmortyapi.com/api/character          # List all characters
GET https://rickandmortyapi.com/api/character?name=rick # Search characters by name
GET https://rickandmortyapi.com/api/character/{id}      # Character detail
```

---

## 🎯 Key Features

- ✅ **Character list with cached images**
- ✅ **Search characters by name** with `.searchable`, debounce (300ms), and automatic task cancellation
- ✅ **In-memory search cache with TTL** (2-minute expiration, keyed by normalized query)
- ✅ **Efficient image caching with `NSCache`**
- ✅ **Local storage with `SwiftData`**
- ✅ **Error handling with `Result<T, Error>`**
- ✅ **Multi-language support (English & Spanish) using Apple’s latest localization technology (String Catalogs)**
- ✅ **Two display modes for the character list: List and Grid views**
- ✅ **Character detail screen displaying key information**
- ✅ **Custom fonts and reusable UI components for better design consistency**
- ✅ **Modular and scalable architecture following Clean Architecture & SOLID principles**
- ✅ **Unit tests covering all layers: use cases, repositories, cache, search flow, and presentation (ViewModels)**
- ✅ **Presentation layer fully tested** with injectable debounce for deterministic ViewModel testing
- ✅ **Interactive SwiftUI previews for all views, supporting different modes and languages**  

---

## 🏗 How to Run the Project

1. **Clone the repository**  
   ```bash
   git clone https://github.com/your-username/RickAndMorty-SwiftUI.git
   cd RickAndMorty-SwiftUI
   ```
2. **Open in Xcode**  
   📂 Open `RickAndMorty_SwiftUI.xcodeproj` in Xcode.
3. **Build and Run**  
   - 📱 **Select a simulator or physical device**
   - ▶️ **Press "Run" (⌘R) in Xcode**

#### Command-line build & test

```bash
# Build
xcodebuild -project RickAndMorty-SwiftUI.xcodeproj \
  -scheme RickAndMorty-SwiftUI -configuration Debug build

# Run all tests
xcodebuild -project RickAndMorty-SwiftUI.xcodeproj \
  -scheme RickAndMorty-SwiftUI \
  -destination 'platform=iOS Simulator,name=iPhone 16' test

# Run a single test class
xcodebuild -project RickAndMorty-SwiftUI.xcodeproj \
  -scheme RickAndMorty-SwiftUI \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:RickAndMorty-SwiftUITests/TTLInMemorySearchCacheDataSourceTests test
```

---

## 🧠 Technical Decisions

### Search & Cancellation

- **`.searchable` + `onChange`**: Native SwiftUI integration with `NavigationStack`. The search bar appears idiomatically and the binding drives the entire search flow.
- **Debounce (300ms)**: Each keystroke cancels the previous `Task` and starts a new one with a `Task.sleep` guard. This avoids firing a network request per character typed.
- **Task cancellation**: `searchTask?.cancel()` before creating each new `Task` ensures in-flight URLSession requests are cancelled. A `guard !Task.isCancelled` check after the debounce and after the network call prevents stale results from appearing.
- **Empty state**: `ContentUnavailableView` (iOS 17+) provides a native empty-results screen with system imagery.

### TTL In-Memory Cache

- **Actor-based**: `TTLInMemorySearchCacheDataSource` is an `actor`, guaranteeing thread-safe access without locks.
- **TTL of 2 minutes** (configurable via `init`): Each entry stores an `expiresAt` date. Reads return `nil` if the entry has expired, forcing a fresh network fetch.
- **Keyed by normalized query**: Queries are lowercased and trimmed before storage, so `"Rick"`, `" rick "`, and `"RICK"` all hit the same cache entry.
- **No disk persistence for searches**: Search results are ephemeral by nature. The initial character list retains its SwiftData persistence through the existing `CompositeCharacterListCacheDataSource`.

### Architecture

- **`SearchCharactersUseCase`** is a dedicated use case, separated from `GetAllCharactersUseCase`, following the Single Responsibility Principle.
- **`SearchCacheDataSourceType`** protocol allows the repository to depend on an abstraction, making the cache fully replaceable in tests (via `SearchCacheDataSourceStub`).
- **Repository pattern**: `CharacterRepository.searchCharacters(name:)` checks the TTL cache first, falls back to the network, and stores the result — same pattern as the existing `getCharacters()` flow.

---

## 🔥 Future Enhancements

-	~~📌 **Add unit tests for the presentation layer**~~ ✅ Implemented (CharacterListViewModelTests — 8 tests covering fetch, search, debounce cancellation, error handling, and refresh)
-	📌 **Add unit tests for the image download use case**
-	📌 **Add unit tests for the character detail use case**
-	📌 **Implement UI tests**
-	📌 **Add pagination to the character list**
-	📌 **Implement a splash screen with animations**
-	📌 **Refactor API logic into a separate local Swift Package (SPM)**
-	📌 **Localize character attributes such as status and gender types**
-	📌 **Enhance location details by combining multiple API services in a dedicated use case**
-	📌 **Extend episode details retrieval using a similar approach to location details**
-	~~📌 **Implement search filters for better character discovery**~~ ✅ Implemented (search by name with debounce, cancellation, and TTL cache)

---

## 📖 Background

This project was originally built in 2025 as the technical assessment for an iOS position at **Inditex / Zara**. After the technical interview with the Zara iOS architects, the role offered was raised from **iOS Developer** to **iOS Technical Lead** based on the codebase and the discussion around it.

It has been kept up to date since then as a living reference for Clean Architecture and modern Swift concurrency in SwiftUI.

---

## 👨‍💻 Author

💡 _Developed by_ **Francisco José García Navarro**  
