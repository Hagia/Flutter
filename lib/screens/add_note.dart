import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_camera/state/cubits/notes_cubit.dart';

import './../models/note.dart';

class AddNote extends StatefulWidget {
  final Note? note;
  AddNote(Key? key, {this.note}) : super(key: key);

  State<StatefulWidget> createState() => AddNoteForm();
}

class AddNoteForm extends State<AddNote> {
  String name = '';
  String description = '';
  String? category;

  late TextEditingController _name_controller;
  late TextEditingController _desc_controller;

  @override
  void initState() {
    _name_controller = TextEditingController(text: widget.note?.name)
      ..addListener(() {
        setState(() {
          name = _name_controller.text;
        });
      });
    _desc_controller = TextEditingController(text: widget.note?.description)
      ..addListener(() {
        setState(() {
          description = _desc_controller.text;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _name_controller.dispose();
    _desc_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Your note'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          BlocProvider.of<NotesCubit>(context)
              .addNote(Note(name, description, category ?? '')),
          Navigator.pop(context)
        },
        child: const Icon(Icons.check_outlined),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              TextField(
                readOnly: widget.note != null,
                controller: _name_controller,
                decoration: const InputDecoration(
                    labelText: 'Name', hintText: 'Give your note a name'),
              ),
              TextField(
                  controller: _desc_controller,
                  decoration: const InputDecoration(
                      labelText: 'Your note',
                      hintText: 'Give your note a reason'),
                  onChanged: (text) => setState(() {
                        description = text;
                      })),
              DropdownButton(
                value: category,
                items: <String>['Home', 'Job', 'Food']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: const Text(
                  "Please choose a category",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    category = value as String;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
