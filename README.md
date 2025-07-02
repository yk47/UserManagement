# User Management App

A modern Flutter application for managing users with a beautiful UI and BLoC state management pattern.

## Features

- 📱 Modern gradient UI design with consistent theming
- 👥 User list with real-time search functionality
- ➕ Add new users with comprehensive forms (Contact, Address, Company)
- 👤 View detailed user information with organized sections
- 🔄 Pull-to-refresh support for data synchronization
- 💾 Local storage for offline users using SharedPreferences
- 📱 Responsive design (mobile/tablet/desktop layouts)
- 🎨 Gradient headers and modern card-based design
- 🔍 Search by name, email, phone, or username
- ✨ Smooth animations and transitions

## Screenshots

The app features a modern gradient design with:
- **Home Page**: Gradient header with user count, progress bar, and integrated search
- **User Tiles**: Card-based design with gradient avatars and user information
- **Add User**: Sectioned forms with Contact Information, Address, and Company details
- **User Details**: Comprehensive user profile with organized information cards
- **Responsive Layout**: Adaptive grid/list views based on screen size

## Architecture

- **State Management**: Flutter BLoC pattern for predictable state management
- **API Integration**: JSONPlaceholder REST API for demo users
- **Local Storage**: SharedPreferences for persistent offline user storage
- **Responsive Design**: Adaptive layouts using MediaQuery breakpoints
- **Error Handling**: Comprehensive error states and user feedback
- **Modern UI**: Material Design 3 with custom gradient theming

## Getting Started

### Prerequisites

- **Flutter SDK**: 3.0.0 or higher
- **Dart SDK**: 3.0.0 or higher
- **Development Environment**: Android Studio, VS Code, or IntelliJ IDEA
- **Device/Emulator**: Android/iOS emulator or physical device
- **Internet Connection**: Required for initial API data fetch

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd userdemo_app
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```

4. **Run the application**
   ```bash
   # For development with hot reload
   flutter run
   
   # For debug mode on specific device
   flutter run -d <device-id>
   
   # For release mode
   flutter run --release
   ```

### Building for Production

**Android APK (Release):**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Android App Bundle:**
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**iOS (macOS required):**
```bash
flutter build ios --release
# Follow additional iOS deployment steps
```

## Project Structure

```
lib/
├── blocs/                     # BLoC State Management
│   ├── add_user/             # Add User Feature
│   │   ├── add_user_bloc.dart
│   │   ├── add_user_event.dart
│   │   └── add_user_state.dart
│   └── user/                 # Main User Management
│       ├── user_bloc.dart
│       ├── user_event.dart
│       └── user_state.dart
├── models/                   # Data Models
│   └── user_model.dart      # User, Address, Company, Geo models
├── screens/                  # UI Screens
│   ├── home_page.dart       # Main user list with search
│   ├── add_user_page.dart   # Comprehensive user creation form
│   └── user_details_page.dart # Detailed user information view
├── services/                 # External Services
│   ├── api_services.dart    # HTTP API integration
│   └── user_storage_service.dart # Local storage management
├── utils/                    # Utilities and Styles
│   └── app_styles.dart      # Consistent theming and responsive design
├── widgets/                  # Reusable UI Components
│   ├── user_tile.dart       # User card component
│   └── custom_text_field.dart # Styled text input component
└── main.dart                # Application entry point
```

## Dependencies

**Core Dependencies:**
- `flutter_bloc: ^8.1.3` - State management with BLoC pattern
- `http: ^1.1.0` - HTTP client for API integration
- `shared_preferences: ^2.2.2` - Local data persistence
- `equatable: ^2.0.5` - Value equality for BLoC states

**Development Dependencies:**
- `flutter_test` - Unit and widget testing framework
- `flutter_lints: ^3.0.0` - Dart code linting rules

## API Integration

**Data Source:**
- **API**: [JSONPlaceholder Users](https://jsonplaceholder.typicode.com/users)
- **Method**: GET request with timeout handling
- **Fallback**: Graceful degradation to local-only mode when offline
- **Data Combining**: Merges API users with locally stored users

**User Data Structure:**
```json
{
  "id": 1,
  "name": "Leanne Graham",
  "username": "Bret",
  "email": "Sincere@april.biz",
  "address": {
    "street": "Kulas Light",
    "suite": "Apt. 556",
    "city": "Gwenborough",
    "zipcode": "92998-3874",
    "geo": {
      "lat": "-37.3159",
      "lng": "81.1496"
    }
  },
  "phone": "1-770-736-8031 x56442",
  "website": "hildegard.org",
  "company": {
    "name": "Romaguera-Crona",
    "catchPhrase": "Multi-layered client-server neural-net",
    "bs": "harness real-time e-markets"
  }
}
```

## Key Features Implementation

### User Management
- **List View**: Displays all users (API + local) with search functionality
- **Search**: Real-time filtering by name, email, phone, or username
- **Add Users**: Comprehensive form with validation and local storage
- **User Details**: Organized display of all user information
- **Data Persistence**: Local users stored permanently in SharedPreferences

### Modern UI/UX
- **Gradient Design**: Consistent blue-purple gradient throughout the app
- **Card Layout**: Modern card-based design with subtle shadows
- **Responsive Grid**: Adaptive layouts (2 columns mobile, 3 tablet, 4 desktop)
- **Smooth Animations**: Transitions, loading states, and user feedback
- **Search Integration**: Header-integrated search with clear functionality

### State Management
- **BLoC Pattern**: Predictable state management with events and states
- **Error Handling**: Comprehensive error states with retry mechanisms
- **Loading States**: Visual feedback during async operations
- **Data Synchronization**: Automatic refresh and state updates

## Troubleshooting

### Common Build Issues

1. **Dependency Conflicts**
   ```bash
   flutter clean
   flutter pub get
   flutter pub deps
   ```

2. **Platform-Specific Issues**
   ```bash
   # Android
   flutter clean
   cd android && ./gradlew clean && cd ..
   flutter build apk
   
   # iOS (macOS only)
   cd ios && rm -rf Pods Podfile.lock && pod install && cd ..
   flutter build ios
   ```

3. **Version Conflicts**
   ```bash
   flutter upgrade
   flutter pub upgrade
   ```

### Runtime Issues

1. **Network Connectivity**
   - App works offline with local users only
   - Check internet connection for API data
   - Verify API endpoint accessibility

2. **Storage Permission**
   - SharedPreferences handles permissions automatically
   - Ensure sufficient device storage space

3. **State Management Issues**
   - Check BLoC event registration
   - Verify proper context usage
   - Review debug console for BLoC logs

### Development Tips

1. **Hot Reload**: Use `r` in terminal for quick UI updates
2. **Full Restart**: Use `R` for state reset during development
3. **Debug Console**: Monitor debug prints for BLoC state changes
4. **Flutter Inspector**: Use in IDE for widget tree debugging

## Platform Compatibility

**Android:**
- Minimum SDK: 21 (Android 5.0 Lollipop)
- Target SDK: Latest stable
- Permissions: Internet (automatic), no additional permissions required

**iOS:**
- Minimum iOS: 11.0
- No additional permissions required
- App Transport Security: Configured for HTTP requests

**Web (Beta Support):**
- Modern browsers with Flutter Web support
- CORS considerations for API requests

## Performance Optimization

- **Lazy Loading**: Efficient list rendering with ListView.builder
- **Image Optimization**: Text-based avatars reduce memory usage
- **State Efficiency**: BLoC pattern prevents unnecessary rebuilds
- **Network Caching**: Local storage reduces API dependency

## Testing

**Run Unit Tests:**
```bash
flutter test
```

**Run Integration Tests:**
```bash
flutter drive --target=test_driver/app.dart
```

**Test Coverage:**
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

## Contributing

1. **Fork the Repository**
2. **Create Feature Branch**: `git checkout -b feature/amazing-feature`
3. **Commit Changes**: `git commit -m 'Add amazing feature'`
4. **Push to Branch**: `git push origin feature/amazing-feature`
5. **Open Pull Request**

**Code Style Guidelines:**
- Follow Flutter/Dart style guide
- Use meaningful variable and function names
- Add comments for complex business logic
- Maintain consistent file structure
- Write unit tests for new features

## License

This project is developed for educational purposes and demonstration of Flutter development best practices, BLoC state management, and modern mobile app architecture.

## Resources

**Flutter Learning:**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

**BLoC Pattern:**
- [BLoC Library Documentation](https://bloclibrary.dev/)
- [BLoC Pattern Guide](https://bloclibrary.dev/bloc-concepts/)

**API Reference:**
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com/)
- [HTTP Package Documentation](https://pub.dev/packages/http)

## Support

For issues, questions, or contributions:
1. Check existing GitHub issues
2. Create detailed issue reports
3. Include device information and error logs
4. Follow the contribution guidelines

---

**Happy Coding! 🚀**
