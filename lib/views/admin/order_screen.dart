import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderState();
}

class _OrderState extends State<OrderScreen> {
  final List<Map<String, dynamic>> orders = [
    {
    'id': '1001',
    'customer': 'John Doe',
    'date': '2024-03-15',
    'status': 'Pending',
    'total': '9,999,000 KIP',
  },
  {
    'id': '1002',
    'customer': 'Sarah Wilson',
    'date': '2024-03-16',
    'status': 'Completed',
    'total': '5,500,000 KIP',
  },
  {
    'id': '1003',
    'customer': 'Michael Chen',
    'date': '2024-03-16',
    'status': 'Processing',
    'total': '12,750,000 KIP',
  },
  {
    'id': '1004',
    'customer': 'Emily Rodriguez',
    'date': '2024-03-17',
    'status': 'Delivered',
    'total': '3,200,000 KIP',
  },
  {
    'id': '1005',
    'customer': 'James Kumar',
    'date': '2024-03-17',
    'status': 'Pending',
    'total': '8,900,000 KIP',
  },
  {
    'id': '1006',
    'customer': 'Lisa Thompson',
    'date': '2024-03-18',
    'status': 'Cancelled',
    'total': '4,500,000 KIP',
  },
  {
    'id': '1007',
    'customer': 'David Park',
    'date': '2024-03-18',
    'status': 'Processing',
    'total': '15,800,000 KIP',
  },
  {
    'id': '1008',
    'customer': 'Anna Martinez',
    'date': '2024-03-19',
    'status': 'Completed',
    'total': '6,700,000 KIP',
  },
  {
    'id': '1009',
    'customer': 'Robert Singh',
    'date': '2024-03-19',
    'status': 'Delivered',
    'total': '11,300,000 KIP',
  },
  {
    'id': '1010',
    'customer': 'Michelle Lee',
    'date': '2024-03-20',
    'status': 'Pending',
    'total': '7,800,000 KIP',
  }
    // Add more sample orders as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  child: ExpansionTile(
                    title: Text('Order #${order['id']}'),
                    subtitle: Text('${order['date']} - ${order['status']}'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Customer: ${order['customer']}'),
                            Text('Total: ${order['total']}'),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Add update status functionality
                                  },
                                  child: Text('Update Status'),
                                ),
                                SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    // Add view details functionality
                                  },
                                  child: Text('View Details'),
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
    );
  }
}
