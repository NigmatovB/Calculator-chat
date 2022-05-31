import 'package:calculator/core/models/historyitem.dart';
import 'package:calculator/core/provider/calculator_provider.dart';
import 'package:calculator/screens/calculator.dart';
import 'package:calculator/screens/history.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:calculator/imports.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryItemAdapter());
  await Hive.openBox<HistoryItem>('history');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalculatorProvider>(
      create: (_) => CalculatorProvider(),
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: backgroundColor,
              brightness: Brightness.dark,
              appBarTheme: AppBarTheme(
                color: backgroundColor,
                elevation: 0.0,
              ),
              textTheme: TextTheme(
                headline3: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                caption: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                  fontSize: 18.0,
                ),
              ),
            ),
            routes: {
              '/': (context) => ( Calculator() ),
              '/history': (context) => History(),
            },
          );
        },
      ),
    );
  }
}
