import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starkzapp_project/presentation/providers/user_provider.dart';
import 'package:starkzapp_project/presentation/screens/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
            ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Profile Explorer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

