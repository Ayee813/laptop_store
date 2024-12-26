import 'package:flutter/material.dart';
import 'package:laptop_store/views/about_us_screen.dart';
import 'package:laptop_store/views/account_screen.dart';
import 'package:laptop_store/views/cart_provider.dart';
import 'package:laptop_store/views/home_screen.dart';
import 'package:laptop_store/views/it_euipment_screen.dart';
import 'package:laptop_store/views/laptop_screen.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<Widget> pages = [
    const HomePage(),
    NotebookPage(),
    ItEuipment(),
    const AboutUsPage(),
    CartPage(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('I have Pc'),
        backgroundColor: const Color(0xff0077B6),
        actions: [
          Consumer<CartProvider>(
            builder: (ctx, cart, child) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CartPage(isFromBottomBar: true)),
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountPage()),
              );
            },
            icon: const Icon(Icons.account_circle, color: Colors.white),
          ),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex < 4 ? _currentIndex : 0,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.laptop),
              label: 'Laptop',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.sd_storage_outlined),
              label: 'IT Equipment',
              backgroundColor: Color(0xff0077B6)),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About us',
              backgroundColor: Color(0xff0077B6)),
        ],
      ),
    );
  }
}
