class UnboardingContent {
  String image;
  String title;
  String discription;

  UnboardingContent({
    required this.image,
    required this.title,
    required this.discription,
  });
}

List<UnboardingContent> contents = [
  UnboardingContent(
    image: 'assets/images/delivery-service-1.png',
    title: 'Craving Something Delicious?',
    discription: 'From your favorite meals to daily essentials—just a tap away',
  ),
  UnboardingContent(
    image: 'assets/images/pngtree-animated-delivery-1.png',
    title: 'No More Grocery Runs',
    discription:
        'Fresh fruits, snacks, and staples delivered faster than you think.',
  ),
  UnboardingContent(
    image: 'assets/images/delivery-man-ride-scooter-1.png',
    title: 'When Hunger Can’t Wait',
    discription: 'Lightning-fast delivery. Hot, fresh, and always on time.',
  ),
];

class MenuList {
  String name;
  String description;
  String price;
  String image;
  MenuList({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

List<MenuList> foodItems = [
  MenuList(
    name: 'Pizza Margherita',
    description: 'Classic cheese and tomato pizza',
    price: '₹249',
    image: 'https://via.placeholder.com/150',
  ),
  MenuList(
    name: 'Veg Burger',
    description: 'Fresh veg patty with lettuce and cheese',
    price: '₹149',
    image: 'https://via.placeholder.com/150',
  ),
  MenuList(
    name: 'Pasta Alfredo',
    description: 'Creamy white sauce pasta',
    price: '₹199',
    image: 'https://via.placeholder.com/150',
  ),
  MenuList(
    name: 'Paneer Tikka',
    description: 'Grilled cottage cheese with spices',
    price: '₹229',
    image: 'https://via.placeholder.com/150',
  ),
];

 final List<Map<String, String>> banners = [
    {
      'title': 'GASLIGHT',
      'subtitle': '2023 • Hindi • Thriller',
      'image': 'assets/images/black.png',
    },
    {
      'title': 'MODERN FAMILY',
      'subtitle': 'Comedy • Family',
      'image': 'assets/images/White.png',
    },
    // Add more banners here
  ];