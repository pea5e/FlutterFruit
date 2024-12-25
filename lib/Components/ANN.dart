import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }

  }

  Future<void> _uploadImage() async {
    print("upload");

    final reader = html.FileReader();
    reader.readAsDataUrl(html.Blob([_image])); // Read file as data URL (Base64)
    
    reader.onLoadEnd.listen((e) async {
  // Replace with your API URL
  final uri = Uri.parse('http://127.0.0.1:5000/');
  // var request = http.MultipartRequest('POST', uri);

  // Add image as multipart
  // var pic = await http.MultipartFile.fromPath(
  //   'file', 
  //   _image!.path,
  //   contentType: MediaType('image', 'jpeg'), 
  // );
  print(reader.result as String);
  String base64Image = reader.result as String;
  // base64Image = base64Image.split(',').last;

  final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'image': base64Image,
        'filename': _image!.path.split('/').last, 
      }),
    );
  // request.files.add(await http.MultipartFile.fromBytes(
  //   'file', 
  //   imageBytes,
  //   contentType: MediaType('image', 'jpeg'), // You can adjust for the image type
  // ));
  // Add file to request
  // request.files.add(pic);

  // Send request

  // Check response
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('Failed to upload image');
  }
    }
    );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Upload Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.network(_image!.path)
                : Text('No image selected'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image from Gallery'),
            ),
            // ElevatedButton(
            //   onPressed: _pickImageFromCamera,
            //   child: Text('Pick Image from Camera'),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _image != null ? _uploadImage : null,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}

