import 'package:Notes/presentation/notes/note_form/note_form_page.dart';
import 'package:Notes/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:auto_route/auto_route_annotations.dart';

import '../sign_in/sign_in_page.dart';
import '../splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage, initial: true),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: NotesOverviewPage),
    MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
  generateNavigationHelperExtension: true,
)
class $Router {}
