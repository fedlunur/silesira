import 'package:afrotieapp/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart'; // For making phone calls and sending messages

class DetailsPage extends StatefulWidget {
  final Product product;

  const DetailsPage({super.key, required this.product});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Function to call the advertiser
  void _callAdvertiser(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('Could not launch $phoneUri');
    }
  }

  // Function to message the advertiser
  void _messageAdvertiser(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      debugPrint('Could not launch $smsUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    int pageCount = widget.product.images.length; // Total number of images

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: const Color(0xFF3F72AF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home'); // Navigates to the Home page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel with PageView
              if (widget.product.images.isNotEmpty)
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: widget.product.images.length,
                    onPageChanged: (int index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.network(
                          widget.product.images[index],
                          width: 350,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 16),

              // Page indicator (e.g., "1/3", "2/3", etc.)
              if (widget.product.images.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${_currentPage + 1} / $pageCount',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              const SizedBox(height: 16),

              // Sale or Rent
              Text(
                widget.product.saleOrRent,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F72AF),
                ),
              ),

              const SizedBox(height: 8),

              // Price
              Text(
                widget.product.price!.isNotEmpty
                    ? '\$${widget.product.price}'
                    : 'Price: Not Available',
                style: const TextStyle(fontSize: 22, color: Colors.green),
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 16),

              // Contact Information
              if (widget.product.contact != null)
                Text(
                  'Advertisor: ${widget.product.contact}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

              const SizedBox(height: 16),

              // Additional Information (if available)
              if (widget.product.bedrooms != null ||
                  widget.product.bathrooms != null ||
                  widget.product.squareMeters != null ||
                  widget.product.subcategory != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(thickness: 1),
                    const Text(
                      'Property Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (widget.product.bedrooms != null)
                      Text('Bedrooms: ${widget.product.bedrooms}'),
                    if (widget.product.bathrooms != null)
                      Text('Bathrooms: ${widget.product.bathrooms}'),
                    if (widget.product.squareMeters != null)
                      Text('Size: ${widget.product.squareMeters} m²'),
                    if (widget.product.subcategory != null)
                      Text('Type: ${widget.product.subcategory}'),
                  ],
                ),

              if (widget.product.brand != null ||
                  widget.product.model != null ||
                  widget.product.subcategory != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(thickness: 1),
                    const Text(
                      'Car Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (widget.product.brand != null)
                      Text('Brand: ${widget.product.brand}'),
                    if (widget.product.model != null)
                      Text('Model: ${widget.product.model}'),
                    if (widget.product.subcategory != null)
                      Text('Type: ${widget.product.subcategory}'),
                  ],
                ),

              const Divider(thickness: 1),

              // Call and Message Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: widget.product.contact != null
                          ? () => _callAdvertiser(widget.product.contact!)
                          : null,
                      icon: const Icon(Icons.call),
                      label: const Text('Call Advertiser'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: widget.product.contact != null
                          ? () => _messageAdvertiser(widget.product.contact!)
                          : null,
                      icon: const Icon(Icons.message),
                      label: const Text('Message Advertiser'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
