import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  final List<Map<String, String>> watchlistItems = [
    {'name': 'Luxury Villa', 'type': 'Property'},
    {'name': 'Modern Apartment', 'type': 'Property'},
    {'name': 'Commercial Office Space', 'type': 'Property'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: Color(0xFF3F72AF),
      ),
      body: watchlistItems.isEmpty
          ? Center(
              child: Text(
                "Your watchlist is empty.",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF112D4E),
                ),
              ),
            )
          : ListView.builder(
              itemCount: watchlistItems.length,
              itemBuilder: (context, index) {
                final item = watchlistItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  color: Color(0xFFDBE2EF),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Color(0xFF112D4E),
                    ),
                    title: Text(
                      item['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF112D4E),
                      ),
                    ),
                    subtitle: Text(item['type']!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromWatchlist(context, index);
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _removeFromWatchlist(BuildContext context, int index) {
    // Show confirmation dialog before removing
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Item'),
          content: Text(
              'Are you sure you want to remove this item from your watchlist?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the removal
                watchlistItems.removeAt(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item removed from your watchlist.'),
                  ),
                );
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }
}
