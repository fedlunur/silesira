import 'dart:io';
import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:newone/UI/theme.dart';

class OtherServicePage extends StatefulWidget {
  const OtherServicePage({super.key});

  @override
  State<OtherServicePage> createState() => _OtherServicePageState();
}

class _OtherServicePageState extends State<OtherServicePage> {
  final _formKey = GlobalKey<FormState>();
  String? otherServiceName;
  double? price;
  String? description;
  String? selectedCity;
  File? paymentScreenshot;
  List<String> uploadedImages = [];
  String? selectedBank;
  int currentStep = 0;

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
    'Cooperative Bank of Oromia',
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
    'Hijra Bank',
    'Zamzam Bank',
    'Tsedey Bank',
    'Tsehay Bank',
  ];

  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    final images = await _picker.pickMultiImage(imageQuality: 80);
    if (images != null) {
      setState(() {
        uploadedImages.addAll(images.map((e) => e.path));
        if (uploadedImages.length > 5) {
          uploadedImages = uploadedImages.take(5).toList();
        }
      });
    }
  }

  Future<void> pickPaymentScreenshot() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        paymentScreenshot = File(pickedImage.path);
      });
    }
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
        title: const Text('Location & Images'),
        content: _buildLocationAndImageForm(),
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
            // Submit the form or navigate back
            Navigator.pop(context, {
              'serviceName': otherServiceName,
              'price': price,
              'description': description,
              'selectedCity': selectedCity,
              'images': uploadedImages,
              'paymentScreenshot': paymentScreenshot,
              'selectedBank': selectedBank,
            });
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

  Widget _buildServiceDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Service Name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) => otherServiceName = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a service name' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => price = double.tryParse(value),
            validator: (value) =>
                value!.isEmpty ? 'Please enter a price' : null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            onChanged: (value) => description = value,
            validator: (value) =>
                value!.isEmpty ? 'Please enter a description' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationAndImageForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
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
        ),
        const SizedBox(height: 20),
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
          onPressed: pickPaymentScreenshot,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Other Service'),
        backgroundColor: AppTheme.customColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildStepper(),
      ),
    );
  }
}
