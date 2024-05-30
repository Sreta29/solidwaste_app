import 'package:flutter/material.dart';

import 'dart:math';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:solidwaste_app/components/appBar.dart';
import 'package:solidwaste_app/components/notificationdrawers.dart';
import 'package:solidwaste_app/pages/neworder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: 'Dashboard',
        actions: [
          IconButton(
            icon: const Icon(BoxIcons.bx_plus_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewOrderPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show the NotificationDrawer
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const NotificationDrawer();
                },
              );
            },
          ),
        ],
        showBackButton: false,
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            user(),
            const SizedBox(height: 10),
            const Expanded(child: OrdersList()),
          ],
        ),
      ),
    );
  }

  Container user() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue[100],
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.rawpixel.com/image_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGQxOS1taW50eS0wMS1sZWFmLmpwZw.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: const NetworkImage(
              'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, User!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Welcome to Waste Grab!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = '';
  String currentStatus = 'all';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _getOrderStatus() {
    final Random random = Random();
    final statuses = ['Scheduled', 'Collected', 'Rated'];
    return statuses[random.nextInt(statuses.length)];
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Scheduled':
        return Colors.blue;
      case 'Collected':
        return Colors.teal;
      case 'Rated':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Orders',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 211, 211, 211)),
                ),
                hintText: 'Search Order',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TabBar(
              indicator: BoxDecoration(
                color: _getStatusColor(currentStatus),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'Scheduled'),
                Tab(text: 'Collected'),
                Tab(text: 'Rated'),
              ],
              onTap: (index) {
                setState(() {
                  switch (index) {
                    case 0:
                      currentStatus = 'all';
                      break;
                    case 1:
                      currentStatus = 'Scheduled';
                      break;
                    case 2:
                      currentStatus = 'Collected';
                      break;
                    case 3:
                      currentStatus = 'Rated';
                      break;
                    default:
                      currentStatus = 'all';
                      break;
                  }
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _buildOrderList('all'),
                  _buildOrderList('Scheduled'),
                  _buildOrderList('Collected'),
                  _buildOrderList('Rated'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return ListView.builder(
      itemCount: 10, // Assuming 10 orders
      itemBuilder: (context, index) {
        // Generate random date and time
        DateTime randomDateTime = _generateRandomDateTime();
        String formattedDateTime =
            DateFormat('dd/MM/yyyy hh:mm a').format(randomDateTime);
        String orderStatus = _getOrderStatus();
        // Filter orders based on the search query
        if (_filter.isNotEmpty &&
            !('Order $index'.toLowerCase().contains(_filter.toLowerCase()))) {
          return const SizedBox.shrink();
        }
        // Filter based on search query and status (except "All" tab)
        if (status != 'all' && orderStatus != status) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            title: Text(
              'Order #$index',
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(formattedDateTime),
            trailing: Container(
              width: 80,
              decoration: BoxDecoration(
                color: _getStatusColor(orderStatus),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  textAlign: TextAlign.center,
                  orderStatus,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Function to generate random DateTime
DateTime _generateRandomDateTime() {
  Random random = Random();
  int minYear = 2000;
  int maxYear = DateTime.now().year;
  int year = minYear + random.nextInt(maxYear - minYear + 1);
  int month = 1 + random.nextInt(12);
  int day = 1 + random.nextInt(31);
  int hour = random.nextInt(24);
  int minute = random.nextInt(60);
  int second = random.nextInt(60);
  return DateTime(year, month, day, hour, minute, second);
}
