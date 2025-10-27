# Falcom Track Mobile App

This folder contains the Flutter client for the Falcom geofencing attendance system.  In week 1 the app consists of a single screen with username and password fields and a login button.  There is no business logic yet.

## Cloning this repository

To fetch the Flutter app sources you can clone the public repository hosted on GitHub:

````bash
git clone https://github.com/Falcom-Geofence/falcom-track-app.git
```

After cloning the repository you can navigate into `falcom-track-app` and follow the instructions below to run or build the app.

## Getting started

> **Note:** The repository does not include the full set of generated platform folders (`android/` and `ios/`).  These are created automatically when the Docker image builds or when you run `flutter create` locally.

To develop the app locally:

1. Install Flutter 3 (including the Android and iOS toolchains).  Follow the official installation instructions for your platform.
2. Navigate into the mobile app directory:
   ```bash
   cd falcom-track-app
   ```
3. If this is your first time opening the project, generate the missing platform folders and download dependencies:
   ```bash
   flutter create .
   flutter pub get
   ```
4. Run the app on a simulator or connected device:
   ```bash
   flutter run
   ```
   You should see the login placeholder screen.

## Building with Docker

The `Dockerfile` in this directory uses the [Cirrus Labs Flutter image](https://github.com/cirruslabs/docker-images-flutter) to build the application for both Android and iOS.  This is useful for verifying that the code compiles without having Flutter installed locally.

To build the app inside Docker and confirm that it compiles, run the following command from the repository root:

```bash
docker build --rm -f falcom-track-app/Dockerfile falcom-track-app
```

The build process will:

1. Install dependencies defined in `pubspec.yaml`.
2. Create missing `android` and `ios` folders (equivalent to `flutter create .`).
3. Copy your source files back over the generated code.
4. Build release versions of the app for Android (`build/app/outputs/flutter-apk/app-release.apk`) and iOS (`build/ios/iphoneos/Runner.app`).

Those artefacts are saved in the `/build` directory of the final image.  In the `docker-compose` stack this service is defined as `mobile` purely so that `docker-compose up --build` will run the build and surface any compile errors.

## Future work

Later weeks will add real authentication and geofencing functionality.  For now the purpose of this project is to ensure that a Flutter skeleton exists and that it builds successfully for both Android and iOS.
