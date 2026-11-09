# Daund Delivery – Flutter MVP starter

This is a Flutter Android app **source project starter**, not a compiled APK and not a production backend.

## Included
- Customer home screen with six service categories
- Demo product list and in-memory cart
- Role switcher for Customer, Shopkeeper, Delivery Partner, Admin
- Demo order status screen
- Marathi-first interface

## Run
1. Install Flutter SDK and Android Studio.
2. From this folder run: `flutter pub get`
3. Connect an Android phone with USB debugging enabled, or start an emulator.
4. Run: `flutter run`
5. To build an APK: `flutter build apk --release`
   Output: `build/app/outputs/flutter-apk/app-release.apk`

## Important before launch
This starter uses demo data only. It does not yet include real OTP authentication, cloud database,
live GPS, payment gateway, push notifications, shop onboarding, or a secure admin backend.
Those require backend setup, API credentials, privacy/security review, and testing.

## Suggested production architecture
- Flutter Android client
- Firebase Authentication (phone OTP)
- Cloud Firestore / server-side Cloud Functions
- Firebase Cloud Messaging
- Google Maps / location permissions
- Payment provider integration after merchant onboarding
- Role-based server authorization (customer/shopkeeper/rider/admin)
