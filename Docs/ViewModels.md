# ViewModels

## MealListViewModel

Manages the state and logic for the meal list view.

### Properties

- `meals`: [Meal] - Array of meals.
- `isLoading`: Bool - Indicates if the data is loading.
- `errorMessage`: String? - Error message if the data loading fails.
- `searchText`: String - The current text in the search bar.
- `filteredMeals`: [Meal] - Array of meals filtered by the search text.

### Methods

- `fetchMeals()`: Fetches the list of meals from TheMealDB API.

## MealDetailViewModel

Manages the state and logic for the meal detail view.

### Properties

- `mealDetail`: MealDetail? - Detailed information about the meal.
- `isLoading`: Bool - Indicates if the data is loading.
- `errorMessage`: String? - Error message if the data loading fails.

### Methods

- `fetchMealDetail(for id: String)`: Fetches detailed information about a meal by its ID.

