import 'dart:io';

import 'package:afrotieapp/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newone/UI/theme.dart';

class AddingElectronicsPage extends StatefulWidget {
  const AddingElectronicsPage({super.key});

  @override
  State<AddingElectronicsPage> createState() => _AddingElectronicsPageState();
}

class _AddingElectronicsPageState extends State<AddingElectronicsPage> {
  final _formKey = GlobalKey<FormState>();
  String? productName;
  String? productType;
  double? price;
  String? description;
  String? selectedBrand;
  String? selectedModel;
  String? selectedCity;
  String? selectedBank;
  int currentStep = 0;
  File? paymentScreenshot;
  List<String> uploadedImages = [];

  final List<String> banks = [
    'Commercial Bank of Ethiopia',
    'Dashen Bank',
    'Awash Bank',
    'Enat Bank',
    'Wegagen Bank',
    'Abay Bank',
    'Amhara Bank',
    'Abyssinia Bank',
    'Birhan Bank',
    'Cooperative Bank of Ormoia',
    'Addis International Bank',
    'Gedaa Bank',
    'Siinqee Bank',
    'Nib Bank',
    'Ahadu Bank',
    'Bunna Bank',
    'Hibret Bank',
    'Lion Bank',
    'Global Bank Ethiopia',
    'Zemen Bank',
    'Hijra Bnak',
    'Zamzam Bank',
    'Tsedey Bank',
    'Tsehay Bank',
  ];

  final List<String> productTypes = [
    'Laptop',
    'Mobile Phone',
    'Headphones',
    'Smart Watch',
    'Tablet',
    'Camera',
    'Speaker',
    'Other Electronics',
  ];

  final List<String> cities = [
    'Addis Ababa',
    'Diredawa',
    'Sheger',
    'Amhara Region',
    'Tigray Region',
    'Oromia Region',
    'Southern Ethiopia',
    'Afar Region',
    'Somali Region',
    'Gurage',
    'Silte Zone',
  ];

  Widget _buildProductDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Product Name',
            initialValue: productName,
            onChanged: (value) => productName = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter the product name' : null,
          ),
          const SizedBox(height: 20),
          _buildProductTypeDropdown(),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Price',
            initialValue: price?.toString(),
            onChanged: (value) => price = double.tryParse(value!),
            validator: (value) =>
                value!.isEmpty ? 'Please enter the price' : null,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            label: 'Description',
            initialValue: description,
            onChanged: (value) => description = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String? initialValue,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildProductTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Product Type',
        border: OutlineInputBorder(),
      ),
      value: productType,
      items: productTypes.map((type) {
        return DropdownMenuItem(value: type, child: Text(type));
      }).toList(),
      onChanged: (value) => setState(() => productType = value),
      validator: (value) =>
          value == null ? 'Please select a product type' : null,
    );
  }

  Widget _buildCitySelection() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select City',
        border: OutlineInputBorder(),
      ),
      value: selectedCity,
      items: cities.map((city) {
        return DropdownMenuItem(value: city, child: Text(city));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedCity = value;
        });
      },
      validator: (value) => value == null ? 'Please select a city' : null,
    );
  }

  Widget _buildBankSelection() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Bank',
        border: OutlineInputBorder(),
      ),
      value: selectedBank,
      items: banks.map((bank) {
        return DropdownMenuItem(value: bank, child: Text(bank));
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedBank = value;
        });
      },
      validator: (value) => value == null ? 'Please select a bank' : null,
    );
  }

  Widget _buildPaymentScreenshotUpload() {
    return ElevatedButton(
      onPressed: () async {
        final picker = ImagePicker();
        final pickedImage = await picker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          setState(() {
            paymentScreenshot = File(pickedImage.path);
          });
        }
      },
      child: const Text('Upload Payment Screenshot'),
    );
  }

  Widget _buildImageUploadSection() {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImages() async {
      final List<XFile>? pickedFiles =
          await picker.pickMultiImage(imageQuality: 80);

      if (pickedFiles != null) {
        if (uploadedImages.length + pickedFiles.length > 5) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You can only upload a maximum of 5 images!'),
            ),
          );
        } else {
          setState(() {
            uploadedImages.addAll(pickedFiles.map((file) => file.path));
          });
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Images (3-5 images required)',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickImages,
          icon: const Icon(Icons.upload),
          label: const Text('Upload Images'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 10),
        if (uploadedImages.isNotEmpty)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: uploadedImages.length,
            itemBuilder: (context, index) {
              final imagePath = uploadedImages[index];
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        uploadedImages.remove(imagePath);
                      });
                    },
                    icon: const Icon(Icons.cancel, color: Colors.red),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }

  Widget _buildStepper() {
    final steps = [
      Step(
        title: const Text('Product Details'),
        content: _buildProductDetailsForm(),
        isActive: currentStep == 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('City & Image Upload'),
        content: Column(
          children: [
            _buildCitySelection(),
            const SizedBox(height: 20),
            _buildImageUploadSection(),
          ],
        ),
        isActive: currentStep == 1,
        state: currentStep == 1 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Payment Details'),
        content: Column(
          children: [
            _buildBankSelection(),
            const SizedBox(height: 20),
            _buildPaymentScreenshotUpload(),
            if (paymentScreenshot != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.file(
                  paymentScreenshot!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
        isActive: currentStep == 2,
        state: currentStep == 2 ? StepState.editing : StepState.complete,
      ),
    ];

    return Stepper(
      currentStep: currentStep,
      steps: steps,
      onStepContinue: () {
        if (currentStep < steps.length - 1) {
          setState(() {
            currentStep++;
          });
        } else {
          if (_formKey.currentState!.validate() &&
              uploadedImages.length >= 3 &&
              paymentScreenshot != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Electronic Product Submitted!')),
            );
          }
        }
      },
      onStepCancel: () {
        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
        }
      },
      controlsBuilder: (context, details) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (currentStep > 0)
              ElevatedButton(
                onPressed: details.onStepCancel,
                child: const Text('Back'),
              ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: details.onStepContinue,
              child:
                  Text(currentStep == steps.length - 1 ? 'Finish' : 'Continue'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Electronics'),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
