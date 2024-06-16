# Utilities

## APIConfig

Configuration for API endpoints.

### Properties

- `dessertMealsURL`: String - URL string for fetching dessert meals.
- `mealDetailURL(for id: String) -> String`: Function - Generates the URL string for fetching meal details based on meal ID.

## NetworkingService

Handles network requests.

### Methods

- `fetchData<T: Decodable>(from url: URL) async throws -> T`: Fetches data from a given URL and decodes it into the specified type.

## MockNetworkingService

A mock implementation of `NetworkingService` for testing purposes.

### Properties

- `fetchDataHandler: ((URL) throws -> Data)?`: A closure to handle fetching data in tests.

### Methods

- `fetchData<T: Decodable>(from url: URL) async throws -> T`: Uses the `fetchDataHandler` closure to provide mock data for testing.

## ViewState

Represents the state of a view.

### Cases

- `loading`: Indicates that the view is loading data.
- `success(T)`: Indicates that the view successfully loaded data of type `T`.
- `failure(String)`: Indicates that the view failed to load data, with an associated error message.
