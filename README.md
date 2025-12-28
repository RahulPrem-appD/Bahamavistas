# BahamaVista 🌴

A luxury-island travel app for the Bahamas with a modern-minimalist aesthetic. This is a **complete static demo** showcasing the full user experience with beautiful real images.

![BahamaVista](https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=1200&q=80)

## ✨ Features

### 🎨 Design System
- **Bahama Sea Gradient**: `#DFF7F7` → `#CFEFF0` → `#B7E4E6` - Sky-to-sea wash
- **Island Blue Accent**: `#6BBFC9`, `#4FAEB8`, `#3A98A6`
- **Sunlit Yellow CTA**: `#F7C96B` → `#F5B953` - Sunset glow gradient
- **Deep Ocean Teal**: `#2E6F75` for text emphasis
- **Poppins Typography** via Google Fonts

### 📱 Complete User Flow

#### 1. Onboarding
- Beautiful full-screen image backgrounds
- 4-step feature introduction carousel
- Smooth page transitions
- Skip option

#### 2. Authentication
- Email/social login (Google, Apple, Facebook)
- Account registration with validation
- Profile setup with travel style selection
- Payment method configuration

#### 3. Home & Discovery
- Category tabs: Hotels, Cars, Flights, Experiences, Dining
- Popular islands carousel with real images
- Featured hotels with ratings & verified badges
- Favorites & notifications quick access
- Staggered list animations

#### 4. Search & Filters
- Full-text search with filter sheet
- Price range slider
- Rating filter
- Verified vendors toggle
- Island multi-select
- Results with shimmer loading

#### 5. Booking Flow
- Hotel gallery with page indicators
- Date picker with night calculation
- Guest & room selector
- Real-time price breakdown
- Payment method selection
- Animated confirmation screen

#### 6. Trip Management
- Upcoming, Active, Past tabs
- Trip cards with status badges
- Modify & view actions
- Confirmation codes

#### 7. Chat & Support
- Vendor messaging
- 24/7 support chat
- Quick reply suggestions
- Unread indicators

#### 8. Profile & Settings
- Profile with stats
- Favorites management
- Notifications center
- Full settings screen
- Currency & language options
- Dark mode toggle

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  cupertino_icons: ^1.0.8
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  flutter_staggered_animations: ^1.1.1
  intl: ^0.19.0
```

## 🏗️ Project Structure

```
lib/
├── main.dart
├── theme/
│   ├── colors.dart           # Color palette
│   └── theme.dart            # ThemeData
├── utils/
│   └── constants.dart        # Images & demo data
├── widgets/
│   ├── bahama_button.dart    # Gradient buttons
│   ├── bahama_card.dart      # Styled cards
│   ├── bahama_text_field.dart # Inputs & search
│   ├── date_picker.dart      # Date selection
│   └── network_image.dart    # Cached images
└── screens/
    ├── onboarding/
    │   ├── splash_screen.dart
    │   └── onboarding_screen.dart
    ├── auth/
    │   ├── login_screen.dart
    │   ├── signup_screen.dart
    │   ├── profile_setup_screen.dart
    │   └── payment_setup_screen.dart
    ├── home/
    │   ├── main_navigation.dart
    │   ├── home_screen.dart
    │   ├── search_screen.dart
    │   ├── profile_screen.dart
    │   ├── favorites_screen.dart
    │   ├── notifications_screen.dart
    │   └── settings_screen.dart
    ├── booking/
    │   ├── hotel_detail_screen.dart
    │   ├── booking_screen.dart
    │   └── confirmation_screen.dart
    ├── trips/
    │   └── trips_screen.dart
    └── chat/
        ├── chat_list_screen.dart
        └── chat_detail_screen.dart
```

## 🚀 Getting Started

```bash
# Clone and navigate
cd bahamavista

# Get dependencies
flutter pub get

# Run on iOS Simulator
flutter run -d ios

# Run on Android Emulator
flutter run -d android

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release
```

## 📸 Images

All images are loaded from Unsplash and cached locally:
- Beach & ocean scenes
- Luxury resorts & hotels
- Island landscapes
- Cars & vehicles
- Experience activities
- User avatars

## 🎯 Demo Highlights

1. **Real Images**: Beautiful Bahamas-themed photos throughout
2. **Smooth Animations**: Staggered lists, page transitions, success animations
3. **Shimmer Loading**: Elegant loading states for images
4. **Interactive Filters**: Working price/rating sliders
5. **Date Picker**: Native date selection with night calculation
6. **Guest Selector**: Increment/decrement for adults, children, rooms
7. **Complete Navigation**: All screens connected and functional

## 📋 Design Specifications

| Element | Specification |
|---------|---------------|
| Buttons | 28px radius, yellow gradient, light shadow |
| Cards | 20px radius, white/aqua, 8% opacity shadow |
| Navigation | White background, Island Blue selected |
| Icons | Thin-line style, Island Blue color |
| Typography | Poppins, generous white space |

---

**Built with Flutter** • *A static prototype for client demonstration*
