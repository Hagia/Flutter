import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_camera/models/note.dart';
import 'package:test_camera/screens/screens.dart';
import 'package:test_camera/state/cubits/notes_cubit.dart';

class NoteWidget extends StatefulWidget {
  final Note note;

  const NoteWidget(Key key, this.note) : super(key: key);

  @override
  NoteWidgetState createState() => NoteWidgetState();
}

class NoteWidgetState extends State<NoteWidget>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 250,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    _scale = 0.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    final AlertDialog deleteDialog = AlertDialog(
      title: const Text('Note actions'),
      content: const Text('Delete or edit your note!'),
      actions: [
        TextButton(
            onPressed: () => {
                  BlocProvider.of<NotesCubit>(context).removeNote(widget.note),
                  Navigator.pop(context)
                },
            child: const Text('Delete')),
        TextButton(
            onPressed: () => {
                  Navigator.pop(context),
                  _controller.reverse(),
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AddNote(
                            null,
                            note: widget.note,
                          )))
                },
            child: const Text('Edit')),
        TextButton(
            onPressed: () => {Navigator.pop(context), _controller.reverse()},
            child: const Text('Cancel'))
      ],
    );

    return GestureDetector(
        onTapDown: _tapDown,
        onTapUp: _tapUp,
        onLongPress: () =>
            showDialog(context: context, builder: (ctx) => deleteDialog)
                .whenComplete(() => _controller.reverse()),
        child: Transform.scale(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.teal),
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            padding: const EdgeInsets.all(7),
            child: Column(
              // direction: Axis.vertical,
              // alignment: WrapAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.note.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(widget.note.description,
                    textAlign: TextAlign.left,
                    softWrap: false,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14)),
                Text(widget.note.category,
                    style: const TextStyle(color: Colors.green, fontSize: 12)),
              ],
            ),
          ),
        ));
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
