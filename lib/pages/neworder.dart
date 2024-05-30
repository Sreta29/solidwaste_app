import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidwaste_app/components/appBar.dart';
import 'package:solidwaste_app/components/notificationdrawers.dart';

const List<String> _address = [
  'Lot 1234, Lorong Ceria, Bandar Baru Sentul, 51000 Kuala Lumpur, Malaysia',
  '1, Jalan Riang, Bangsar, 59000 Kuala Lumpur, Malaysia',
  'No. 1, Jalan 1/1, Taman Tun Dr Ismail, 60000 Kuala Lumpur, Malaysia',
];

class Order {
  String? postCode;
  String? zone;
  String? address;
  int gardenWastePacks = 0;
  int oversizedWasteItems = 0;
  List<File>? selectedImages;

  bool isValid() {
    int total = gardenWastePacks + oversizedWasteItems;
    if (postCode == null ||
        zone == null ||
        address == null ||
        total == 0 ||
        selectedImages == null) {
      return false;
    }
    return true;
  }
}

class NewOrderPage extends StatefulWidget {
  const NewOrderPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NewOrderPageState createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  Order order = Order();

  final _picker = ImagePicker();

  void _incrementGardenWastePacks() {
    setState(() {
      order.gardenWastePacks = (order.gardenWastePacks) + 1;
    });
  }

  void _incrementOversizedWasteItems() {
    setState(() {
      order.oversizedWasteItems = (order.oversizedWasteItems) + 1;
    });
  }

  Future<void> _uploadPhotos() async {
    final pickedImages = await _picker.pickMultiImage();
    setState(() {
      order.selectedImages ??= [];
      order.selectedImages!.addAll(
        pickedImages.map((pickedImage) => File(pickedImage.path)).toList(),
      );
    });
  }

  void _submitForm() {
    if (order.isValid()) {
      // Proceed with form submission
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("You've clicked on 'Place an Order"),
      ));
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
        appBar: appBar(
          title: 'New Order',
          actions: [
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
          showBackButton: true,
          onBackButtonPressed: () {
            Navigator.pop(context);
          },
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              location(context),
              const SizedBox(height: 20),
              photos(),
              const SizedBox(height: 20),
              types(),
              const SizedBox(height: 20),
              price(),
              submit(),
            ]),
          ),
        ));
  }

  Column types() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Type of waste',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Please select the type of waste you want to dispose.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
            ),
            Icon(BoxIcons.bxs_trash, size: 50, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 10),
        Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/test.svg',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                      width:
                          10), // Add some space between the icon and the text (optional
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Garden Waste',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'RM 1 per pack',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (order.gardenWastePacks > 0) {
                          order.gardenWastePacks = order.gardenWastePacks - 1;
                        }
                      });
                    },
                  ),
                  Text(order.gardenWastePacks.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementGardenWastePacks,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/test.svg',
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                      width:
                          10), // Add some space between the icon and the text (optional
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Oversized Waste',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'RM 5 per item',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (order.oversizedWasteItems > 0) {
                          order.oversizedWasteItems =
                              order.oversizedWasteItems - 1;
                        }
                      });
                    },
                  ),
                  Text(order.oversizedWasteItems.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementOversizedWasteItems,
                  ),
                ],
              ),
            ],
          ),
        ]),
      ],
    );
  }

  Column price() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Note: A minimum fee of RM10 is applicable.'),
        const Text('Note: A minimum of 1 item per order is required.'),
        const SizedBox(height: 10),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Total item: ${order.gardenWastePacks + order.oversizedWasteItems}',
                textAlign: TextAlign.left),
            Text(
                'RM: ${order.gardenWastePacks * 1 + order.oversizedWasteItems * 5}',
                textAlign: TextAlign.left),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total fee:', textAlign: TextAlign.left),
            Text('RM: 10', textAlign: TextAlign.left),
          ],
        ),
        const SizedBox(height: 10),
        const DottedLine(
          dashLength: 5,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Total:', textAlign: TextAlign.left),
            Text(
                'RM: ${order.gardenWastePacks * 1 + order.oversizedWasteItems * 5 + 10}',
                textAlign: TextAlign.left),
          ],
        )
      ],
    );
  }

  Column location(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Location',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Please select the location of the waste collection.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
            ),
            Icon(BoxIcons.bxs_map_pin, size: 50, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 10),
        CustomDropdown<String>(
          decoration: CustomDropdownDecoration(
            closedBorder:
                Border.all(color: const Color.fromARGB(255, 211, 211, 211)),
          ),
          hintText: 'Select location',
          items: _address,
          initialItem: _address[0],
          onChanged: (value) {},
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add new address? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("You've clicked on 'Add new address'"),
                ));
              },
              child: const Text(
                'Click here',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Column photos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Trash photos',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Please provide the photos of the collected items.',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(),
              ),
            ),
            Icon(BoxIcons.bxs_file_image, size: 50, color: Colors.red),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: _uploadPhotos,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(BoxIcons.bx_image_add,
                      size: 50, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: order.selectedImages
                          ?.map((image) => Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: FileImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          order.selectedImages?.remove(image);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList() ??
                      [],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget submit() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0xFF0071D1)),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        elevation: MaterialStateProperty.all(5),
      ),
      onPressed: _submitForm,
      child:
          const Text('Place an Order', style: TextStyle(color: Colors.white)),
    );
  }
}
