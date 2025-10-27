# Build the Flutter mobile application inside a container.
# This file uses the official Cirrus Labs Flutter image to ensure that
# Android and iOS toolchains are installed.  On build the container
# generates a fresh Flutter project if platform directories are missing,
# installs dependencies, and then builds both Android and iOS artefacts.

FROM ghcr.io/cirruslabs/flutter:3.19.2 as build

WORKDIR /app

# Copy the pubspec first and fetch dependencies
COPY pubspec.yaml .
RUN flutter pub get

COPY . .

# If the android/ios folders are not present (for example when this is a
# brand‑new project), run flutter create to generate them.  The "--project-name"
# flag ensures that underscores are replaced correctly for package names.
RUN if [ ! -d "android" ]; then \
    flutter create . --project-name falcom_track_app --org com.falcom; \
  fi

# Copy our source again in case flutter create overwrote lib/main.dart
COPY lib ./lib
RUN flutter pub get

# Build the application for Android and iOS.  The iOS build is run with
# --no-codesign so that it completes without requiring signing certificates.
RUN flutter build apk --release
RUN flutter build ios --release --no-codesign

# A final minimal stage that exposes the built artefacts.  We don't run the app
# inside Docker; instead this container's purpose is to confirm that the app
# compiles.  Built files can be extracted from /app/build if needed.
FROM scratch as export
COPY --from=build /app/build /build
