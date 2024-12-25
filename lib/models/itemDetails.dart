// property_model.dart
class PropertyModel {
  final String category;
  final String title;
  final double? price;
  final List<String> images;
  final String saleOrRent;
  final int? bedrooms;
  final int? bathrooms;
  final double? squareMeters;
  final String? propertyType;
  final String? brand;
  final String? model;
  final String? carType;
  final String city;
  final String description;
  final String contact;

  PropertyModel({
    required this.category,
    required this.title,
    this.price,
    required this.images,
    required this.saleOrRent,
    this.bedrooms,
    this.bathrooms,
    this.squareMeters,
    this.propertyType,
    this.brand,
    this.model,
    this.carType,
    required this.city,
    required this.description,
    required this.contact,
  });
}

// Sample mock data
final List<PropertyModel> mockProperties = [
  PropertyModel(
    category: 'house',
    title: 'Modern Family Home',
    price: 120000,
    images: [
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
    ],
    saleOrRent: 'For Sale',
    bedrooms: 4,
    bathrooms: 3,
    squareMeters: 180,
    propertyType: 'Villa',
    city: 'Addis Ababa',
    description:
        'A spacious family home with modern amenities and a beautiful garden.',
    contact: 'John Doe, Phone: +251912345678',
  ),
  PropertyModel(
    category: 'car',
    title: 'Toyota Corolla 2020',
    price: 20000,
    images: [
      'https://via.placeholder.com/300',
      'https://via.placeholder.com/300',
    ],
    saleOrRent: 'For Sale',
    brand: 'Toyota',
    model: 'Corolla',
    carType: 'Sedan',
    city: 'Adama',
    description: 'A reliable car in excellent condition with low mileage.',
    contact: 'Jane Smith, Phone: +251912987654',
  ),
];
