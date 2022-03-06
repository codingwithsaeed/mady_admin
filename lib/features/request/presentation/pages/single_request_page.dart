import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/presentation/cubit/request_cubit.dart';

import 'widgets.dart';

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
      body: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          print(state.runtimeType);
        },
        builder: (context, state) {
          return buildBody(request);
        },
      ),
    );
  }

  Widget buildBody(Request request) {
    return SingleChildScrollView(
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
              height: 200,
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
              AcceptanceButton(
                color: Colors.red,
                title: 'رد درخواست',
                onPressed: () {},
              ),
              AcceptanceButton(
                color: Colors.green,
                title: 'قبول درخواست',
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
