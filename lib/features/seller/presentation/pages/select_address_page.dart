import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';

class SellectAddressPage extends StatefulWidget {
  static const id = 'SellectAddress';
  const SellectAddressPage({Key? key}) : super(key: key);

  @override
  State<SellectAddressPage> createState() => _SellectAddressPageState();
}

class _SellectAddressPageState extends State<SellectAddressPage> {
  late Set<Marker> markers;
  @override
  void initState() {
    super.initState();
    markers = <Marker>{};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب آدرس'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (markers.isEmpty) {
                  showSnackbar(context, message: 'مکان مورد نظر را لمس کنید');
                  return;
                }
                Navigator.pop(context, markers.first.position);
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(32.646472, 51.667644),
          zoom: 16.8,
        ),
        markers: markers,
        onTap: (pos) {
          markers.clear();
          setState(() => markers
              .add(Marker(markerId: const MarkerId('1'), position: pos)));
        },
      ),
    );
  }
}
