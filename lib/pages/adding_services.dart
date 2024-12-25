import 'dart:io';

import 'package:afrotieapp/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
// import 'package:newone/UI/theme.dart';

class AddingServicePage extends StatefulWidget {
  const AddingServicePage({super.key});

  @override
  State<AddingServicePage> createState() => _AddingServicePageState();
}

class _AddingServicePageState extends State<AddingServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? serviceName;
  String? serviceType;
  double? price;
  String? description;
  String? selectedBank;
  String? selectedCity;
  int currentStep = 0;
  File? paymentScreenshot;
  List<String> uploadedImages = [];

  final List<String> serviceTypes = [
    'Catering',
    'Dish Installation',
    'Car Services',
    'Carpet Washing',
    'Aluminium and Glass Work',
    'DJ Services',
    'Cement Providing Services',
    'Delivery',
    'Weyba Tis'
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

  Widget _buildServiceDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            label: 'Service Name',
            initialValue: serviceName,
            onChanged: (value) => serviceName = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter the service name' : null,
          ),
          const SizedBox(height: 20),
          _buildServiceTypeDropdown(),
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

  Widget _buildServiceTypeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Service Type',
        border: OutlineInputBorder(),
      ),
      value: serviceType,
      items: serviceTypes.map((type) {
        return DropdownMenuItem(value: type, child: Text(type));
      }).toList(),
      onChanged: (value) => setState(() => serviceType = value),
      validator: (value) =>
          value == null ? 'Please select a service type' : null,
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
        title: const Text('Service Details'),
        content: _buildServiceDetailsForm(),
        isActive: currentStep == 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
      ),
      Step(
        title: const Text('Location & Image Upload'),
        content: Column(
          children: [
            _buildCitySelection(),
            const SizedBox(height: 20),
            _buildImageUploadSection(),
            const SizedBox(height: 20),
          ],
        ),
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
          // Validate form fields before submitting
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Service Submitted!')),
            );
          } else {
            // Show message if any field is empty
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('All fields should be filled')),
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
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  onPressed: details.onStepContinue,
                  child:
                      Text(currentStep == steps.length - 1 ? 'Finish' : 'Next'),
                ),
              ),
              const SizedBox(width: 12),
              if (currentStep != 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Back'),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service"),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
