import 'dart:io';

import 'package:claimitproject/ui_helper/genTextFormField.dart';
import 'package:claimitproject/ui_helper/getDropDown.dart';
import 'package:flutter/material.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {

  List<String> selectedColors = [];
  String? selectedCategory;
  String? selectedLocation;
  String name = '';
  String description = '';

  final _conName = TextEditingController();
  final _conLocation = TextEditingController();
  final _conCategory = TextEditingController();
  final _conDescription = TextEditingController();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Form'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              Container(
                height: 200,
                child: _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          "Please select an image",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                     // _pickImageFromGallery();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      'Pick Image',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      //_openCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      'Open Camera',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Color',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),
              /*
              Container(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: getColorCheckboxes(),
                ),
              ), */
              SizedBox(height: 16),
              GetTextFormField(
                controller: _conName,
                hintName: 'Name',
                icon: Icons.inventory,
              ),
              SizedBox(height: 8),
              getDropdownFormField(
                hintName: 'Category',
                items: [
                  'IT Gadget',
                  'Stationary',
                  'Personal Belonging',
                  'Bag',
                  'Others'
                ],
                icon: Icons.category,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                value: selectedCategory,
              ),
              SizedBox(height: 8),
              getDropdownFormField(
                hintName: 'Location',
                items: [
                  'HM Building',
                  'ECC Building',
                  'Engineering Faculty',
                  'Architect Faculty',
                  'Science Faculty',
                  'Business Faculty',
                  'Art Faculty',
                  'Others'
                ],
                icon: Icons.location_on,
                onChanged: (value) {
                  setState(() {
                    selectedLocation = value;
                  });
                },
                value: selectedLocation,
              ),
              SizedBox(height: 8),
              GetTextFormField(
                controller: _conDescription,
                hintName: 'Description',
                icon: Icons.description,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                     // _uploadItem();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.black),
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