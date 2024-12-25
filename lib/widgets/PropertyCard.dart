// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:afrotieapp/models/product_model.dart';

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
                  product.price ?? 'Price not available',
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
