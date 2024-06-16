# Views

## MealListView

Displays a list of dessert meals.

### Properties

- `viewModel`: MealListViewModel - The view model managing the state of the meal list.

### Subviews

- `SearchBar`: A search bar for filtering meals by name.
- `List`: A list of `MealCardView` displaying the meals.

## MealDetailView

Displays detailed information about a meal.

### Properties

- `mealID`: String - The ID of the meal to display.
- `viewModel`: MealDetailViewModel - The view model managing the state of the meal detail.

## MealCardView

Displays a card view for a single meal.

### Properties

- `meal`: Meal - The meal to display.

## MealDetailCardView

Displays detailed information about a meal in a card format.

### Properties

- `mealDetail`: MealDetail - The detailed information to display.
