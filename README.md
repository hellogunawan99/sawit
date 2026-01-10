# Sawit

A comprehensive business dashboard and management application built with Flutter.

![Flutter](https://img.shields.io/badge/Flutter-3.10+-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10+-blue?logo=dart)

## Status

**This project is currently in active development.**

## About

Sawit is a responsive business management dashboard that provides an intuitive interface for monitoring business metrics, managing products, tracking orders, and analyzing customer data. The app features a modern Material Design 3 interface with beautiful gradient accents and smooth animations.

## Features

### Current Features

- **Authentication System**
  - Secure login/logout functionality
  - Persistent session management using `shared_preferences`
  - Demo credentials for testing (see Demo Credentials section)

- **Responsive Dashboard**
  - Adaptive layouts for mobile, tablet, and desktop devices
  - Collapsible sidebar navigation
  - Real-time statistics cards with trend indicators
  - Revenue overview chart with weekly data
  - Recent activity feed

- **Navigation Sections**
  - Dashboard - Overview of business metrics
  - Analytics - Data visualization and insights
  - Products - Product inventory management
  - Customers - Customer relationship management
  - Orders - Order tracking and management
  - Settings - Application preferences

### UI/UX Highlights

- Material Design 3 with custom theming
- Purple/blue gradient color scheme
- Smooth animations and transitions
- Search functionality
- Notification system with badge indicators
- User profile avatar

## Demo Credentials

For testing purposes, use the following credentials:

```
Email: test@example.com
Password: password123
```

## Prerequisites

Before running this project, ensure you have:

- Flutter SDK (version compatible with Dart ^3.10.7)
- Dart SDK ^3.10.7
- An IDE such as VS Code, Android Studio, or IntelliJ IDEA
- For mobile testing: Android Studio / Xcode
- For web testing: A modern web browser (Chrome, Firefox, Safari, Edge)

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd sawit
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Check Flutter environment:
   ```bash
   flutter doctor
   ```

4. Run the application:
   ```bash
   # For mobile
   flutter run

   # For web
   flutter run -d chrome

   # For desktop
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```

## Dependencies

- `flutter` - Flutter SDK
- `cupertino_icons` ^1.0.8 - iOS style icons
- `shared_preferences` ^2.3.4 - Local persistent storage for session management

## Project Structure

```
lib/
├── main.dart                 # App entry point and AuthWrapper
├── auth/
│   └── auth_service.dart     # Authentication service with dummy credentials
└── screens/
    ├── login_screen.dart     # Login interface
    ├── dashboard_screen.dart # Main dashboard with responsive layout
    ├── forgot_password_screen.dart
    └── models/
        └── dashboard_data.dart # Dashboard data models
```

## Roadmap

Planned features for future releases:

- [ ] Real backend API integration
- [ ] Database connectivity
- [ ] Enhanced analytics with interactive charts
- [ ] Push notifications
- [ ] Dark mode support
- [ ] Multi-language support
- [ ] Export data functionality
- [ ] User role management

## Contributing

This is a development project. Contributions are welcome through pull requests.

## License

This project is proprietary software.

## Contact

For questions or feedback about this project, please contact the development team.

---

**Note:** This application uses dummy authentication credentials for development and testing purposes. Do not use these credentials in production environments.

## Resources

For additional Flutter learning resources:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)
