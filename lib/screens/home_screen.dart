import 'package:flutter/material.dart';

import 'book_screen.dart';
import 'notebook_screen.dart';
import 'upload_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text('E-Library', style: TextStyle(color: Colors.white)),
      ),
      body: GridView.count(
        mainAxisSpacing: 2,
        crossAxisCount: 1,
        children: <Widget>[
          _buildCard(
            context,
            Icons.book,
            'Books',
            'View and manage books',
            Colors.lightBlueAccent, // Color for the Books card
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BookScreen()),
            ),
          ),
          _buildCard(
            context,
            Icons.note,
            'Notebook',
            'Take notes',
            Colors.orangeAccent, // Color for the Notebook card
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotebookScreen()),
            ),
          ),
          _buildCard(
            context,
            Icons.upload_file,
            'Upload Book',
            'Upload a new book',
            Colors.red, // Color for the Upload Book card
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, String subtitle, Color color, VoidCallback onPressed) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 60.0, color: Colors.white),
            Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(subtitle, style: TextStyle(fontSize: 16.0, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
