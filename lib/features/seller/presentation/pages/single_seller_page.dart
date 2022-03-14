import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/utils/consts.dart';

class SingleSellerPage extends StatelessWidget {
  static const id = 'SingleSellerPage';
  const SingleSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Seller seller = ModalRoute.of(context)!.settings.arguments as Seller;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          seller.storeName,
          textDirection: TextDirection.ltr,
        ),
        centerTitle: true,
      ),
      body: buildBody(context, seller),
    );
  }

  Widget buildBody(BuildContext context, Seller seller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          XCircleLogo(logo: seller.logo),
          const SizedBox(
            height: 10.0,
          ),
          XDetailsCard(
            name: 'نام فروشگاه:',
            value: seller.storeName,
          ),
          XDetailsCard(
            name: 'شماره موبایل:',
            value: seller.phone.replaceFirst('+98', '0'),
          ),
          XDetailsCard(
            name: 'دسته بندی:',
            value: seller.category,
          ),
          XDetailsCard(
            name: 'آدرس:',
            value: seller.address,
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(seller.lat),
                    double.parse(seller.lng),
                  ),
                  zoom: 16.8,
                ),
              ),
            ),
          ),
          XDetailsCard(
            name: 'بسته:',
            value: Consts.pocketTitles[int.parse(seller.pocket)],
          ),
          XDetailsCard(
            name: 'انقضای بسته:‌',
            value: seller.expire,
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
