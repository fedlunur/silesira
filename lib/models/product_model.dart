class Product {
  final String name;
  final String imageUrl;
  final String? price;
  final String category;
  final String? subcategory;
  final String description;
  final List<String> images;
  final String saleOrRent;
  final String? contact;

  // House-specific fields
  final int? bedrooms;
  final int? bathrooms;
  final double? squareMeters;
 // final String? propertyType;

  // Car-specific fields
  final String? brand;
  final String? model;
  //final String? carType;

  Product({
    required this.name,
    required this.imageUrl,
    this.price,
    required this.category,
    this.subcategory,
    required this.description,
    required this.images,
    required this.saleOrRent,
    this.contact,
    this.bedrooms,
    this.bathrooms,
    this.squareMeters,
    //this.propertyType,
    this.brand,
    this.model,
    //this.carType,
  });
}

// Mock Data
List<Product> products = [
  Product(
    name: 'Modern Family Home',
    imageUrl: 'assets/images/image.png',
    price: '120,000 USD',
    category: 'Houses',
    subcategory: 'Villa',
    description:
        'A spacious family home with modern amenities and a beautiful garden.',
    images: [
      'https://th.bing.com/th/id/OIP.O9nIGE4tMlRXgNs7GmFFLgHaE8?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.11f731bbd2873f053162c34fa8290fd5?rik=icVk0AJMp9oQzA&riu=http%3a%2f%2fmessagenote.com%2fwp-content%2fuploads%2f2011%2f04%2ftruscany-villa.jpg&ehk=8iTNr8kqps7FTKvrlSCs3v6i0TnlT538id7qzYuWQl0%3d&risl=&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    bedrooms: 4,
    bathrooms: 3,
    squareMeters: 180,
    //propertyType: 'Villa',
    contact: 'John Doe',
  ),
  Product(
    name: 'Modern Family Home',
    imageUrl: 'assets/images/image.png',
    price: '120,000 USD',
    category: 'Houses',
    subcategory: 'Villa',
    description:
        'A spacious family home with modern amenities and a beautiful garden.',
    images: [
      'https://th.bing.com/th/id/OIP.O9nIGE4tMlRXgNs7GmFFLgHaE8?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.11f731bbd2873f053162c34fa8290fd5?rik=icVk0AJMp9oQzA&riu=http%3a%2f%2fmessagenote.com%2fwp-content%2fuploads%2f2011%2f04%2ftruscany-villa.jpg&ehk=8iTNr8kqps7FTKvrlSCs3v6i0TnlT538id7qzYuWQl0%3d&risl=&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    bedrooms: 4,
    bathrooms: 3,
    squareMeters: 180,
    //propertyType: 'Villa',
    contact: 'John Doe ',
  ),
  Product(
    name: 'Modern Family Home',
    imageUrl: 'assets/images/image.png',
    price: '120,000 USD',
    category: 'Houses',
    subcategory: 'Villa',
    description:
        'A spacious family home with modern amenities and a beautiful garden.',
    images: [
      'https://th.bing.com/th/id/OIP.O9nIGE4tMlRXgNs7GmFFLgHaE8?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.11f731bbd2873f053162c34fa8290fd5?rik=icVk0AJMp9oQzA&riu=http%3a%2f%2fmessagenote.com%2fwp-content%2fuploads%2f2011%2f04%2ftruscany-villa.jpg&ehk=8iTNr8kqps7FTKvrlSCs3v6i0TnlT538id7qzYuWQl0%3d&risl=&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    bedrooms: 4,
    bathrooms: 3,
    squareMeters: 180,
    //propertyType: 'Villa',
    contact: 'John Doe',
  ),
  Product(
    name: 'Toyota Corolla 2020',
    imageUrl: 'assets/images/image.png',
    price: '20,000 USD',
    category: 'Cars',
    subcategory: 'Sedan',
    description: 'A reliable car in excellent condition with low mileage.',
    images: [
      'https://th.bing.com/th/id/OIP.9AA9ELQUr6WsoCJ2WcVcEwHaEK?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.a6a1217cf17dbe4166b1b50c2e650543?rik=gmndIBtCTgbtsA&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    brand: 'Toyota',
    model: 'Corolla',
    //carType: 'Sedan',
    contact: 'Jane Smith',
  ),
  Product(
    name: 'Toyota Corolla 2020',
    imageUrl: 'assets/images/image.png',
    price: '20,000 USD',
    category: 'Cars',
    subcategory: 'Sedan',
    description: 'A reliable car in excellent condition with low mileage.',
    images: [
      'https://th.bing.com/th/id/OIP.9AA9ELQUr6WsoCJ2WcVcEwHaEK?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.a6a1217cf17dbe4166b1b50c2e650543?rik=gmndIBtCTgbtsA&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    brand: 'Toyota',
    model: 'Corolla',
    //carType: 'Sedan',
    contact: 'Jane Smith',
  ),
  Product(
    name: 'Toyota Corolla 2020',
    imageUrl: 'assets/images/image.png',
    price: '20,000 USD',
    category: 'Cars',
    subcategory: 'Sedan',
    description: 'A reliable car in excellent condition with low mileage.',
    images: [
      'https://th.bing.com/th/id/OIP.9AA9ELQUr6WsoCJ2WcVcEwHaEK?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/R.a6a1217cf17dbe4166b1b50c2e650543?rik=gmndIBtCTgbtsA&pid=ImgRaw&r=0'
    ],
    saleOrRent: 'For Sale',
    brand: 'Toyota',
    model: 'Corolla',
    //carType: 'Sedan',
    contact: 'Jane Smith',
  ),
];
