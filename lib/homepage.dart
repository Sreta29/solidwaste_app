import 'package:flutter/material.dart';
import 'package:solidwaste_app/update_profile.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool changePage = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      changePage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!changePage) {
      return const UpdateProfilePage(
        userName: '',
        userProfilePicture: '',
      );
    }
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User profile section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    changePage = !changePage;
                  });
                },
                child: const Row(
                  children: [
                    
                    SizedBox(width: 10),
                    Text(
                      'User Name', // Replace with actual user name
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Welcome to Solid Waste Sales and Collection System',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Completed orders section
          const Text(
            'Orders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // List of completed orders
          // Replace this with the actual list of completed orders
          // For demonstration, a sample list is shown here
          _buildCompletedOrdersList(),
        ],
      ),
    );
  }

  Widget _buildCompletedOrdersList() {
    List<String> completedOrders = []; // Replace with actual completed orders
    if (completedOrders.isEmpty) {
      return const Text(
        'No order has been made',
        style: TextStyle(fontSize: 16),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: completedOrders
            .map((order) => ListTile(
                  title: Text(order),
                  // Add other order details here as needed
                ))
            .toList(),
      );
    }
  }
}