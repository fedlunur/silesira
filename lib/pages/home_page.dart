import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:afrotieapp/models/product_model.dart';
import 'package:go_router/go_router.dart'; // Ensure this import points to your actual product model

class Home_Page extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {
  int _currentIndex = 0;
  bool _isSearching = false; // Toggle between search icon and search bar
  String _searchQuery = ''; // Holds the search query text
  List<String> selectedCategories = []; // Multi-select categories

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF112D4E),
        title: _isSearching
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                  });
                },
              )
            : const Text('Home', style: TextStyle(color: Colors.white)),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchQuery = '';
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                ),
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Bar
          Container(
            color: const Color(0xFFDBE2EF),
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.01,
              horizontal: screenWidth * 0.03,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.02),
                    child: _buildFilterChip(category),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: HomeScreen(
              selectedCategories: selectedCategories,
              searchQuery: _searchQuery,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF3F72AF),
        buttonBackgroundColor: const Color(0xFF112D4E),
        height: screenHeight * 0.08,
        index: _currentIndex,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
          Icon(Icons.notifications, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;

            switch (index) {
              case 0:
                context.go('/home'); // Navigate to HomePage
                break;
              case 1:
                context.go('/add'); // Navigate to Add Page
                break;
              case 2:
                context.go('/profile'); // Navigate to ProfilePage
                break;
              case 3:
                context.go('/notifications'); // Navigate to NotificationsPage
                break;
            }
          });
        },
      ),
    );
  }

  // Build Filter Chips (Multi-Select)
  Widget _buildFilterChip(String category) {
    final isSelected = selectedCategories.contains(category);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedCategories.remove(category);
          } else {
            selectedCategories.add(category);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3F72AF) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF3F72AF) : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Show Filter Dialog
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String selectedMainCategory = '';
        String selectedSubCategory = '';

        // Options for the popup
        final Map<String, List<String>> filterOptions = {
          'Houses': ['For Sale', 'For Rent'],
          'Cars': ['For Sale', 'For Rent'],
          'Others': [
            'Electronics',
            'Clothings',
            'Furnitures',
            'Beauty-Health',
            'Baby Stuff',
            'Jewelry',
            'Motorcycles-Bicycles',
            'Paintings',
            'Books-Gamings-Movies',
            'Pets',
            'Machineries'
          ],
          'Jobs': [
            'HR',
            'Accounting',
            'Art-Camera & Videography',
            'Agriculture',
            'Banking-Insurance',
            'Computer Science',
            'Social Science',
            'Customer Service',
            'Economics',
            'Engineering',
            'Education',
            'Healthcare',
            'Hotel-Hospitality',
            'Legal',
            'Journalism',
            'Pharmaceutical',
            'Sales-Marketing-Advertising',
            'Secretarial',
            'Security',
          ],
          'Services': [
            'Accounting',
            'Camera',
            'Web-App-IT',
            'Beauty Salon',
            'Gardening',
            'Dish Service',
            'Tutor Service',
            'Cleaning Service',
            'Woodwork',
            'Printing-Advertisement',
            'Electrician',
            'Auto Mechanic',
            'Plumbing',
            'Aluminum-Glass',
          ],
        };

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                selectedMainCategory.isEmpty
                    ? 'Filter Results'
                    : 'Select Subcategory',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (selectedMainCategory.isEmpty)
                      // Main Category Buttons
                      ...filterOptions.keys.map((category) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedMainCategory = category;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F72AF),
                          ),
                          child: Text(
                            category,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList()
                    else
                      // Subcategory Buttons with Scrolling
                      SingleChildScrollView(
                        child: Column(
                          children: filterOptions[selectedMainCategory]!
                              .map((subCategory) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedSubCategory = subCategory;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    selectedSubCategory == subCategory
                                        ? const Color(0xFF3F72AF)
                                        : Colors.grey,
                              ),
                              child: Text(
                                subCategory,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              actions: [
                if (selectedMainCategory.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedMainCategory = '';
                        selectedSubCategory = '';
                      });
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Color(0xFF3F72AF)),
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    if (selectedMainCategory.isNotEmpty &&
                        selectedSubCategory.isNotEmpty) {
                      // Update the selected categories when applying filter
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Filtered by $selectedMainCategory > $selectedSubCategory',
                          ),
                        ),
                      );
                      setState(() {
                        selectedCategories.add(selectedMainCategory);
                      });
                    } else if (selectedMainCategory.isNotEmpty) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Filtered by $selectedMainCategory',
                          ),
                        ),
                      );
                      setState(() {
                        selectedCategories.add(selectedMainCategory);
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Color(0xFF3F72AF)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// HomeScreen widget
class HomeScreen extends StatelessWidget {
  final List<String> selectedCategories;
  final String searchQuery;

  const HomeScreen({
    required this.selectedCategories,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    final filteredProducts = products
        .where((product) =>
            (selectedCategories.isEmpty ||
                selectedCategories.contains(product.category)) &&
            (searchQuery.isEmpty ||
                product.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                product.category
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase())))
        .toList();

    return filteredProducts.isEmpty
        ? Center(
            child: Text(
              'No results found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          )
        : GridView.builder(
            padding: EdgeInsets.all(screenHeight * 0.02),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: screenHeight * 0.02,
              mainAxisSpacing: screenHeight * 0.02,
              childAspectRatio: 0.8,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return PropertyCard(product: product);
            },
          );
  }
}

// Property Card Widget
class PropertyCard extends StatelessWidget {
  final Product product;

  const PropertyCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              product.imageUrl,
              width: double.infinity,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.03,
                    color: Colors.black,
                  ),
                ),
                Text(
                  product.price,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.green,
                  ),
                ),
                Text(
                  product.category,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder Screens
class AddPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Add Post Screen',
        style: TextStyle(fontSize: 20, color: Color(0xFF3F72AF)),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 20, color: Color(0xFF3F72AF)),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Notifications Screen',
        style: TextStyle(fontSize: 20, color: Color(0xFF3F72AF)),
      ),
    );
  }
}
