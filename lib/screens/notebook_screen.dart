import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package

class Note {
  String id;
  String content;

  Note({
    required this.id,
    required this.content,
  });
}

class NotebookScreen extends StatefulWidget {
  @override
  _NotebookScreenState createState() => _NotebookScreenState();
}

class _NotebookScreenState extends State<NotebookScreen> {
  final _textController = TextEditingController();
  final List<Note> _notes = [];
  Note? _selectedNote;
  final Uuid _uuid = Uuid(); // Create an instance of Uuid

  void _saveNote() {
    if (_textController.text.isEmpty) return;

    setState(() {
      if (_selectedNote != null) {
        _selectedNote!.content = _textController.text;
      } else {
        _notes.add(Note(
          id: _uuid.v4(), // Generate a unique ID
          content: _textController.text,
        ));
      }
      _textController.clear();
      _selectedNote = null;
    });
  }

  void _editNote(Note note) {
    setState(() {
      _selectedNote = note;
      _textController.text = note.content;
    });
  }

  void _deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
      _textController.clear();
      _selectedNote = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Notebook',style: TextStyle(color: Colors.white),)
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Enter your note',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, // Background color
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Padding
                ),
                child: Text(
                  _selectedNote == null ? 'Save' : 'Update',
                  style: TextStyle(fontSize: 18.0,color: Colors.white), // Text style (optional)
                ),
              )

            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editNote(note),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteNote(note),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
