import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_camera/models/note.dart';
import 'package:test_camera/screens/add_note.dart';
import 'package:test_camera/state/cubits/notes_cubit.dart';

//Widgets
import './../widgets/widgets.dart';

class Notes extends StatefulWidget {
  const Notes(Key? key) : super(key: key);

  @override
  NotesState createState() => NotesState();
}

class NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BlocBuilder<NotesCubit, List<Note>>(
        builder: (context, notes) {
          return ListView(
            children: notes
                .map((note) => NoteWidget(
                      ObjectKey(note),
                      note,
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddNote(null);
              },
            ),
          )
        },
        child: const Icon(Icons.add),
        tooltip: 'Write new note',
      ),
    );
  }
}
