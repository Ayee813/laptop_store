// main.dart
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laptop_store/services/add_product_service.dart';
import 'package:laptop_store/views/admin/admin_dash_board.dart';
import 'package:laptop_store/views/bottom_bar.dart';
import 'package:laptop_store/firebase_options.dart';
import 'package:laptop_store/views/login_screen.dart';
import 'package:laptop_store/views/check_out/add_information_screen.dart';
import 'package:laptop_store/services/auth_service.dart';

import 'package:provider/provider.dart';
import 'views/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => AddProductService())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    print(user);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/add-information': (context) => AddInformationPage(),
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff0077B6),
          foregroundColor: Colors.white,
        ),
      ),
      home: FutureBuilder<bool>(
        future: context.read<AuthService>().isAdmin(),
        builder: (context, snapshot) {
          log(snapshot.data.toString());
          if (user == null) return const LoginScreen();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          bool isAdmin = snapshot.data!;
          return isAdmin ? const AdminDashboard() : const BottomBar();
        },
      ),
    );
  }
}
