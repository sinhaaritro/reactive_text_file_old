import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'library/blocs/bloc_events_logger.dart';

void main() {
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  runApp(MyApp());
}
