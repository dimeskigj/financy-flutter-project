import 'package:financy/commands/item_notifier.dart';
import 'package:financy/models/enums/item_type.dart';
import 'package:financy/models/enums/time_frame.dart';
import 'package:financy/models/item.dart';
import 'package:financy/models/item_db.dart';
import 'package:financy/services/item_service.dart';
import 'package:financy/views/list-view/list_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ItemNotifier()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const Color darker = Color(0xff222831);
  static const Color dark = Color(0xff393e46);
  static const Color accent = Color(0xffd65a31);
  static const Color blank = Color(0xffeeeeee);
  final ThemeData _themeData = ThemeData(
    brightness: Brightness.dark,
    canvasColor: darker,
    primaryColor: accent,
    cardColor: dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      background: darker,
      onBackground: blank,
      secondary: dark,
      onSecondary: blank,
      error: accent,
      onError: darker,
      primary: accent,
      onPrimary: darker,
      surface: dark,
      onSurface: blank,
    ),
    textTheme: GoogleFonts.latoTextTheme(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financy',
      theme: _themeData,
      home: const ListViewScaffold(),
    );
  }
}
