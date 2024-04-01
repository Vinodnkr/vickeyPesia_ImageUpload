# VickeyPedia

VickeyPedia is a simple knowledge management system that allows users to create, search, edit, and delete articles. It's designed to be lightweight and easy to use.

## Features

1. **Search**: Quickly find articles using keywords or phrases.
2. **Add**: Create new articles with relevant content.
3. **Edit**: Modify existing articles to keep information up-to-date.
4. **Delete**: Remove articles that are no longer needed.

## Technologies Used

- **Flutter**: A powerful framework for building cross-platform mobile applications.
- **Firebase**: Provides both **Cloud Firestore** for database storage and **Firebase Storage** for file storage.

## Installation

1. Clone this repository to your local machine.
2. Make sure you have **Flutter** installed (version 2.0 or higher).
3. Set up your **Firebase** project:
    - Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    - Enable **Firestore** and **Firebase Storage**.
    - Obtain your **Firebase configuration** (API keys, project ID, etc.).
4. Update the `lib/config/firebase_config.dart` file with your Firebase configuration.
5. Install the required dependencies using `flutter pub get`.
6. Run the application using `flutter run`.

## Usage

1. Open your terminal and navigate to the project directory.
2. Run `flutter run` to start the app on your emulator or physical device.
3. Use the search bar to find articles.
4. Click on an article to view its content.
5. To add a new article, click the "Add Article" button.
6. To edit or delete an existing article, click the "Edit" or "Delete" button next to the article.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to create a pull request.

