import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';
import 'screens/onboarding/splash_screen.dart';
import 'services/storage_service.dart';
import 'services/api_client.dart';
import 'services/auth_service.dart';
import 'services/listing_service.dart';
import 'services/booking_service.dart';
import 'services/user_service.dart';
import 'services/points_service.dart';
import 'services/message_service.dart';
import 'services/review_service.dart';
import 'services/coupon_service.dart';
import 'providers/auth_provider.dart';
import 'providers/stays_provider.dart';
import 'providers/cars_provider.dart';
import 'providers/experiences_provider.dart';
import 'providers/bookings_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/messages_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize storage
  final storage = StorageService();
  await storage.init();

  // Initialize API client and services
  final apiClient = ApiClient(storage);
  final authService = AuthService(apiClient);
  final listingService = ListingService(apiClient);
  final bookingService = BookingService(apiClient);
  final userService = UserService(apiClient);
  final pointsService = PointsService(apiClient);
  final messageService = MessageService(apiClient);
  final reviewService = ReviewService(apiClient);
  final couponService = CouponService(apiClient);

  runApp(BahamaVistaApp(
    storage: storage,
    apiClient: apiClient,
    authService: authService,
    listingService: listingService,
    bookingService: bookingService,
    userService: userService,
    pointsService: pointsService,
    messageService: messageService,
    reviewService: reviewService,
    couponService: couponService,
  ));
}

class BahamaVistaApp extends StatelessWidget {
  final StorageService storage;
  final ApiClient apiClient;
  final AuthService authService;
  final ListingService listingService;
  final BookingService bookingService;
  final UserService userService;
  final PointsService pointsService;
  final MessageService messageService;
  final ReviewService reviewService;
  final CouponService couponService;

  const BahamaVistaApp({
    super.key,
    required this.storage,
    required this.apiClient,
    required this.authService,
    required this.listingService,
    required this.bookingService,
    required this.userService,
    required this.pointsService,
    required this.messageService,
    required this.reviewService,
    required this.couponService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authService, storage, apiClient),
        ),
        ChangeNotifierProvider(
          create: (_) => StaysProvider(listingService),
        ),
        ChangeNotifierProvider(
          create: (_) => CarsProvider(listingService),
        ),
        ChangeNotifierProvider(
          create: (_) => ExperiencesProvider(listingService),
        ),
        ChangeNotifierProvider(
          create: (_) => BookingsProvider(bookingService),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(userService),
        ),
        ChangeNotifierProvider(
          create: (_) => MessagesProvider(messageService),
        ),
        Provider.value(value: listingService),
        Provider.value(value: userService),
        Provider.value(value: pointsService),
        Provider.value(value: reviewService),
        Provider.value(value: couponService),
      ],
      child: MaterialApp(
        title: 'BahamaVista',
        debugShowCheckedModeBanner: false,
        theme: BahamaTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
