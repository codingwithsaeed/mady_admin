import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/presentation/cubit/request_cubit.dart';
import 'package:mady_admin/injection.dart';

import 'widgets.dart';

class SingleRequestPage extends StatefulWidget {
  static const id = 'SingleRequestPage';
  const SingleRequestPage({Key? key}) : super(key: key);

  @override
  State<SingleRequestPage> createState() => _SingleRequestPageState();
}

class _SingleRequestPageState extends State<SingleRequestPage> {
  bool isLoading = false;

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
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward_sharp),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<RequestCubit>(),
        child: BlocConsumer<RequestCubit, RequestState>(
          listener: (context, state) {
            if (state is RequestLoading) {
              if (!isLoading) {
                showLoading(context);
                setState(() => isLoading = true);
              }
            } else {
              if (isLoading) {
                Navigator.of(context).pop();
                setState(() => isLoading = false);
              }
              if (state is VerifyRequestLoaded) Navigator.pop(context);
              if (state is RequestError) showSnackbar(context, state.message);
            }
          },
          builder: (context, state) {
            return buildBody(context, request);
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, Request request) {
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
            //TODO: StoreName with number must be fixed.
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
                onPressed: () => BlocProvider.of<RequestCubit>(context)
                    .verifyRequest(request.srid, 'deny_seller'),
              ),
              AcceptanceButton(
                color: Colors.green,
                title: 'قبول درخواست',
                onPressed: () => BlocProvider.of<RequestCubit>(context)
                    .verifyRequest(request.srid, 'accept_seller'),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
