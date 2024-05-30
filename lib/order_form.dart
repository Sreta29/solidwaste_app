import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidwaste_app/order_details.dart'; // Import the OrderDetailsScreen widget

class Order {
  String? postCode;
  String? zone;
  String? address;
  int? gardenWastePacks;
  int? oversizedWasteItems;
  List<File>? selectedImages;

  bool isValid() {
    if (postCode == null ||
        zone == null ||
        address == null ||
        gardenWastePacks == null ||
        oversizedWasteItems == null ||
        selectedImages == null) {
      return false;
    }
    return true;
  }
}

class OrderForm extends StatefulWidget {
  const OrderForm({Key? key, required this.orderNumber}) : super(key: key);
  final String orderNumber;

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  Order order = Order();

  final _picker = ImagePicker();

  void _incrementGardenWastePacks() {
    setState(() {
      order.gardenWastePacks = (order.gardenWastePacks ?? 0) + 1;
    });
  }

  void _incrementOversizedWasteItems() {
    setState(() {
      order.oversizedWasteItems = (order.oversizedWasteItems ?? 0) + 1;
    });
  }

  Future<void> _uploadPhotos() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() {
      order.selectedImages =
          pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    });
  }

  void _submitForm() {
    if (order.isValid()) {
      // Navigate to order details page and pass order data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(
            orderNumber: widget.orderNumber,
            postCode: order.postCode!,
            zone: order.zone!,
            address: order.address!,
            gardenWastePacks: order.gardenWastePacks!,
            oversizedWasteItems: order.oversizedWasteItems!,
            selectedImages: order.selectedImages!,
          ),
        ),
      );
    } else {
      // Display error messages
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #${widget.orderNumber}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Collection Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Post Code',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: order.postCode,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      order.postCode = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: '82100',
                      child: Text('82100'),
                    ),
                    DropdownMenuItem<String>(
                      value: '86100',
                      child: Text('86100'),
                    ),
                    DropdownMenuItem<String>(
                      value: '81920',
                      child: Text('81920'),
                    ),
                    DropdownMenuItem<String>(
                      value: '86000',
                      child: Text('86000'),
                    ),
                    DropdownMenuItem<String>(
                      value: '83700',
                      child: Text('83700'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Zone',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: order.zone,
                  icon: const Icon(Icons.arrow_downward),
                  style: const TextStyle(color: Colors.black),
                  onChanged: (String? newValue) {
                    setState(() {
                      order.zone = newValue!;
                    });
                  },
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Bandar Penggaram',
                      child: Text('Bandar Penggaram'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Ayer Hitam',
                      child: Text('Ayer Hitam'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Senggarang',
                      child: Text('Senggarang'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Yong Peng',
                      child: Text('Yong Peng'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Rengit',
                      child: Text('Rengit'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => order.address = value,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => order.address = value,
              decoration: const InputDecoration(
                labelText: 'Address',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Garden Waste (RM1/pack)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number of packs:'),
                ElevatedButton(
                  onPressed: _incrementGardenWastePacks,
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('${order.gardenWastePacks ?? 0}'),
            const SizedBox(height: 16),
            const Text(
              'Oversized Waste (RM5/item)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Number of items:'),
                ElevatedButton(
                  onPressed: _incrementOversizedWasteItems,
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('${order.oversizedWasteItems ?? 0}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadPhotos,
              child: const Text('Upload Photos'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16),
            
            // Display the selected images
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: order.selectedImages
                      ?.map(
                          (image) => Image.file(image, width: 100, height: 100))
                      .toList() ??
                  [],
            ),
          ],
        ),
      ),
    );
  }
}

