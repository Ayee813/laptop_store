import 'package:flutter/material.dart';
import 'package:laptop_store/views/bottom_bar.dart';
import 'package:laptop_store/views/check_out/add_information_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String id;
  final String name;
  final String image;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      image: image,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get totalAmount {
    var total = 0;
    _items.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addItem({
    required String id,
    required String name,
    required String image,
    required int price,
  }) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        id,
        () => CartItem(
          id: id,
          name: name,
          image: image,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) return;

    if (_items[id]!.quantity > 1) {
      _items.update(
        id,
        (existingItem) => existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

// cart_page.dart

class CartPage extends StatelessWidget {
  final bool isFromBottomBar;
  
  const CartPage({
    super.key, 
    this.isFromBottomBar = false
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (isFromBottomBar) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BottomBar()),
              );
            } else {
              Navigator.pop(context);
            }
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? const Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cart.items.values.toList()[i];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Text(
                            '${formatter.format(item.price)} Kip x ${item.quantity}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cart.removeSingleItem(item.id);
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cart.addItem(
                                    id: item.id,
                                    name: item.name,
                                    image: item.image,
                                    price: item.price,
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  cart.removeItem(item.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cart.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${formatter.format(cart.totalAmount)} Kip',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddInformationPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0077B6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
