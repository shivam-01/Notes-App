import 'package:Notes/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UncompletedSwitch extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final uncompletedSwitchState = useState(false);

    return InkResponse(
      onTap: () {
        uncompletedSwitchState.value = !uncompletedSwitchState.value;
        performAction(context, uncompleted: uncompletedSwitchState.value);
      },
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
          child: uncompletedSwitchState.value
              ? const Icon(
                  Icons.check_box_outline_blank,
                  key: Key('outline'),
                )
              : const Icon(
                  Icons.indeterminate_check_box,
                  key: Key('indeterminate'),
                )),
    );
  }

  void performAction(BuildContext context, {@required bool uncompleted}) {
    context.read<NoteWatcherBloc>().add(
          uncompleted
              ? const NoteWatcherEvent.watchUncompletedStarted()
              : const NoteWatcherEvent.watchAllStarted(),
        );
  }
}
