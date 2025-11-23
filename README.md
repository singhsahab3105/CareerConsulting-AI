# Career Consulting-AI

This is a **Flutter Web** application that acts like a mini **career counselling portal**.
It was designed as a **college major project**, not just as a coding demo, so the code
is structured and commented like a real-world student project.

## Features

- Clean landing dashboard with short project introduction.
- Two core flows:
  1. **Comprehensive Assessment** – For students who are confused about their career.
  2. **Chatbot Q&A** – For students who already have some idea and want specific answers.
- Integration with **Google Gemini** models using the REST API.
- Uses **Riverpod** for state management (simple and testable).
- Responsive layout (works on laptop and mobile).

## Running the project

1. Install Flutter (3.x) and enable web support.
2. From the project root:

   ```bash
   flutter pub get
   flutter run -d chrome
   ```

3. Open the app in the browser.
4. Add your **Gemini API key** in `lib/providers.dart`:

   ```dart
   const String kGeminiApiKey = "PUT_YOUR_GEMINI_KEY_HERE";
   ```

> **Note:** For a college project it is acceptable to keep the key here, but in real
> production apps secrets should be moved to a secure backend instead.

## Folder structure (short)

- `lib/main.dart` – Entry point
- `lib/theme/app_theme.dart` – Centralized colors and theme
- `lib/models/` – Simple data models (career profile, chat message)
- `lib/services/gemini_service.dart` – Gemini REST API wrapper
- `lib/providers.dart` – Riverpod providers
- `lib/screens/` – UI screens (dashboard, assessment, chatbot)
- `lib/widgets/` – Reusable small UI components

You can freely modify the text, logos and layout to match your college or company.
