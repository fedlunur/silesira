import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddPropertyPage extends StatefulWidget {
  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final categories = [
    {'label': 'House', 'icon': Icons.house},
    {'label': 'Car', 'icon': Icons.directions_car},
    {'label': 'Accessory', 'icon': Icons.watch},
    {'label': 'Fashion', 'icon': Icons.checkroom},
    {'label': 'Electronics', 'icon': Icons.devices},
    {'label': 'Services', 'icon': Icons.handyman},
    {'label': 'Other', 'icon': Icons.more_horiz},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.go('/home'); // Navigates back to the Home page
          },
        ),
        title: Text(
          'Choose Category',
          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppTheme.customColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF9F7F7), AppTheme.customColor],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select a Category',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.customColor,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final label = category['label'] as String;
                  final icon = category['icon'] as IconData;

                  return GestureDetector(
                    onTap: () {
                      if (label == 'House') {
                        context.push('/addhouseproperty');
                      } else if (label == 'Car') {
                        context.push('/addcarproperty');
                      } else if (label == 'Accessory') {
                        context.push('/addaccessoryproperty');
                      } else if (label == 'Fashion') {
                        context.push('/addfashionproperty');
                      } else if (label == 'Electronics') {
                        context.push('/addelectronicsproperty');
                      } else if (label == 'Services') {
                        context.push('/addservices');
                      } else if (label == 'Other') {
                        context.push('/addotherservices');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CategoryDetailsPage(selectedCategory: label),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icon,
                            size: 40.0,
                            color: AppTheme.customColor,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            label,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: AppTheme.customColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDetailsPage extends StatelessWidget {
  final String selectedCategory;

  const CategoryDetailsPage({required this.selectedCategory, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCategory,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: AppTheme.customColor,
      ),
      body: Center(
        child: Text(
          'Details about $selectedCategory',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.customColor,
              ),
        ),
      ),
    );
  }
}
