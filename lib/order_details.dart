import 'dart:io';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderNumber;
  final String postCode;
  final String zone;
  final String address;
  final int gardenWastePacks;
  final int oversizedWasteItems;
  final List<File> selectedImages;

  const OrderDetailsScreen({
    super.key,
    required this.orderNumber,
    required this.postCode,
    required this.zone,
    required this.address,
    required this.gardenWastePacks,
    required this.oversizedWasteItems,
    required this.selectedImages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order #$orderNumber Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Collection Address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Post Code: $postCode',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Zone: $zone',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Address: $address',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Garden Waste (RM1/pack):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Number of packs: $gardenWastePacks',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Oversized Waste (RM5/item):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Number of items: $oversizedWasteItems',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'Uploaded Photos:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: selectedImages
                  .map((image) => Image.file(image, width: 100, height: 100))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}


