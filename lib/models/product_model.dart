class Product {
  final String name;
  final String imageUrl;
  final String price;
  final String category;
  final String?
      subcategory; // Optional to accommodate items without subcategories

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    this.subcategory,
  });
}

List<Product> products = [
  // Houses
  Product(
    name: 'Luxury Villa in Addis Ababa',
    imageUrl: 'assets/images/image.png',
    price: '15,000,000 birr',
    category: 'Houses',
    subcategory: 'For Sale',
  ),
  Product(
    name: '2-Bedroom Apartment in Bole',
    imageUrl: 'assets/images/logo.png',
    price: '3,500,000 birr',
    category: 'Houses',
    subcategory: 'For Rent',
  ),

  // Cars
  Product(
    name: '2020 Toyota Land Cruiser',
    imageUrl: 'assets/images/image.png',
    price: '8,500,000 birr',
    category: 'Cars',
    subcategory: 'For Sale',
  ),
  Product(
    name: '2019 Hyundai Sonata',
    imageUrl: 'assets/images/logo.png',
    price: '3,200,000 birr',
    category: 'Cars',
    subcategory: 'For Rent',
  ),

  // Others
  Product(
    name: 'Mountain Bike',
    imageUrl: 'assets/images/image.png',
    price: '12,000 birr',
    category: 'Others',
    subcategory: 'Motorcycles-Bicycles',
  ),

  // Jobs
  Product(
    name: 'Software Engineer Position',
    imageUrl: 'assets/images/logo.png',
    price: 'Negotiable',
    category: 'Jobs',
    subcategory: 'Computer Science',
  ),

  // Services
  Product(
    name: 'Professional Cleaning Services',
    imageUrl: 'assets/images/logo.png',
    price: '5,000 birr',
    category: 'Services',
    subcategory: 'Cleaning Service',
  ),

  // Additional categories...
];
