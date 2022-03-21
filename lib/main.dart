import 'package:app_consulta/provider/cuenta_provider.dart';
import 'package:app_consulta/provider/guia_provider.dart';
import 'package:app_consulta/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState()); 
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CuentaProvider()), 
        ChangeNotifierProvider(create: (_) => GuiaProvider()), 
      ],
      child: const MyApp(),
    );
  } 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: 'login',
      theme: ThemeData(
          primaryColor: const Color.fromRGBO(10, 31, 68, 1.0),
          disabledColor: const Color.fromRGBO(142, 142, 255, 1.2),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.white)),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color.fromRGBO(255, 148, 0, 1.8))),
    );
  }
}
