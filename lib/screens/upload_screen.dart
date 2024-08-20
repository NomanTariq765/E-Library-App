import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // Import for file handling
import 'package:path/path.dart' as p;

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String? _fileName; // Variable to hold the name of the selected file
  String? _filePath; // Variable to hold the path of the selected file
  String? _fileContent; // Variable to hold the content of the file for preview

  // Method to pick a file
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(); // Open file picker dialog
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name; // Get the file name
        _filePath = result.files.single.path; // Get the file path
      });

      // Read the file content if it's a text file
      if (_filePath != null) {
        _readFileContent();
      }
    }
  }

  // Method to read the content of the file (for demo purposes)
  Future<void> _readFileContent() async {
    if (_filePath == null) return;

    final fileExtension = p.extension(_filePath!);
    if (fileExtension == '.txt') {
      try {
        final file = File(_filePath!);
        final content = await file.readAsString();
        setState(() {
          _fileContent = content;
        });
      } catch (e) {
        setState(() {
          _fileContent = 'Error reading file content.';
        });
      }
    } else {
      setState(() {
        _fileContent = 'File content preview is not supported for this file type.';
      });
    }
  }

  // Method to simulate file upload
  Future<void> _uploadFile() async {
    if (_filePath == null) return;

    // Simulate a delay for file upload
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    // Show a snackbar indicating the file upload completion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('File successfully uploaded: $_fileName')), // Show a snackbar with a detailed message
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Upload File',style: TextStyle(color: Colors.white),), // Title of the screen
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity, // Make the container take full width
              padding: EdgeInsets.all(16.0), // Padding inside the container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border for the container
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
                children: <Widget>[
                  Text(
                    _fileName ?? 'No file selected', // Display the file name or placeholder text
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Style for the text
                  ),
                  SizedBox(height: 20.0), // Space between the text and button
                  if (_fileContent != null) // Show file content preview if available
                    Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          _fileContent!,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ),
                  SizedBox(height: 20.0), // Space between file content and select button
                  ElevatedButton(
                    onPressed: _pickFile, // Call _pickFile method when pressed
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Padding
                    ),
                    child: Text(
                      'Select File', // Button text
                      style: TextStyle(fontSize: 18.0, color: Colors.white), // Text style (optional)
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0), // Space between the container and upload button
            ElevatedButton(
              onPressed: _uploadFile, // Call _uploadFile method when pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Padding
              ),
              child: Text(
                'Upload File', // Button text
                style: TextStyle(fontSize: 18.0, color: Colors.white), // Text style (optional)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
