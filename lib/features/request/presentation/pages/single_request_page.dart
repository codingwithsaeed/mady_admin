import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';

class SingleRequestPage extends StatelessWidget {
  static const id = 'SingleRequestPage';
  const SingleRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Request request =
        ModalRoute.of(context)!.settings.arguments as Request;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(request.storeName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_sharp),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            CircleLogo(logo: request.logo),
            const SizedBox(
              height: 10.0,
            ),
            DetailsCard(
              title: 'نام فروشگاه: ${request.storeName}',
            ),
            DetailsCard(
              title: 'شماره موبایل: ${request.phone.replaceFirst('+98', '0')}',
            ),
            DetailsCard(
              title: 'دسته بندی: ${request.category}',
            ),
            DetailsCard(
              title: 'آدرس: ${request.address}',
            ),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.parse(request.lat),
                      double.parse(request.lng),
                    ),
                    zoom: 16.8,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {},
                      color: Colors.red,
                      child: const Text(
                        'رد درخواست',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onPressed: () {},
                      color: Colors.green,
                      child: const Text(
                        'قبول درخواست',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      textColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

class CircleLogo extends StatelessWidget {
  const CircleLogo({
    Key? key,
    required this.logo,
  }) : super(key: key);

  final String logo;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(logo),
        ),
      ],
      alignment: AlignmentDirectional.center,
    );
  }
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.0),
      child: ListTile(
          title: Text(
            title,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          horizontalTitleGap: 10.0,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 15)),
    );
  }
}
