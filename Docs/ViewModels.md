# ViewModels

## MealListViewModel

Manages the state and logic for the meal list view.

### Properties

- `meals`: [Meal] - Array of meals.
- `viewState`: ViewState<[Meal]> - The state of the view, including loading, success, and failure states.
- `searchText`: String - The current text in the search bar.
- `filteredMeals`: [Meal] - Array of meals filtered by the search text.

### Methods

- `fetchMeals()`: Fetches the list of meals from TheMealDB API.

## MealDetailViewModel

Manages the state and logic for the meal detail view.

### Properties

- `viewState`: ViewState<MealDetail> - The state of the view, including loading, success, and failure states.

### Methods

- `fetchMealDetail(for id: String)`: Fetches detailed information about a meal by its ID.
