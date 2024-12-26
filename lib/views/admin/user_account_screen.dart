import 'package:flutter/material.dart';

class UserAccountScreen extends StatefulWidget {
  const UserAccountScreen({super.key});
  @override
  State<UserAccountScreen> createState() => _UserState();
}

class _UserState extends State<UserAccountScreen> {
  late List<Map<String, dynamic>> users;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    users = [
      {
        'id': 1,
        'name': 'John Doe',
        'email': 'john@gmail.com',
        'role': 'user',
        'joinDate': '2024-01-15',
      },
      {
        'id': 2,
        'name': 'user',
        'email': 'user@gamil.com',
        'role': 'user',
        'joinDate': '2024-01-15',
      },
       {
    'id': 1,
    'name': 'John Doe',
    'email': 'john@gmail.com',
    'role': 'user',
    'joinDate': '2024-01-15'
  },
  {
    'id': 2,
    'name': 'Sarah Wilson',
    'email': 'sarah.w@gmail.com',
    'role': 'admin',
    'joinDate': '2024-01-18'
  },
  {
    'id': 3,
    'name': 'Michael Chen',
    'email': 'mchen@gmail.com',
    'role': 'user',
    'joinDate': '2024-01-20'
  },
  {
    'id': 4,
    'name': 'Emily Rodriguez',
    'email': 'emily.r@gmail.com',
    'role': 'user',
    'joinDate': '2024-01-22'
  },
  {
    'id': 5,
    'name': 'James Kumar',
    'email': 'jkumar@gmail.com',
    'role': 'moderator',
    'joinDate': '2024-01-25'
  },
  {
    'id': 6,
    'name': 'Lisa Thompson',
    'email': 'lisa.t@gmail.com',
    'role': 'user',
    'joinDate': '2024-01-27'
  },
  {
    'id': 7,
    'name': 'David Park',
    'email': 'dpark@gmail.com',
    'role': 'user',
    'joinDate': '2024-01-30'
  },
  {
    'id': 8,
    'name': 'Anna Martinez',
    'email': 'anna.m@gmail.com',
    'role': 'admin',
    'joinDate': '2024-02-01'
  },
  {
    'id': 9,
    'name': 'Robert Singh',
    'email': 'rsingh@gmail.com',
    'role': 'user',
    'joinDate': '2024-02-03'
  },
  {
    'id': 10,
    'name': 'Michelle Lee',
    'email': 'mlee@gmail.com',
    'role': 'moderator',
    'joinDate': '2024-02-05'
  }
    ];
  }

  void _editUser(Map<String, dynamic> user) {
    final nameController = TextEditingController(text: user['name']);
    final emailController = TextEditingController(text: user['email']);
    final roleController = TextEditingController(text: user['role']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Enter valid email'
                    : null,
              ),
              TextFormField(
                controller: roleController,
                decoration: InputDecoration(labelText: 'Role'),
                validator: (value) =>
                    value!.isEmpty ? 'Role is required' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  final index = users.indexWhere((u) => u['id'] == user['id']);
                  users[index] = {
                    ...user,
                    'name': nameController.text,
                    'email': emailController.text,
                    'role': roleController.text,
                  };
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User updated successfully')),
                );
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Color(
                  0xff0077B6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              elevation: 2,
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xff0077B6),
                  child: Text(
                    user['name'][0],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(user['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user['email']),
                    Text('Role: ${user['role']}'),
                  ],
                ),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xff0077B6)),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _editUser(user);
                    } else if (value == 'delete') {
                      // Add delete functionality
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
