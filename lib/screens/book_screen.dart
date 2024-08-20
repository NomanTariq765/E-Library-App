import 'package:flutter/material.dart';

class BookScreen extends StatelessWidget {
  // Dummy data for books
  final List<Map<String, String>> books = [
    {'title': 'To Kill a Mockingbird', 'author': 'Harper Lee'},
    {'title': '1984', 'author': 'George Orwell'},
    {'title': 'The Great Gatsby', 'author': 'F. Scott Fitzgerald'},
    {'title': 'Moby-Dick', 'author': 'Herman Melville'},
    // Add more books as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Books',style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book['title']!),
            subtitle: Text(book['author']!),
            leading: Icon(Icons.book),
            contentPadding: EdgeInsets.all(8.0),
            onTap: () {
              // Handle book item tap if needed
            },
          );
        },
      ),
    );
  }
}
