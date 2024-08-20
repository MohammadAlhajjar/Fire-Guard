import '../core/colors.dart';
import '../widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PickLocationPage extends StatefulWidget {
  const PickLocationPage({super.key});

  @override
  State<PickLocationPage> createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  bool locationIsPicked = false;
  late LatLng? pickedLocationPoint = const LatLng(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pick Location'),
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppButton(
              onPressed: () {
                Navigator.pop(context, pickedLocationPoint);
              },
              title: 'Done',
            ),
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(34.8021, 38.9968),
          initialZoom: 7,
          onLongPress: (tapPosition, point) {
            setState(() {
              pickedLocationPoint = point;
              locationIsPicked = true;
            });
            // print(point);
            // print(pickedLocationPoint);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          locationIsPicked
              ? MarkerLayer(
                  markers: [
                    Marker(
                      point: pickedLocationPoint ?? const LatLng(0, 0),
                      child: const Icon(
                        Icons.location_on_sharp,
                        size: 40,
                        color: primaryColor,
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
