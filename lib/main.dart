import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/comics_app/presentation/bloc/comics_bloc.dart';
import 'injection_container.dart';
import 'features/comics_app/presentation/pages/main_page.dart';
import 'injection_container.dart' as di;

void main() async {
  //lets go
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => sl<ComicsBloc>(),
        child: const MainPage(),
      ),
    );
  }
}
