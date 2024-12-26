import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff0077B6),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.email, color: Color(0xff0077B6)),
              title: const Text('Email'),
              subtitle: const Text('yongyeelove813@gmail.com'),
              onTap: () {
                // Add email handling logic
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xff0077B6)),
              title: const Text('Phone'),
              subtitle: const Text('+856 2097 364 057'),
              onTap: () {
                // Add phone call handling logic
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Color(0xff0077B6),
              ),
              title: const Text('Address'),
              subtitle: const Text(
                  'Vientaine capito, Xaythani Distric, Tanmixay village'),
              onTap: () {
                // Add location handling logic
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Follow Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff0077B6),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook,
                      color: Color(0xff0077B6), size: 40),
                  onPressed: () {
                    // Add Facebook link
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.telegram,
                      color: Color(0xff0077B6), size: 40),
                  onPressed: () {
                    // Add Twitter link
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.description,
                      color: Color(0xff0077B6), size: 40),
                  onPressed: () {
                    // Add LinkedIn link
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
