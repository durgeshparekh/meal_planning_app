# meal_planning_app

A new Flutter project.

## Getting Started

### Problem Statement
Create a mobile application using Flutter that helps users discover recipes, plan meals, and manage grocery lists. The app will integrate with the Spoonacular Recipe API.

### Core Requirements
1. **Recipe Search & Meal Planning**
   - Implement recipe search functionality using the Spoonacular API (https://spoonacular.com/food-api/docs#Search-Recipes-Complex).
   - Allow users to add recipes to their meal plan.
   - Allow basic list management (add/remove items).

2. **Grocery List Generation**
   - Create a feature to automatically generate grocery lists for the meal plan.
   - Aggregate ingredient quantities from multiple recipes.
   - Allow users to mark grocery list items as purchased.

### Additional Features
- Users can select groceries and adjust quantities.
- Purchased groceries are tracked with an `isPurchased` flag.
- Users can reset the grocery list.
- Error handling for null and undefined values with meaningful messages.

### Limitations
- Users can have only one meal plan at a time.
- Grocery list can be local-only, no need to connect to a server/database.

### Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/meal_planning_app.git
   ```
2. Navigate to the project directory:
   ```sh
   cd meal_planning_app
   ```
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Run the app:
   ```sh
   flutter run
   ```

### Usage
- Search for recipes and add them to your meal plan.
- View and manage your meal plan.
- Generate a grocery list based on your meal plan.
- Mark items in your grocery list as purchased.
- Reset your grocery list when needed.

### Contributing
Contributions are welcome! Please open an issue or submit a pull request.

### License
This project is licensed under the MIT License.
