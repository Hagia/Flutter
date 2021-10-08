//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './state/cubits/cubits.dart';

//Screens
import 'screens/screens.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<NotesCubit>(
        create: (_) => NotesCubit(),
      )
    ],
    child: MaterialApp(
      theme: ThemeData.dark(),
      home: const Notes(null),
    ),
  ));
}
