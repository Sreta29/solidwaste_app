import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  final LatLng? currentLocation;
  const MapScreen(
      {super.key, this.currentLocation, required this.onLocationSelected});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () async {
              if (widget.currentLocation != null) {
                widget.onLocationSelected(widget.currentLocation!);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0.0, 0.0),
          zoom: 15.0,
        ),
        onTap: (LatLng location) {
          mapController.animateCamera(CameraUpdate.newLatLng(location));
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}