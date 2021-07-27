import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_text_file/config/themes/app_theme.dart';
import 'package:reactive_text_file/library/cubit/theme_cubit.dart';

import 'config/routes/app_router.dart';
import 'library/blocs/bloc_events_logger.dart';

void main() {
  if (kDebugMode) Bloc.observer = AppBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      ],
      child: const ReactiveTextApp(),
    );
  }
}

class ReactiveTextApp extends StatefulWidget {
  const ReactiveTextApp({
    Key? key,
  }) : super(key: key);

  @override
  _ReactiveTextAppState createState() => _ReactiveTextAppState();
}

class _ReactiveTextAppState extends State<ReactiveTextApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
      initialRoute: AppRouter.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
