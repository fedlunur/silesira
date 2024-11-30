import 'package:afrotieapp/models/product_model.dart';
import 'package:afrotieapp/widgets/PropertyCard.dart';
import 'package:afrotieapp/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'search_and_filter_page.dart'; // Ensure this points to your actual product model

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<String> _categories = [
    'Houses',
    'Cars',
    'Others',
    'Jobs',
    'Sponsored',
    'Services',
    'Wanted',
    'Lost/Found',
    'Free',
  ];

  List<String> selectedCategories = [];
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filtered properties based on search query and selected categories
    final filteredProducts = products.where((product) {
      final matchesCategory = selectedCategories.isEmpty ||
          selectedCategories.contains(product.category);
      final matchesSearchQuery = searchQuery.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearchQuery;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          // Search and Filter Section
          SearchAndFilterPage(
            categories: _categories, // Pass the categories list
           // products: products, // Pass the products list
            onFilterChanged: (filters) {
              setState(() {
                selectedCategories = filters;
              });
            },
            onSearchQueryChanged: (query) {
              setState(() {
                searchQuery = query;
              });
            },
          ),

          // Properties Grid Section
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No properties found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 3 : 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return PropertyCard(product: product);
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/add');
              break;
            case 2:
              context.go('/notifications');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
