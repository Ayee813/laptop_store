import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _laptopPageController = PageController();
  final PageController _equipmentPageController = PageController();
  Timer? _laptopTimer;
  Timer? _equipmentTimer;
  int _currentLaptopPage = 0;
  int _currentEquipmentPage = 0;

  // Define different delay durations
  static const Duration laptopDelay = Duration(seconds: 4); // 4 seconds for laptops
  static const Duration equipmentDelay = Duration(seconds: 2); // 2 seconds for equipment

  final List<String> _laptopPaths = [
    'assets/images/laptop/MSI-Thin-15-INTEL-i5-12450H-3.3Ghz-Max-Turbo-4.4Ghz-RAM-DDR4-16Gb-M.2-NVME-512Gb-RTX2050-4Gb-Monitor-15.6-LAP181.jpg',
    'assets/images/laptop/LENOVO LOQ 15IRH8 INTEL i5-13420H Max Turbo 4.6Ghz RAM DDR5 16Gb M.2 NVME 512Gb RTX3050 6Gb Monitor 15.6 LAP174.jpg',
    'assets/images/laptop/LENOVO-YOGA-7-(2024)-AMD-Ryzen-7-8840HS-Max-Turbo-5.1Ghz-RAM-LPDDR5-16Gb-M.2-NVME-1Tb-Monitor-14.0-LAP212.jpg',
    'assets/images/laptop/ACER Aspire Lite AL14-31P INTEL N100 3.6Ghz RAM LPDDR4 8Gb M.2 NVME 256Gb Monitor 14.0 LAP177.jpg',
    'assets/images/laptop/ASUS TUF Gaming F15 INTEL i9-13900H Max Turbo 5.4Ghz RAM DDR5 16Gb M.2 NVME 1Tb RTX4060 8Gb Monitor 15.6 LAP173.jpg',
    'assets/images/laptop/MSI-Thin-15-INTEL-i5-12450H-3.3Ghz-Max-Turbo-4.4Ghz-RAM-DDR4-16Gb-M.2-NVME-512Gb-RTX2050-4Gb-Monitor-15.6-LAP181.jpg',
    'assets/images/laptop/LENOVO-ThinkPad-L15-INTEL-i5-1345U-Max-Turbo-4.7Ghz-RAM-DDR4-32Gb-M.2-NVME-512Gb-Monitor-15.6-LAP179.jpg',
    'assets/images/laptop/HP-Victus-16-INTEL-i7-13620H-Max-Turbo-4.9Ghz-RAM-DDR5-16Gb-M.2-NVME-512Gb-RTX4060-8Gb-Monitor-15.6-LAP182.jpg'
  ];

  final List<String> _equipmentPaths = [
    'assets/images/ItEuipment/Headphone-LENOVO-thinkplus-G80-USB-Sound-7.1-RGB-ADA217.jpg',
    'assets/images/ItEuipment/Joystick-Ucom-208-(One)--USB-ADH006.jpg',
    'assets/images/ItEuipment/Microphone-PC-Lenovo-Lecoo-MC01S-ADA302.jpg',
    'assets/images/ItEuipment/SSD M.2 2280 NVME 2Tb PCIe Gen4 x4 SAMSUNG 990 PRO DTD882.jpg',
    'assets/images/ItEuipment/Type-C-to-HDMI-VGA-LAN-Gigabit-3USB-3.0-Type-C-PD-100W-SDCard-Unitek-D1113A-UNT908.jpg',
    'assets/images/ItEuipment/Wireless-Router-4G-300Mbps-Ruijie-Reyee-RG-EW300T-NET362.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _laptopTimer?.cancel();
    _equipmentTimer?.cancel();
    _laptopPageController.dispose();
    _equipmentPageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    // Timer for laptop slider - 4 seconds
    _laptopTimer = Timer.periodic(laptopDelay, (timer) {
      if (_laptopPageController.hasClients) {
        final nextPage = (_currentLaptopPage + 1) % (((_laptopPaths.length + 1) ~/ 2));
        _laptopPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });

    // Timer for equipment slider - 2 seconds
    _equipmentTimer = Timer.periodic(equipmentDelay, (timer) {
      if (_equipmentPageController.hasClients) {
        final nextPage = (_currentEquipmentPage + 1) % (((_equipmentPaths.length + 1) ~/ 2));
        _equipmentPageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Widget _buildImageSlider({
    required PageController controller,
    required List<String> imagePaths,
    required Function(int) onPageChanged,
  }) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: PageView.builder(
        controller: controller,
        onPageChanged: onPageChanged,
        itemCount: (imagePaths.length + 1) ~/ 2,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePaths[index * 2],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (index * 2 + 1 < imagePaths.length)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePaths[index * 2 + 1],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Laptop",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildImageSlider(
              controller: _laptopPageController,
              imagePaths: _laptopPaths,
              onPageChanged: (page) {
                setState(() {
                  _currentLaptopPage = page;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Equipment",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildImageSlider(
              controller: _equipmentPageController,
              imagePaths: _equipmentPaths,
              onPageChanged: (page) {
                setState(() {
                  _currentEquipmentPage = page;
                });
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}