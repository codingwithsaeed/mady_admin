import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/features/request/presentation/widgets/widgets.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';

class SingleSellerPage extends StatelessWidget {
  static const id = 'SingleSellerPage';
  const SingleSellerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Seller seller = ModalRoute.of(context)!.settings.arguments as Seller;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(seller.storeName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_sharp),
          )
        ],
      ),
      body: buildBody(context, seller),
    );
  }

  Widget buildBody(BuildContext context, Seller seller) {
    //TODO: must add all seller info here!
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          CircleLogo(logo: seller.logo),
          const SizedBox(
            height: 10.0,
          ),
          DetailsCard(
            //TODO: StoreName with number must be fixed.
            title: 'نام فروشگاه: ${seller.storeName}',
          ),
          DetailsCard(
            title: 'شماره موبایل: ${seller.phone.replaceFirst('+98', '0')}',
          ),
          DetailsCard(
            title: 'دسته بندی: ${seller.category}',
          ),
          DetailsCard(
            title: 'آدرس: ${seller.address}',
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
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }
}
