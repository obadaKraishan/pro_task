# ProTask
ProTask is an advanced Todo application built using Flutter. This app allows users to add, edit, delete, and view details of their todos. 
It supports both light and dark themes and stores data locally using Hive.

## Features
- Add new todo items with title and description.
- Edit existing todo items.
- Delete todo items.
- View details of each todo item.
- Toggle the status of todo items (completed/pending).
- Light and dark mode support.
- Local storage using Hive.

## Getting Started

### Prerequisites
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK
- Android Studio or Visual Studio Code

### Installation
1. **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/pro_task.git
    cd pro_task
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Generate Hive type adapter:**
    ```bash
    flutter packages pub run build_runner build
    ```

4. **Run the application:**
    ```bash
    flutter run
    ```

## Usage
### Adding a Todo
1. Click the floating action button (`+`) to add a new todo.
2. Enter the title and description.
3. Click "Save" to add the todo to the list.

### Editing a Todo
1. Tap on a todo item to view its details.
2. Click the edit icon (`✏️`) in the AppBar.
3. Update the title and/or description.
4. Click "Save" to apply changes.

### Deleting a Todo
1. Tap on a todo item to view its details.
2. Click the delete icon (`🗑️`) in the AppBar.
3. Confirm the deletion.

### Toggling Todo Status
1. In the todo list, use the checkbox to mark a todo as completed or pending.

## Screenshots
Include some screenshots of your app here to give users a visual overview of your application.

## Built With
- [Flutter](https://flutter.dev/) - The framework used
- [Hive](https://pub.dev/packages/hive) - A lightweight and fast key-value database

## Contributing
Contributions are welcome! Please read the [CONTRIBUTING.md](CONTRIBUTING.md) for details on the code of conduct, and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- Flutter documentation: [flutter.dev](https://flutter.dev/docs)
- Hive documentation: [Hive - Lightweight and fast key-value database](https://pub.dev/packages/hive)
- All the open-source projects that inspired this project

---

Feel free to customize this README to better suit your project’s specific details.
