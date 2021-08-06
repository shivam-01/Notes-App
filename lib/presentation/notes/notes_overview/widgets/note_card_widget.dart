import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/kt.dart';

import '../../../../application/notes/note_actor/note_actor_bloc.dart';
import '../../../../domain/notes/note.dart';
import '../../../../domain/notes/todo_item.dart';
import '../../../routes/router.gr.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key key,
    @required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: note.color.getOrCrash(),
      //! For showcasing the effects of clipBehavior
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          ExtendedNavigator.of(context).pushNoteFormPage(editedNote: note);
        },
        onLongPress: () {
          final noteActorBloc = context.read<NoteActorBloc>();
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: noteActorBloc,
                child: AlertDialog(
                  title: const Text('Selected note:'),
                  content: Text(
                    note.body.getOrCrash(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    FlatButton(
                      onPressed: () {
                        noteActorBloc.add(NoteActorEvent.deleted(note));
                        Navigator.pop(context);
                      },
                      child: const Text('DELETE'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              if (note.todos.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: <Widget>[
                    ...note.todos
                        .getOrCrash()
                        .map(
                          (todo) => TodoDisplay(
                            todo: todo,
                          ),
                        )
                        .iter,
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;

  const TodoDisplay({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (todo.done)
          const Icon(
            Icons.check_box,
            color: Colors.black38,
          ),
        if (!todo.done)
          const Icon(
            Icons.check_box_outline_blank,
            color: Colors.black38,
          ),
        Text(todo.name.getOrCrash(),
            style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
