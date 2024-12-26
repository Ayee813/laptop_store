import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laptop_store/views/admin/add_product_modal.dart';

class AdminProductModel {
  final String name;
  final String image;
  final int price;
  final String description;
  final String category;

  AdminProductModel({
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
  });
}

class EditProductDialog extends StatefulWidget {
  final AdminProductModel product;

  const EditProductDialog({super.key, required this.product});

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _selectedCategory;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.product.category;
    _nameController = TextEditingController(text: widget.product.name);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _descriptionController =
        TextEditingController(text: widget.product.description);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Product'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: ['Laptop', 'IT Equipment']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price (Kip)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Return the updated product data
              final updatedProduct = AdminProductModel(
                name: _nameController.text,
                image: widget.product.image, // Keep the same image
                price: int.parse(_priceController.text),
                description: _descriptionController.text,
                category: _selectedCategory,
              );
              Navigator.pop(context, updatedProduct);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class ProductsManagementPage extends StatefulWidget {
  const ProductsManagementPage({super.key});

  @override
  State<ProductsManagementPage> createState() => _ProductsManagementPageState();
}

class _ProductsManagementPageState extends State<ProductsManagementPage> {
  final List<AdminProductModel> allProducts = [
    // Laptops
    AdminProductModel(
      name: 'ACER Aspire Lite AL14-31P',
      image:
          'assets/images/laptop/ACER Aspire Lite AL14-31P INTEL N100 3.6Ghz RAM LPDDR4 8Gb M.2 NVME 256Gb Monitor 14.0 LAP177.jpg',
      price: 6500000,
      description:
          'Equipped with Intel N100 processor reaching 3.6GHz, 8GB LPDDR4 RAM, and 256GB M.2 NVMe storage.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'ASUS TUF Gaming F15',
      image:
          'assets/images/laptop/ASUS TUF Gaming F15 INTEL i9-13900H Max Turbo 5.4Ghz RAM DDR5 16Gb M.2 NVME 1Tb RTX4060 8Gb Monitor 15.6 LAP173.jpg',
      price: 28900000,
      description:
          'Powered by Intel i9-13900H with max turbo of 5.4GHz, 16GB DDR5 RAM, 1TB M.2 NVMe storage.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'ACER Aspire Lite AL14-31P',
      image:
          'assets/images/laptop/ACER Aspire Lite AL14-31P INTEL N100 3.6Ghz RAM LPDDR4 8Gb M.2 NVME 256Gb Monitor 14.0 LAP177.jpg',
      price: 6500000,
      description:
          'Equipped with Intel N100 processor reaching 3.6GHz, 8GB LPDDR4 RAM, and 256GB M.2 NVMe storage. Features a 14.0-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'ASUS TUF Gaming F15',
      image:
          'assets/images/laptop/ASUS TUF Gaming F15 INTEL i9-13900H Max Turbo 5.4Ghz RAM DDR5 16Gb M.2 NVME 1Tb RTX4060 8Gb Monitor 15.6 LAP173.jpg',
      price: 28900000,
      description:
          'Powered by Intel i9-13900H with max turbo of 5.4GHz, 16GB DDR5 RAM, 1TB M.2 NVMe storage, and RTX 4060 8GB graphics. Showcases content on a 15.6-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'DELL Inspiron 15',
      image:
          'assets/images/laptop/DELL Inspiron 15 3530 INTEL i7-1355U Max Turbo 5.0Ghz RAM DDR4 16Gb M.2 NVME 512Gb Monitor 15.6 LAP176.jpg',
      price: 15900000,
      description:
          'Features Intel i7-1355U processor with max turbo of 5.0GHz, 16GB DDR4 RAM, and 512GB M.2 NVMe storage. Comes with a 15.6-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'HP-Victus-16',
      image:
          'assets/images/laptop/HP-Victus-16-INTEL-i7-13620H-Max-Turbo-4.9Ghz-RAM-DDR5-16Gb-M.2-NVME-512Gb-RTX4060-8Gb-Monitor-15.6-LAP182.jpg',
      price: 25900000,
      description:
          'Runs on Intel i7-13620H reaching 4.9GHz, 16GB DDR5 RAM, 512GB M.2 NVMe storage, and RTX 4060 8GB graphics. Sports a 15.6-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'LENOVO LOQ 15IRH8',
      image:
          'assets/images/laptop/LENOVO LOQ 15IRH8 INTEL i5-13420H Max Turbo 4.6Ghz RAM DDR5 16Gb M.2 NVME 512Gb RTX3050 6Gb Monitor 15.6 LAP174.jpg',
      price: 18900000,
      description:
          'Powered by Intel i5-13420H with max turbo of 4.6GHz, 16GB DDR5 RAM, 512GB M.2 NVMe storage, and RTX 3050 6GB graphics. Features a 15.6-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'LENOVO ThinkPad L15',
      image:
          'assets/images/laptop/LENOVO-ThinkPad-L15-INTEL-i5-1345U-Max-Turbo-4.7Ghz-RAM-DDR4-32Gb-M.2-NVME-512Gb-Monitor-15.6-LAP179.jpg',
      price: 16900000,
      description:
          'Equipped with Intel i5-1345U reaching 4.7GHz, 32GB DDR4 RAM, and 512GB M.2 NVMe storage. Includes a 15.6-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'LENOVO YOGA 7 (2024)',
      image:
          'assets/images/laptop/LENOVO-YOGA-7-(2024)-AMD-Ryzen-7-8840HS-Max-Turbo-5.1Ghz-RAM-LPDDR5-16Gb-M.2-NVME-1Tb-Monitor-14.0-LAP212.jpg',
      price: 21900000,
      description:
          'Features AMD Ryzen 7 8840HS with max turbo of 5.1GHz, 16GB LPDDR5 RAM, and 1TB M.2 NVMe storage. Showcases content on a 14.0-inch display.',
      category: 'Laptop',
    ),
    AdminProductModel(
      name: 'MSI Thin 15',
      image:
          'assets/images/laptop/MSI-Thin-15-INTEL-i5-12450H-3.3Ghz-Max-Turbo-4.4Ghz-RAM-DDR4-16Gb-M.2-NVME-512Gb-RTX2050-4Gb-Monitor-15.6-LAP181.jpg',
      price: 15900000,
      description:
          'Runs on Intel i5-12450H reaching 4.4GHz, 16GB DDR4 RAM, 512GB M.2 NVMe storage, and RTX 2050 4GB graphics. Includes a 15.6-inch display.',
      category: 'Laptop',
    ),
    // IT Equipment
    AdminProductModel(
      name: 'ACER 19V 3.42A 5.5x1.7 Original',
      image:
          'assets/images/ItEuipment/ACER-19V-3.42A-5.5x1.7-Original-NBC001.jpg',
      price: 250000,
      description: 'Original ACER power adapter with 19V output at 3.42A',
      category: 'IT Equipment',
    ),
    AdminProductModel(
      name: 'Cable LAN SSTP Cat7 5M Unitek',
      image:
          'assets/images/ItEuipment/Cable-LAN-SSTP-Cat7-5M-Unitek-C1812EBK-UNT255.jpg',
      price: 180000,
      description: 'High-speed Cat7 SSTP LAN cable, 5 meters length',
      category: 'IT Equipment',
    ),
  ];

  late List<AdminProductModel> filteredProducts;
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    filteredProducts = allProducts;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = allProducts.where((product) {
        final matchesCategory =
            selectedCategory == 'All' || product.category == selectedCategory;
        final matchesSearch =
            product.name.toLowerCase().contains(query.toLowerCase()) ||
                product.description.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  Future<void> _editProduct(BuildContext context, int index) async {
    final product = filteredProducts[index];
    final result = await showDialog<AdminProductModel>(
      context: context,
      builder: (context) => EditProductDialog(product: product),
    );

    if (result != null) {
      setState(() {
        // Find the index in the original list
        final originalIndex =
            allProducts.indexWhere((p) => p.name == product.name);
        if (originalIndex != -1) {
          allProducts[originalIndex] = result;
          filterProducts(searchController.text); // Refresh the filtered list
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
    }
  }

  Future<void> _deleteProduct(BuildContext context, int index) async {
    final product = filteredProducts[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete ${product.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        allProducts.removeWhere((p) => p.name == product.name);
        filterProducts(searchController.text); // Refresh the filtered list
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,###', 'en_US');

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: filterProducts,
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedCategory,
                  items: ['All', 'Laptop', 'IT Equipment']
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      filterProducts(searchController.text);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Image.asset(
                                product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${formatter.format(product.price)} Kip',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    onPressed: () =>
                                        _editProduct(context, index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        size: 20, color: Colors.red),
                                    onPressed: () =>
                                        _deleteProduct(context, index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddProductModal(),
              fullscreenDialog: true,
            ),
          );
        },
        backgroundColor: const Color(0xff0077B6),
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
