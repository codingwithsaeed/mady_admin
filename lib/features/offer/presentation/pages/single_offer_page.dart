import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/core/utils/utils.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/core/x/x_widgets.dart';

class SingleOfferPage extends StatelessWidget {
  static const id = 'SingleOfferPage';
  const SingleOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Offer offer = ModalRoute.of(context)!.settings.arguments as Offer;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          offer.content,
          textDirection: TextDirection.ltr,
        ),
        centerTitle: true,
      ),
      body: buildBody(context, offer),
    );
  }

  Widget buildBody(BuildContext context, Offer offer) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          XCircleLogo(logo: offer.picture),
          const SizedBox(
            height: 10.0,
          ),
          XDetailsCard(
            name: 'محتویات بسته:',
            value: offer.content,
          ),
          Banner(
            location: BannerLocation.topEnd,
            color: Colors.red,
            message: 'OFF ${offer.percent}%',
            child: XDetailsCard(
              name: 'قیمت اصلی:',
              value: Utils.numberFormatter(offer.price),
            ),
          ),
          XDetailsCard(
            name: 'قیمت باتخفیف:',
            value: Utils.numberFormatter(offer.currentPrice),
          ),
          XDetailsCard(
            name: 'تاریخ تخفیف:',
            value: offer.date,
          ),
          XDetailsCard(
            name: 'زمان شروع:',
            value: offer.sTime,
          ),
          XDetailsCard(
            name: 'زمان پایان:',
            value: offer.eTime,
          ),
          XDetailsCard(
            name: 'فروشگاه:',
            value: offer.storeName,
          ),
          XDetailsCard(
            name: 'آدرس:',
            value: offer.address,
          ),
          Card(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    double.parse(offer.lat),
                    double.parse(offer.lng),
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
