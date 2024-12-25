// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PostedPropertiesPage extends StatefulWidget {
  const PostedPropertiesPage({super.key});

  @override
  _PostedPropertiesPageState createState() => _PostedPropertiesPageState();
}

class _PostedPropertiesPageState extends State<PostedPropertiesPage> {
  // List of posted items
  List<Map<String, String>> postedItems = [
    {'name': 'Luxury Villa', 'type': 'Property'},
    {'name': 'Designer Dress', 'type': 'Clothes'},
    {'name': 'Plumbing Service', 'type': 'Service'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posted Items'),
        backgroundColor: const Color(0xFF3F72AF),
      ),
      body: postedItems.isEmpty
          ? const Center(
              child: Text(
                "You have not posted anything yet.",
                style: TextStyle(color: Color(0xFF112D4E), fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: postedItems.length,
              itemBuilder: (context, index) {
                final item = postedItems[index];
                return Dismissible(
                  key: Key(item['name']!),
                  direction:
                      DismissDirection.endToStart, // Swipe from right to left
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      postedItems.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item['name']} deleted.'),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: const Color(0xFFDBE2EF),
                    child: ListTile(
                      leading: Icon(
                        item['type'] == 'Property'
                            ? Icons.house
                            : item['type'] == 'Clothes'
                                ? Icons.style
                                : Icons.build,
                        color: const Color(0xFF112D4E),
                      ),
                      title: Text(
                        item['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF112D4E),
                        ),
                      ),
                      subtitle: Text(item['type']!),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
