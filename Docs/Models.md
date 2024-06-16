# Models

## Meal

Represents a meal with basic information.

### Properties

- `id`: String - The unique identifier for the meal.
- `name`: String - The name of the meal.
- `thumbnail`: String? - URL string of the meal's thumbnail image.

## MealDetail

Represents detailed information about a meal.

### Properties

- `id`: String - The unique identifier for the meal.
- `name`: String - The name of the meal.
- `category`: String - The category of the meal.
- `area`: String - The area of origin of the meal.
- `instructions`: String - Cooking instructions.
- `thumbnail`: String? - URL string of the meal's thumbnail image.
- `tags`: String? - Tags related to the meal.
- `youtubeURL`: String? - URL of a YouTube video related to the meal.
- `source`: String? - Source of the recipe.
- `ingredients`: [String] - List of ingredients.
- `measurements`: [String] - List of measurements for the ingredients.

## MealResponse

Represents the response from TheMealDB API containing a list of meals.

### Properties

- `meals`: [Meal] - Array of meals.
