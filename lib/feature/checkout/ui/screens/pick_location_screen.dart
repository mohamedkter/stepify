import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({Key? key}) : super(key: key);

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  String? selectedAddress;
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Order Address"),
        centerTitle: true,
      ),
      body:OpenStreetMapSearchAndPick(
          buttonTextStyle:
              const TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
          buttonColor: Colors.blue,
          buttonText: 'Set Current Location',
          onPicked: (pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            print(pickedData.address);
            print(pickedData.addressName);
          },
        )
    );
  }
}
