# Catgif App
Overview
This is a Cat GIF app developed using Swift and SwiftUI for iOS 18 with Xcode 16. The app utilizes The Cat API to fetch and display cat images along with breed-specific information. It follows the Model-View-ViewModel (MVVM)architecture, includes a repository layer and a network layer, and uses the dependency injection design pattern.


![Screenshot 2025-03-27 at 05 14 56](https://github.com/user-attachments/assets/3a44ac95-a9bc-4c06-b43b-fc7fd0fe7fe4)


Features
•	Select a cat breed from an interactive interface.
•	Display a list of cat images based on the chosen breed.
•	View detailed information about the selected breed.
•	Cache images in memory for optimized performance.
•	Smooth UI animations for an enhanced user experience.
•	Unit testing for the NetworkManager and Repository.

Architecture
The MVVM architecture is implemented to improve code organization and maintainability by ensuring a clear separation of concerns. Since components are well-structured and independent, unit testing becomes more efficient.

Design Patterns
•	Dependency Injection is used to reduce tight coupling between components, making the code more flexible and allowing for easy mocking or stubbing of dependencies during testing.

Project Structure

1. Model Directory
•	APIEndpoints.swift – Defines structured API endpoints.
•	Model.swift – Contains model structs for cat breeds and images, mapping JSON data from the API.

3. Network Directory
•	Handles all network requests and operations, separating them from business logic to ensure better testability and maintainability.

4. Repository Directory
•	Acts as a mediator between data sources (models) and the ViewModel.
•	Manages data caching and retrieval efficiently.

6. ViewModel Directory
•	Manages data and business logic for views.
•	Publishes property changes to automatically update the UI.
•	Contains key methods:
o	fetchCatBreeds() – Fetches and updates the list of cat breeds. Automatically selects the first breed if none is chosen and handles errors.
o	fetchCatImages() – Retrieves cat images based on the selected breed.

8. View Directory
•	Handles UI components and user interactions.
•	Key files:
o	CatBreedView.swift – Displays the main UI layout.
o	CatDetailBreedView.swift – Shows detailed breed information.

11. Cache Directory
•	Contains async image caching files for optimized image loading.

Testing
Two XCUnit Tests have been implemented to demonstrate testing in this architecture:
•	NetworkManager – Tests network operations.
•	CatBreedRepository – Ensures data retrieval and management work as expected.

Future Enhancements
•	Pull to Refresh – Allow users to refresh cat breed data.
•	Local Persistence – Implement Core Data or SwiftData for offline storage.
•	Search & Filter – Enable users to search or filter cat breeds easily.

 
