import 'package:flutter_bloc/flutter_bloc.dart';
import './../../models/note.dart';

class NotesCubit extends Cubit<List<Note>> {
  NotesCubit() : super(<Note>[]);

  void addNote(Note note) {
    var stateCopy = state;
    stateCopy.add(note);
    emit([...stateCopy]);
  }

  void removeNote(Note noteToRemove) {
    emit(state.where((note) => note.name != noteToRemove.name).toList());
  }

  void updateNote(Note noteToUpdate) {
    final index = state.indexWhere((note) => note.name == noteToUpdate.name);
    state.insert(index, noteToUpdate);
  }
}
