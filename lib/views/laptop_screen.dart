import 'package:flutter/material.dart';
import 'package:laptop_store/views/account_screen.dart';
import 'package:laptop_store/views/cart_provider.dart';
import 'package:laptop_store/views/check_out/add_information_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotebookPage extends StatelessWidget {
  const NotebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LaptopSalesPage(),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final LaptopModel laptop;
  final List<LaptopModel> allLaptops;

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
                                    fontSize: 14, color: Colors.white),
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
                                    fontSize: 14, color: Colors.white),
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
                                  fit: BoxFit.cover,
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

class LaptopModel {
  final String name;
  final String image;
  final int price;
  final String description;

  LaptopModel({
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
  final List<LaptopModel> laptops = [
    LaptopModel(
      name: 'ACER Aspire Lite AL14-31P',
      image:
          'assets/images/laptop/ACER Aspire Lite AL14-31P INTEL N100 3.6Ghz RAM LPDDR4 8Gb M.2 NVME 256Gb Monitor 14.0 LAP177.jpg',
      price: 6500000,
      description:
          'Equipped with Intel N100 processor reaching 3.6GHz, 8GB LPDDR4 RAM, and 256GB M.2 NVMe storage. Features a 14.0-inch display.',
    ),
    LaptopModel(
      name: 'ASUS TUF Gaming F15',
      image:
          'assets/images/laptop/ASUS TUF Gaming F15 INTEL i9-13900H Max Turbo 5.4Ghz RAM DDR5 16Gb M.2 NVME 1Tb RTX4060 8Gb Monitor 15.6 LAP173.jpg',
      price: 28900000,
      description:
          'Powered by Intel i9-13900H with max turbo of 5.4GHz, 16GB DDR5 RAM, 1TB M.2 NVMe storage, and RTX 4060 8GB graphics. Showcases content on a 15.6-inch display.',
    ),
    LaptopModel(
      name: 'DELL Inspiron 15',
      image:
          'assets/images/laptop/DELL Inspiron 15 3530 INTEL i7-1355U Max Turbo 5.0Ghz RAM DDR4 16Gb M.2 NVME 512Gb Monitor 15.6 LAP176.jpg',
      price: 15900000,
      description:
          'Features Intel i7-1355U processor with max turbo of 5.0GHz, 16GB DDR4 RAM, and 512GB M.2 NVMe storage. Comes with a 15.6-inch display.',
    ),
    LaptopModel(
      name: 'HP-Victus-16',
      image:
          'assets/images/laptop/HP-Victus-16-INTEL-i7-13620H-Max-Turbo-4.9Ghz-RAM-DDR5-16Gb-M.2-NVME-512Gb-RTX4060-8Gb-Monitor-15.6-LAP182.jpg',
      price: 25900000,
      description:
          'Runs on Intel i7-13620H reaching 4.9GHz, 16GB DDR5 RAM, 512GB M.2 NVMe storage, and RTX 4060 8GB graphics. Sports a 15.6-inch display.',
    ),
    LaptopModel(
      name: 'LENOVO LOQ 15IRH8',
      image:
          'assets/images/laptop/LENOVO LOQ 15IRH8 INTEL i5-13420H Max Turbo 4.6Ghz RAM DDR5 16Gb M.2 NVME 512Gb RTX3050 6Gb Monitor 15.6 LAP174.jpg',
      price: 18900000,
      description:
          'Powered by Intel i5-13420H with max turbo of 4.6GHz, 16GB DDR5 RAM, 512GB M.2 NVMe storage, and RTX 3050 6GB graphics. Features a 15.6-inch display.',
    ),
    LaptopModel(
      name: 'LENOVO ThinkPad L15',
      image:
          'assets/images/laptop/LENOVO-ThinkPad-L15-INTEL-i5-1345U-Max-Turbo-4.7Ghz-RAM-DDR4-32Gb-M.2-NVME-512Gb-Monitor-15.6-LAP179.jpg',
      price: 16900000,
      description:
          'Equipped with Intel i5-1345U reaching 4.7GHz, 32GB DDR4 RAM, and 512GB M.2 NVMe storage. Includes a 15.6-inch display.',
    ),
    LaptopModel(
      name: 'LENOVO YOGA 7 (2024)',
      image:
          'assets/images/laptop/LENOVO-YOGA-7-(2024)-AMD-Ryzen-7-8840HS-Max-Turbo-5.1Ghz-RAM-LPDDR5-16Gb-M.2-NVME-1Tb-Monitor-14.0-LAP212.jpg',
      price: 21900000,
      description:
          'Features AMD Ryzen 7 8840HS with max turbo of 5.1GHz, 16GB LPDDR5 RAM, and 1TB M.2 NVMe storage. Showcases content on a 14.0-inch display.',
    ),
    LaptopModel(
      name: 'MSI Thin 15',
      image:
          'assets/images/laptop/MSI-Thin-15-INTEL-i5-12450H-3.3Ghz-Max-Turbo-4.4Ghz-RAM-DDR4-16Gb-M.2-NVME-512Gb-RTX2050-4Gb-Monitor-15.6-LAP181.jpg',
      price: 15900000,
      description:
          'Runs on Intel i5-12450H reaching 4.4GHz, 16GB DDR4 RAM, 512GB M.2 NVMe storage, and RTX 2050 4GB graphics. Includes a 15.6-inch display.',
    )
  ];

  late List<LaptopModel> filteredLaptops;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredLaptops = laptops;
  }

  void searchLaptops(String query) {
    setState(() {
      filteredLaptops = laptops.where((laptop) {
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
                hintText: 'Search laptops...',
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
                            allLaptops: laptops,
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
                                fit: BoxFit.cover,
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
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
                                                Provider.of<CartProvider>(
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
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
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
                                  )),
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
