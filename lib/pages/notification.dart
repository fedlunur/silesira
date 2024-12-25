import 'package:afrotieapp/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _currentIndex = 2; // Assuming the Notification Page index is 2

  // Dummy data for notifications
  final List<Map<String, String>> notifications = [
    {
      "title": "New listing in Mexico",
      "description":
          "A villa is available for rent in Mexico with 3 bedrooms and 2 bathrooms.",
      "time": "2 hrs"
    },
    {
      "title": "New listing in Asko",
      "description": "A commercial building is available for rent in Asko.",
      "time": "5 hrs"
    },
    {
      "title": "New listing in Jemo that fits your criteria",
      "description":
          "A condo is available for sale in Jemo with 5 bedrooms and 3 bathrooms.",
      "time": "16 hrs"
    },
    {
      "title": "New listing in Semmit",
      "description":
          "A villa is available for sale in Semmit with 2 bedrooms and 1 bathroom.",
      "time": "1 d"
    },
  ];

  // Navigation logic for bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
        backgroundColor: const Color(0xFF3F72AF),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Bell icon tapped!');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: const Color(0xFFF5F5FF), // Light purple background
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF3F72AF),
                child: Icon(Icons.apartment, color: Colors.white),
              ),
              title: Text(
                notification["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification["description"]!,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification["time"]!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
              context.go('/addproperty');
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
