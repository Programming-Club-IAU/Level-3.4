# Flutter Firebase Chat App

## Overview

This project is a minimal chat application built using Flutter and Firebase. The app allows users to send and receive messages in real-time.

## Features

* User Authentication: Users can sign up, sign in, and sign out securely using Firebase Authentication.
* Real-time Messaging: Messages are sent and received instantly using Firebase Firestore as the real-time database.
* Minimalistic UI: The app features a clean and user-friendly interface for seamless communication.

## Technologies Used

* Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* Firebase Authentication: Provides backend services, easy-to-use SDKs, and ready-made UI libraries to authenticate users.
* Firebase Firestore: A NoSQL cloud database to store and sync data in real-time.

## Project Requirement 
Watch this video for details on what to include in the task.
* [Features Video](https://www.youtube.com/watch?v=Ci0NTh6Jh3U&ab_channel=MitchKoko)

 ## Video

* [Provider Creation | Video](https://www.youtube.com/watch?v=5xU5WH2kEc0&ab_channel=MitchKoko)

## Important Concepts
Setting up the Firebase
 
# Setting Up Firebase for Flutter Project

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Click on "Add Project" and follow the prompts to create a new project.
3. Give your project a name and click "Continue".
4. (Optional) Enable Google Analytics for your project and click "Continue".
5. Click "Create project" to finish setting up your Firebase project.

## Step 2: Register Your App with Firebase

### For Android:

1. Go to your Firebase project in the Firebase Console.
2. Click on the Android icon to add your Flutter app to Firebase.
3. Enter your Android package name (found in your Flutter project's `android/app/build.gradle` file).
4. (Optional) Enter other details like app nickname, debug signing certificate SHA-1, etc.
5. Click "Register app" to continue.
6. Download the `google-services.json` file and place it in the `android/app` directory of your Flutter project.

### For iOS:

1. Go to your Firebase project in the Firebase Console.
2. Click on the iOS icon to add your Flutter app to Firebase.
3. Enter your iOS bundle ID (found in your Flutter project's `ios/Runner.xcodeproj/project.pbxproj` file).
4. (Optional) Enter other details like app nickname.
5. Click "Register app" to continue.
6. Download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory of your Flutter project.

## Step 3: Add Firebase SDK to Your App

1. Open your Flutter project.
2. Update the `pubspec.yaml` file to include the Firebase SDK dependencies. Add the following lines under `dependencies`:

   ```yaml
   dependencies:
     firebase_core: ^1.10.0
     firebase_auth: ^4.4.0
     cloud_firestore: ^3.1.0
3. Run flutter pub get in the terminal to fetch the dependencies.

## Step 4: Initialize Firebase in Your App
1. In your Flutter project, open the main.dart file.
2. Import the Firebase packages at the top of the file using:
   ```dart
   import 'package:firebase_core/firebase_core.dart';"
   ```
4. Initialize Firebase in the main() function before calling runApp():

   ```dart
    void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      runApp(MyApp());
    }
    ```

### Step 5: Test Firebase Integration
1. Run your Flutter app on an emulator or physical device.
2. Verify that your app launches without errors and that Firebase is initialized successfully.
3. You can then proceed to use Firebase Authentication, Firestore, or other Firebase services in your app.
   
### Additional Resources (Documents)
[Firebase Documentation](https://firebase.google.com/docs)

Following these steps should help you set up Firebase for your Flutter project, even if you're a beginner. Feel free to ask if you have any questions or encounter any issues along the way! Goodluck.
