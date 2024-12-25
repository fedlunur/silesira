import 'dart:io';

import 'package:afrotieapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:newone/UI/theme.dart';

class AddingFashionPage extends StatefulWidget {
  const AddingFashionPage({super.key});

  @override
  State<AddingFashionPage> createState() => _AddingFashionPageState();
}

class _AddingFashionPageState extends State<AddingFashionPage> {
  final _formKey = GlobalKey<FormState>();
  String? mainCategory;
  String? genderCategory;
  String? subCategory;
  double? price;
  String? description;
  int currentStep = 0;
  List<String> uploadedImages = [];
  String? selectedCity;
  String? selectedBank;
  String? paymentScreenshot;

  final List<String> mainCategories = ['Cloth', 'Bags', 'Shoes', 'Hats'];
  final List<String> genderCategories = ['Men', 'Women', 'Children'];
  final Map<String, List<String>> menSubCategories = {
    'Cloth': ['Suit', 'Casual', 'Habeshan Wear'],
  };
  final Map<String, List<String>> womenSubCategories = {
    'Cloth': [
      'Wedding Dress/Viels',
      'Event Dress',
      'Habeshan Dress',
      'Casual',
      'Hijabs'
    ],
  };
  final Map<String, List<String>> childrenSubCategories = {
    'Cloth': ['Kids Event Wear', 'Casual Wear', 'Habeshan Cloth'],
  };
  final Map<String, List<String>> bagSubCategories = {
    'Bags': ['Backpacks', 'Wallets', 'Women Purses', 'Luggages'],
  };
  final List<String> cities = [
    'Addis Ababa',
    'Diredawa',
    'Sheger ',
    'Amhara Region',
    'Tigray Region',
    'Oromia Region',
    'Southern Ethiopia Region',
    'Afar Region',
    'Somali Region',
    'Gurage Zone',
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

  Widget _buildClothingDetailsForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainCategoryDropdown(),
            const SizedBox(height: 10),
            if (mainCategory == 'Cloth') _buildGenderDropdown(),
            const SizedBox(height: 10),
            if (genderCategory != null) _buildSubCategoryDropdown(),
            const SizedBox(height: 10),
            if (mainCategory == 'Bags') _buildBagTypeDropdown(),
            const SizedBox(height: 10),
            if (mainCategory == 'Hats') _buildGenderDropdown(),
            const SizedBox(height: 10),
            if (genderCategory != null) _buildSubCategoryDropdown(),
            const SizedBox(height: 10),
            if (mainCategory == 'Shoes') _buildGenderDropdown(),
            const SizedBox(height: 10),
            if (genderCategory != null) _buildSubCategoryDropdown(),
            const SizedBox(height: 10),
            _buildTextField(
              label: 'Price',
              initialValue: price?.toString(),
              onChanged: (value) => price = double.tryParse(value!),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter the price' : null,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
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
      ),
    );
  }

  Widget _buildBagTypeDropdown() {
    final List<String>? bagTypes = bagSubCategories[mainCategory];

    if (bagTypes == null || bagTypes.isEmpty) {
      return const SizedBox.shrink();
    }

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Bag Type',
        border: OutlineInputBorder(),
      ),
      value: subCategory,
      items: bagTypes.map((type) {
        return DropdownMenuItem(value: type, child: Text(type));
      }).toList(),
      onChanged: (value) {
        setState(() {
          subCategory = value;
        });
      },
      validator: (value) => value == null ? 'Please select a bag type' : null,
    );
  }

  Widget _buildMainCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Main Category',
        border: OutlineInputBorder(),
      ),
      value: mainCategory,
      items: mainCategories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        setState(() {
          mainCategory = value;
          genderCategory = null;
          subCategory = null;
        });
      },
      validator: (value) =>
          value == null ? 'Please select a main category' : null,
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Gender Category',
        border: OutlineInputBorder(),
      ),
      value: genderCategory,
      items: genderCategories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        setState(() {
          genderCategory = value;
          subCategory = null;
        });
      },
      validator: (value) =>
          value == null ? 'Please select a gender category' : null,
    );
  }

  Widget _buildSubCategoryDropdown() {
    final subCategories = genderCategory == 'Men'
        ? menSubCategories[mainCategory]
        : genderCategory == 'Women'
            ? womenSubCategories[mainCategory]
            : childrenSubCategories[mainCategory];

    if (subCategories == null || subCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Select Sub Category',
        border: OutlineInputBorder(),
      ),
      value: subCategory,
      items: subCategories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
      onChanged: (value) {
        setState(() {
          subCategory = value;
        });
      },
      validator: (value) =>
          value == null ? 'Please select a sub category' : null,
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

  Widget _buildImageUploadSection() {
    final ImagePicker picker = ImagePicker();

    Future<void> pickImages() async {
      final List<XFile> pickedFiles =
          await picker.pickMultiImage(imageQuality: 80);

      if (uploadedImages.length + pickedFiles.length > 5) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('You can only upload a maximum of 5 images!'),
          ),
        );
      } else {
        setState(() {
          uploadedImages.addAll(pickedFiles.map((file) => file.path));
        });
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
            backgroundColor: AppTheme.customColor,
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
        labelText: 'Select the Bank you used for payment',
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
    final ImagePicker picker = ImagePicker();

    Future<void> pickScreenshot() async {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          paymentScreenshot = pickedFile.path;
        });
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Payment Screenshot',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: pickScreenshot,
          icon: const Icon(Icons.upload),
          label: const Text('Upload Screenshot'),
        ),
        const SizedBox(height: 10),
        if (paymentScreenshot != null)
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.file(
                  File(paymentScreenshot!),
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    paymentScreenshot = null;
                  });
                },
                icon: const Icon(Icons.cancel, color: Colors.red),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final steps = [
      _buildClothingDetailsForm(),
      SingleChildScrollView(
        child: Column(
          children: [
            _buildImageUploadSection(),
            const SizedBox(height: 20),
            _buildCitySelection(),
          ],
        ),
      ),
      SingleChildScrollView(
        child: Column(
          children: [
            _buildBankSelection(),
            const SizedBox(height: 20),
            _buildPaymentScreenshotUpload(),
          ],
        ),
      ),
    ];

    void _validateAndSubmit() {
      if (_formKey.currentState?.validate() == true &&
          uploadedImages.length >= 3 &&
          uploadedImages.length <= 5 &&
          selectedCity != null &&
          selectedBank != null &&
          paymentScreenshot != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Item added successfully!'),
          ),
        );
      } else {
        String errorMessage = 'Please ensure:';
        if (_formKey.currentState?.validate() != true) {
          errorMessage += '\n- All form fields are valid.';
        }
        if (uploadedImages.length < 3 || uploadedImages.length > 5) {
          errorMessage += '\n- Between 3 to 5 images are uploaded.';
        }
        if (selectedCity == null) {
          errorMessage += '\n- A city is selected.';
        }
        if (selectedBank == null) {
          errorMessage += '\n- A bank is chosen for payment.';
        }
        if (paymentScreenshot == null) {
          errorMessage += '\n- A payment screenshot is uploaded.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Fashion Item',
          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppTheme.customColor,
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: () {
          if (currentStep < steps.length - 1) {
            setState(() {
              currentStep++;
            });
          } else {
            _validateAndSubmit();
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep--;
            });
          }
        },
        steps: List.generate(steps.length, (index) {
          return Step(
            title: Text('Step ${index + 1}'),
            content: steps[index],
            isActive: currentStep == index,
            state: currentStep > index ? StepState.complete : StepState.indexed,
          );
        }),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (currentStep > 0)
                ElevatedButton(
                  onPressed: details.onStepCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.customColor,
                  ),
                  child: const Text('Back'),
                ),
              ElevatedButton(
                onPressed: details.onStepContinue,
                child:
                    Text(currentStep == steps.length - 1 ? 'Finish' : 'Next'),
              ),
            ],
          );
        },
      ),
    );
  }
}
