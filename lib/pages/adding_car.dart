import 'dart:io';

import 'package:afrotieapp/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newone/UI/theme.dart';

class AddingCarPage extends StatefulWidget {
  const AddingCarPage({super.key});

  @override
  State<AddingCarPage> createState() => _AddingCarPageState();
}

class _AddingCarPageState extends State<AddingCarPage> {
  final _formKey = GlobalKey<FormState>();
  String? carMake;
  String? carModel;
  int? carYear;
  int? mileage;
  double? price;
  String? fuelType;
  String? description;
  String? selectedBank;
  String? selectedCity;
  File? paymentScreenshot;
  List<String> uploadedImages = [];
  int currentStep = 0;

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

  Widget _buildCarDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Car Make',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                carMake = value;
              });
            },
            validator: (value) =>
                value!.isEmpty ? 'Please enter car make' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Car Model',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                carModel = value;
              });
            },
            validator: (value) =>
                value!.isEmpty ? 'Please enter car model' : null,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Year',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      carYear = int.tryParse(value);
                    });
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter year' : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Mileage',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      mileage = int.tryParse(value);
                    });
                  },
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter mileage' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                price = double.tryParse(value);
              });
            },
            validator: (value) => value!.isEmpty ? 'Please enter price' : null,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Fuel Type',
              border: OutlineInputBorder(),
            ),
            value: fuelType,
            items: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              setState(() {
                fuelType = value;
              });
            },
            validator: (value) =>
                value == null ? 'Please select fuel type' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
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
          child: const Text("Upload Images"),
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
        title: const Text('Car Details'),
        content: _buildCarDetailsForm(),
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
        isActive: currentStep == 1,
        state: currentStep == 1 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Payment Details'),
        content: _buildPaymentDetailsForm(),
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
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Car Submitted!')),
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
        title: const Text('Add Car'),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
