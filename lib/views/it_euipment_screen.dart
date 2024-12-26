import 'package:flutter/material.dart';
import 'package:laptop_store/screens/account_screen.dart';
import 'package:laptop_store/views/cart_provider.dart';
import 'package:laptop_store/views/check_out/add_information_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ItEuipment extends StatelessWidget {
  const ItEuipment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LaptopSalesPage(),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final EquipmentModel laptop;
  final List<EquipmentModel> allLaptops;

  const ProductDetailPage({super.key, 
    required this.laptop,
    required this.allLaptops,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0077B6),
        title: Text(
          laptop.name,
          style: const TextStyle(fontSize: 18, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
         actions: [
          Consumer<CartProvider>(
            builder: (ctx, cart, child) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              laptop.image,
              height: 450,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laptop.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formatter.format(laptop.price)} Kip',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            laptop.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addItem(
                                  id: laptop
                                      .name, // or equipment.name for ItEquipment
                                  name: laptop.name,
                                  image: laptop.image,
                                  price: laptop.price,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Added ${laptop.name} to cart')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: const Text(
                                'Add to Cart',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final cartProvider = Provider.of<CartProvider>(
                                    context,
                                    listen: false);
                                cartProvider.addItem(
                                  id: laptop.name,
                                  name: laptop.name,
                                  image: laptop.image,
                                  price: laptop.price,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddInformationPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                              child: const Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 32),
                  const Text(
                    'Other Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: allLaptops.length,
                    itemBuilder: (context, index) {
                      final otherLaptop = allLaptops[index];
                      if (otherLaptop == laptop) return const SizedBox.shrink();

                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  laptop: otherLaptop,
                                  allLaptops: allLaptops,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.asset(
                                  otherLaptop.image,
                                  width: double.infinity,
                                  height: 450,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      otherLaptop.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${formatter.format(otherLaptop.price)} Kip',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EquipmentModel {
  final String name;
  final String image;
  final int price;
  final String description;

  EquipmentModel({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });
}

class LaptopSalesPage extends StatefulWidget {
  const LaptopSalesPage({super.key});

  @override
  State<LaptopSalesPage> createState() => _LaptopSalesPageState();
}

class _LaptopSalesPageState extends State<LaptopSalesPage> {
  final List<EquipmentModel> equipments = [
    EquipmentModel(
      name: 'ACER 19V 3.42A 5.5x1.7 Original',
      image:
          'assets/images/ItEuipment/ACER-19V-3.42A-5.5x1.7-Original-NBC001.jpg',
      price: 250000,
      description:
          'Original ACER power adapter with 19V output at 3.42A, connector size 5.5x1.7mm',
    ),
    EquipmentModel(
      name: 'Cable LAN SSTP Cat7 5M Unitek',
      image:
          'assets/images/ItEuipment/Cable-LAN-SSTP-Cat7-5M-Unitek-C1812EBK-UNT255.jpg',
      price: 180000,
      description: 'High-speed Cat7 SSTP LAN cable, 5 meters length, by Unitek',
    ),
    EquipmentModel(
      name: 'Cable LAN UTP Cat6 5M Unitek',
      image:
          'assets/images/ItEuipment/Cable-LAN-UTP-Cat6-5M-Unitek-Y-C812ABL-UNT205.jpg',
      price: 120000,
      description:
          'Reliable Cat6 UTP network cable, 5 meters length, by Unitek',
    ),
    EquipmentModel(
      name: 'Cable USB 2.0 2M Unitek',
      image:
          'assets/images/ItEuipment/Cable-USB(2.0)-2M-Unitek-Y-C450gbk-UNT302.jpg',
      price: 50000,
      description: 'Standard USB 2.0 cable, 2 meters length, by Unitek',
    ),
    EquipmentModel(
      name: 'Cable VGA 10M OEM',
      image: 'assets/images/ItEuipment/Cable-VGA-10M-OEM-ADD019.jpg',
      price: 150000,
      description: 'VGA display cable, 10 meters length, OEM quality',
    ),
    EquipmentModel(
      name: 'HP DHE-8001U USB Headphone',
      image:
          'assets/images/ItEuipment/Headphone-HP-DHE-8001U-USB-Sound-7.1-LED-ADA199.jpg',
      price: 300000,
      description: '7.1 surround sound USB headphone with LED lighting',
    ),
    EquipmentModel(
      name: 'LENOVO Thinkplus G80 USB Headphone',
      image:
          'assets/images/ItEuipment/Headphone-LENOVO-thinkplus-G80-USB-Sound-7.1-RGB-ADA217.jpg',
      price: 350000,
      description: '7.1 surround sound USB headphone with RGB lighting',
    ),
    EquipmentModel(
      name: 'Ucom 208 USB Joystick',
      image: 'assets/images/ItEuipment/Joystick-Ucom-208-(One)--USB-ADH006.jpg',
      price: 150000,
      description: 'USB gaming joystick controller compatible with PC',
    ),
    EquipmentModel(
      name: 'Lenovo Lecoo MC01S Microphone',
      image:
          'assets/images/ItEuipment/Microphone-PC-Lenovo-Lecoo-MC01S-ADA302.jpg',
      price: 200000,
      description: 'PC microphone for clear audio recording and communication',
    ),
    EquipmentModel(
      name: 'SAMSUNG 990 PRO 2TB SSD',
      image:
          'assets/images/ItEuipment/SSD M.2 2280 NVME 2Tb PCIe Gen4 x4 SAMSUNG 990 PRO DTD882.jpg',
      price: 2500000,
      description: '2TB M.2 NVMe PCIe Gen4 x4 SSD for high-speed storage',
    ),
    EquipmentModel(
      name: 'Unitek Type-C Hub',
      image:
          'assets/images/ItEuipment/Type-C-to-HDMI-VGA-LAN-Gigabit-3USB-3.0-Type-C-PD-100W-SDCard-Unitek-D1113A-UNT908.jpg',
      price: 450000,
      description:
          'Multi-function Type-C hub with HDMI, VGA, LAN, USB 3.0, and PD charging',
    ),
    EquipmentModel(
      name: 'Ruijie Reyee RG-EW300T Router',
      image:
          'assets/images/ItEuipment/Wireless-Router-4G-300Mbps-Ruijie-Reyee-RG-EW300T-NET362.jpg',
      price: 550000,
      description:
          '4G wireless router with 300Mbps speed for reliable connectivity',
    ),
  ];

  late List<EquipmentModel> filteredLaptops;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLaptops = equipments;
  }

  void searchLaptops(String query) {
    setState(() {
      filteredLaptops = equipments.where((laptop) {
        final searchLower = query.toLowerCase();
        return laptop.name.toLowerCase().contains(searchLower) ||
            laptop.description.toLowerCase().contains(searchLower) ||
            laptop.price.toString().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, color: Color(0xff0077B6)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xff0077B6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xff0077B6), width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onChanged: searchLaptops,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredLaptops.length,
              itemBuilder: (context, index) {
                final laptop = filteredLaptops[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            laptop: laptop,
                            allLaptops: equipments,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Image.asset(
                                laptop.image,
                                width: double.infinity,
                                height: 400,
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                laptop.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${formatter.format(laptop.price)} Kip',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .addItem(
                                            id: laptop
                                                .name, // or equipment.name for ItEquipment
                                            name: laptop.name,
                                            image: laptop.image,
                                            price: laptop.price,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Added ${laptop.name} to cart')),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding:
                                              const EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        child: const Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          final cartProvider =
                                              Provider.of<CartProvider>(context,
                                                  listen: false);
                                          cartProvider.addItem(
                                            id: laptop.name,
                                            name: laptop.name,
                                            image: laptop.image,
                                            price: laptop.price,
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddInformationPage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding:
                                              const EdgeInsets.symmetric(vertical: 8),
                                        ),
                                        child: const Text(
                                          'Buy Now',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
