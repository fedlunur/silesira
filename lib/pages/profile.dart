import 'dart:io';
import 'package:afrotieapp/widgets/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
// Assuming the CustomBottomNavigationBar is in a separate file

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = 'John Doe';
  final String email = 'john.doe@example.com';
  String avatarUrl = 'https://www.w3schools.com/w3images/avatar2.png';
  File? profileImage;

  final ImagePicker picker = ImagePicker();
  int _currentIndex = 3; // Profile is the third tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F7F7),
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF3F72AF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home'); // Navigates to the Home page
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              context.push('/transactionhistory');
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Delete Account') {
                _showDeleteConfirmationDialog(context);
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Delete Account'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : avatarUrl.isNotEmpty
                            ? NetworkImage(avatarUrl) as ImageProvider
                            : AssetImage('assets/default_avatar.png'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF112D4E),
                                ),
                      ),
                      Text(
                        email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          changeProfilePicture();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF3F72AF),
                        ),
                        child: Text('Change Profile Picture'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildMenuTile(
                icon: Icons.star,
                title: 'Watchlist',
                onTap: () {
                  context.push('/watchlist');
                },
              ),
              Divider(),
              _buildMenuTile(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {
                  changePassword(context);
                },
              ),
              Divider(),
              _buildMenuTile(
                icon: Icons.house,
                title: 'Posted Properties',
                onTap: () {
                  context.push('/postedproperties');
                },
              ),
              Divider(),
              _buildMenuTile(
                icon: Icons.history,
                title: 'Transaction History',
                onTap: () {
                  context.push('/transactionhistory');
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              context.go('/home'); // Navigate to Home
              break;
            case 1:
              context.go('/addproperty'); // Navigate to Add Property
              break;
            case 2:
              context.go('/notifications'); 
              break;
            case 3:
              context.go('/profile'); 
              break;
          }
        },
      ),
    );
  }

  Future<void> changeProfilePicture() async {
    final ImagePicker imagepicker = ImagePicker();
    File? pickedImage;
    String newAvatarUrl = avatarUrl;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await imagepicker.pickImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile != null) {
                    pickedImage = File(pickedFile.path);
                    newAvatarUrl = '';
                    setState(() {
                      profileImage = pickedImage;
                      avatarUrl = newAvatarUrl;
                    });
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final pickedFile = await imagepicker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (pickedFile != null) {
                    pickedImage = File(pickedFile.path);
                    newAvatarUrl = '';
                    setState(() {
                      profileImage = pickedImage;
                      avatarUrl = newAvatarUrl;
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildMenuTile({
    required IconData icon,
    required String title,
    required Function() onTap,
    Color? tileColor,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      tileColor: tileColor,
      leading: Icon(
        icon,
        color: iconColor ?? Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  void changePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController currentPasswordController =
            TextEditingController();
        final String correctPassword = '12345678';

        return AlertDialog(
          title: Text('Enter Current Password'),
          content: TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (currentPasswordController.text == correctPassword) {
                  Navigator.of(context).pop();
                  context.push('/forgetresset', extra: {'isResetMode': true});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incorrect password. Please try again.'),
                    ),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
              'Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('Account deleted');
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
