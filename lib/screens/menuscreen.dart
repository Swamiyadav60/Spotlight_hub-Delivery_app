import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  final List<Map<String, String>> foodItems = [
    {
      'name': 'Pizza Margherita',
      'description': 'Classic cheese and tomato pizza',
      'price': '₹249',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Veg Burger',
      'description': 'Fresh veg patty with lettuce and cheese',
      'price': '₹149',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Pasta Alfredo',
      'description': 'Creamy white sauce pasta',
      'price': '₹199',
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'Paneer Tikka',
      'description': 'Grilled cottage cheese with spices',
      'price': '₹229',
      'image': 'https://via.placeholder.com/150',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MenuList",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text(item['name']!),
                    subtitle: Text(item['description']!),
                    trailing: Text(item['price']!),
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
