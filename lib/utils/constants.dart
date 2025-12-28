/// Image URLs from Unsplash for demo purposes
class AppImages {
  // Bahamas Beach & Ocean
  static const String bahamasBeach1 = 'https://images.unsplash.com/photo-1548574505-5e239809ee19?w=800&q=80';
  static const String bahamasBeach2 = 'https://images.unsplash.com/photo-1509233725247-49e657c54213?w=800&q=80';
  static const String bahamasBeach3 = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80';
  static const String bahamasOcean = 'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80';
  static const String bahamasSunset = 'https://images.unsplash.com/photo-1503803548695-c2a7b4a5b875?w=800&q=80';
  static const String tropicalBeach = 'https://images.unsplash.com/photo-1520454974749-611b7248ffdb?w=800&q=80';
  
  // Hotels & Resorts
  static const String atlantisResort = 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&q=80';
  static const String luxuryResort1 = 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800&q=80';
  static const String luxuryResort2 = 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?w=800&q=80';
  static const String beachResort = 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80';
  static const String poolResort = 'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800&q=80';
  static const String hotelRoom = 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?w=800&q=80';
  static const String hotelLobby = 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?w=800&q=80';
  
  // Islands
  static const String nassauIsland = 'https://images.unsplash.com/photo-1580541631950-7282082b53ce?w=800&q=80';
  static const String paradiseIsland = 'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=800&q=80';
  static const String exumaIsland = 'https://images.unsplash.com/photo-1506929562872-bb421503ef21?w=800&q=80';
  static const String harbourIsland = 'https://images.unsplash.com/photo-1471922694854-ff1b63b20054?w=800&q=80';
  
  // Cars
  static const String jeepWrangler = 'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800&q=80';
  static const String luxuryCar = 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&q=80';
  static const String convertible = 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&q=80';
  static const String suv = 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800&q=80';
  
  // Experiences
  static const String swimmingPigs = 'https://images.unsplash.com/photo-1605379399642-870262d3d051?w=800&q=80';
  static const String snorkeling = 'https://images.unsplash.com/photo-1544551763-77ef2d0cfc6c?w=800&q=80';
  static const String sailing = 'https://images.unsplash.com/photo-1500514966906-fe245eea9344?w=800&q=80';
  static const String diving = 'https://images.unsplash.com/photo-1544551763-8dd44758c2dd?w=800&q=80';
  static const String jetski = 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=80';
  static const String fishing = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800&q=80';
  
  // Flights
  static const String airplane = 'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=800&q=80';
  static const String airport = 'https://images.unsplash.com/photo-1529074963764-98f45c47344b?w=800&q=80';
  
  // Profile & Misc
  static const String avatar1 = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80';
  static const String avatar2 = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80';
  static const String avatar3 = 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80';
  
  // Splash & Onboarding
  static const String splashBg = 'https://images.unsplash.com/photo-1559128010-7c1ad6e1b6a5?w=1200&q=80';
  static const String onboarding1 = 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80';
  static const String onboarding2 = 'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800&q=80';
  static const String onboarding3 = 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80';
  static const String onboarding4 = 'https://images.unsplash.com/photo-1500514966906-fe245eea9344?w=800&q=80';
}

/// Demo data for the app
class DemoData {
  static const List<Map<String, dynamic>> hotels = [
    {
      'name': 'Atlantis Paradise Island',
      'location': 'Paradise Island',
      'type': 'Beachfront Resort',
      'price': 450,
      'rating': 4.8,
      'reviews': 2345,
      'isVerified': true,
      'image': AppImages.atlantisResort,
      'amenities': ['Pool', 'Spa', 'Beach', 'Restaurant', 'Gym', 'WiFi'],
    },
    {
      'name': 'Sandals Royal Bahamian',
      'location': 'Nassau',
      'type': 'All-Inclusive',
      'price': 380,
      'rating': 4.9,
      'reviews': 1876,
      'isVerified': true,
      'image': AppImages.luxuryResort1,
      'amenities': ['All-Inclusive', 'Pool', 'Spa', 'Beach', 'Water Sports'],
    },
    {
      'name': 'Baha Mar Resort',
      'location': 'Nassau',
      'type': 'Luxury Resort',
      'price': 520,
      'rating': 4.7,
      'reviews': 1543,
      'isVerified': true,
      'image': AppImages.luxuryResort2,
      'amenities': ['Casino', 'Golf', 'Pool', 'Spa', 'Fine Dining'],
    },
    {
      'name': 'Grand Hyatt Baha Mar',
      'location': 'Nassau',
      'type': 'Ocean View',
      'price': 320,
      'rating': 4.6,
      'reviews': 987,
      'isVerified': true,
      'image': AppImages.beachResort,
      'amenities': ['Pool', 'Beach', 'Restaurant', 'Gym', 'WiFi'],
    },
    {
      'name': 'Rosewood Baha Mar',
      'location': 'Nassau',
      'type': 'Luxury Resort',
      'price': 580,
      'rating': 4.9,
      'reviews': 654,
      'isVerified': false,
      'image': AppImages.poolResort,
      'amenities': ['Butler Service', 'Private Beach', 'Spa', 'Fine Dining'],
    },
  ];

  static const List<Map<String, dynamic>> cars = [
    {
      'name': 'Toyota Corolla',
      'type': 'Economy',
      'transmission': 'Automatic',
      'price': 45,
      'seats': 4,
      'features': ['A/C', 'Bluetooth', 'USB'],
      'image': AppImages.suv,
      'isPopular': false,
    },
    {
      'name': 'Jeep Wrangler',
      'type': 'SUV',
      'transmission': '4WD',
      'price': 85,
      'seats': 5,
      'features': ['A/C', 'GPS', 'Convertible Top'],
      'image': AppImages.jeepWrangler,
      'isPopular': true,
    },
    {
      'name': 'BMW 3 Series',
      'type': 'Luxury',
      'transmission': 'Automatic',
      'price': 120,
      'seats': 5,
      'features': ['A/C', 'Premium Sound', 'Leather'],
      'image': AppImages.luxuryCar,
      'isPopular': false,
    },
    {
      'name': 'Ford Mustang',
      'type': 'Convertible',
      'transmission': 'Automatic',
      'price': 150,
      'seats': 4,
      'features': ['A/C', 'Premium Sound', 'Convertible'],
      'image': AppImages.convertible,
      'isPopular': true,
    },
  ];

  static const List<Map<String, dynamic>> experiences = [
    {
      'name': 'Swimming with Pigs',
      'location': 'Exuma',
      'duration': '6 hours',
      'type': 'Small group',
      'price': 250,
      'rating': 4.9,
      'reviews': 1234,
      'isVerified': true,
      'image': AppImages.tropicalBeach,
    },
    {
      'name': 'Snorkeling Adventure',
      'location': 'Nassau',
      'duration': '4 hours',
      'type': 'All levels',
      'price': 85,
      'rating': 4.7,
      'reviews': 876,
      'isVerified': false,
      'image': AppImages.snorkeling,
    },
    {
      'name': 'Sunset Sailing Cruise',
      'location': 'Paradise Island',
      'duration': '3 hours',
      'type': 'Romantic',
      'price': 120,
      'rating': 4.8,
      'reviews': 543,
      'isVerified': true,
      'image': AppImages.sailing,
    },
    {
      'name': 'Deep Sea Fishing',
      'location': 'Nassau',
      'duration': '8 hours',
      'type': 'Private charter',
      'price': 450,
      'rating': 4.6,
      'reviews': 234,
      'isVerified': true,
      'image': AppImages.bahamasOcean,
    },
  ];

  static const List<Map<String, dynamic>> islands = [
    {
      'name': 'Nassau',
      'properties': 245,
      'image': AppImages.nassauIsland,
    },
    {
      'name': 'Paradise Island',
      'properties': 128,
      'image': AppImages.paradiseIsland,
    },
    {
      'name': 'Exuma',
      'properties': 89,
      'image': AppImages.exumaIsland,
    },
    {
      'name': 'Harbour Island',
      'properties': 67,
      'image': AppImages.harbourIsland,
    },
  ];
}

