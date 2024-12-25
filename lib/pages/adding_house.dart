import 'dart:io';

import 'package:afrotieapp/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newone/UI/theme.dart';

class AddingHousePages extends StatefulWidget {
  const AddingHousePages({super.key});

  @override
  State<AddingHousePages> createState() => _AddingHousePagesState();
}

class _AddingHousePagesState extends State<AddingHousePages> {
  final _formKey = GlobalKey<FormState>();
  String? saleOrRent;
  String? propertyType;
  int? bedrooms;
  int? bathrooms;
  double? price;
  double? squareMeters;
  String? description;
  String? selectedCity;
  String? selectedBank;
  File? paymentScreenshot;
  int currentStep = 0;
  List<String> uploadedImages = [];

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
    'Silte Zone'
  ];

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

  Widget _buildPropertyDetailsForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Is the property for Sale or Rent?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: ['Sale', 'Rent'].map((option) {
                return Expanded(
                  child: RadioListTile<String>(
                    title: Text(option),
                    value: option,
                    groupValue: saleOrRent,
                    onChanged: (value) {
                      setState(() {
                        saleOrRent = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Property Type',
                border: OutlineInputBorder(),
              ),
              value: propertyType,
              items: [
                'Villa',
                'House G+',
                'Commercial',
                'Guesthouse',
                'Condominium',
                'Warehouse',
                'Land'
              ].map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  propertyType = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a property type' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '# Bedrooms',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: bedrooms?.toString(),
                    onChanged: (value) {
                      setState(() {
                        bedrooms = int.tryParse(value);
                      });
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of bedrooms'
                        : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '# Bathrooms',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: bathrooms?.toString(),
                    onChanged: (value) {
                      setState(() {
                        bathrooms = int.tryParse(value);
                      });
                    },
                    validator: (value) => value!.isEmpty
                        ? 'Please enter the number of bathrooms'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: saleOrRent == 'Sale'
                    ? 'Price (Selling Price)'
                    : 'Price (Monthly Rent)',
                border: const OutlineInputBorder(),
              ),
              initialValue: price?.toString(),
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value);
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the price' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Square Meters',
                border: OutlineInputBorder(),
              ),
              initialValue: squareMeters?.toString(),
              onChanged: (value) {
                setState(() {
                  squareMeters = double.tryParse(value);
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the square meters' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              initialValue: description,
              onChanged: (value) {
                setState(() {
                  description = value;
                });
              },
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
            ),
          ],
        ),
      ),
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

  Widget _buildImageUploadSection() {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImages() async {
      final images = await picker.pickMultiImage(imageQuality: 80);
      if (images != null) {
        setState(() {
          uploadedImages.addAll(images.map((e) => e.path));
          if (uploadedImages.length > 5) {
            uploadedImages = uploadedImages.take(5).toList();
          }
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: pickImages,
          child: const Text("Upload"),
        ),
        const SizedBox(height: 10),
        if (uploadedImages.isNotEmpty)
          Wrap(
            spacing: 10,
            children: uploadedImages.map((path) {
              return Image.file(
                File(path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildPaymentDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
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
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final picker = ImagePicker();
            final pickedImage =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedImage != null) {
              setState(() {
                paymentScreenshot = File(pickedImage.path);
              });
            }
          },
          child: const Text('Upload Payment Screenshot'),
        ),
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
    );
  }

  Widget _buildStepper() {
    final steps = [
      Step(
        title: const Text('Property Details'),
        content: _buildPropertyDetailsForm(),
        isActive: currentStep == 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('City Selection'),
        content: _buildCitySelection(),
        isActive: currentStep == 1,
        state: currentStep == 1 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Image Upload'),
        content: _buildImageUploadSection(),
        isActive: currentStep == 2,
        state: currentStep == 2 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Payment Details'),
        content: _buildPaymentDetailsForm(),
        isActive: currentStep == 3,
        state: currentStep == 3 ? StepState.editing : StepState.complete,
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
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Property Submitted!')),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
