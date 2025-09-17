# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Guide is a Flutter-based AI-powered text adventure game that generates dynamic stories using Google's Gemini API. The game allows users to choose from predefined story prompts or create custom scenarios, with the AI acting as the game master.

## Development Commands

### Setup
```bash
# Install dependencies
flutter pub get

# Set up environment variables (create .env file with GEMINI_KEY)
```

### Development
```bash
# Run the app
flutter run

# Hot reload is enabled by default in debug mode
```

### Code Generation
```bash
# Generate code for freezed/json_serializable
dart run build_runner build

# Watch for changes and regenerate
dart run build_runner watch
```

### Testing and Analysis
```bash
# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .
```

### Build
```bash
# Build for production
flutter build apk          # Android
flutter build ios          # iOS
flutter build macos        # macOS
flutter build web          # Web
```

## Architecture

### Core Structure
- `lib/main.dart` - Entry point, initializes AppConfig and runs the app
- `lib/src/model/` - Data models (StoryIntro, AppConfig)
- `lib/src/screen/` - UI screens (WelcomeScreen, ChooseStoryScreen, CharacterNameScreen)
- `lib/src/widget/` - Reusable UI components
- `lib/src/ai/` - AI integration layer (AiClient for Gemini API)
- `lib/src/common/` - Shared constants and prompts

### Key Components
- **AppConfig**: Singleton for managing app configuration and API keys, uses flutter_dotenv
- **AiClient**: HTTP client wrapper for Gemini API communication
- **StoryIntro**: Equatable model for story prompts with title, description, and genre

### State Management
Currently uses basic StatefulWidget pattern. No external state management library is implemented.

### Code Style
- Uses double quotes (enforced by linter)
- Requires trailing commas
- Prefers const constructors and final fields
- Uses package imports instead of relative imports
- Generated files (*.g.dart) are excluded from analysis

### Environment Setup
- Requires `.env` file with `GEMINI_KEY` for API access
- Uses flutter_dotenv for environment variable management
- API key accessed via `String.fromEnvironment("GEMINI_KEY")`