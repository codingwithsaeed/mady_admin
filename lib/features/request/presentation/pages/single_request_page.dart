import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/presentation/cubit/request_cubit.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/core/x/x_widgets.dart';

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
        automaticallyImplyLeading: true,
        title: Text(request.storeName),
        centerTitle: true,
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
              if (state is RequestError)
                showSnackbar(context, message: state.message);
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
          XCircleLogo(logo: request.logo),
          const SizedBox(
            height: 10.0,
          ),
          XDetailsCard(
            name: 'نام فروشگاه:',
            value: request.storeName,
          ),
          XDetailsCard(
            name: 'شماره موبایل:',
            value: request.phone.replaceFirst('+98', '0'),
          ),
          XDetailsCard(
            name: 'دسته بندی:',
            value: request.category,
          ),
          XDetailsCard(
            name: 'آدرس:',
            value: request.address,
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
                markers: {}..add(Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(
                        double.parse(request.lat), double.parse(request.lng)))),
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              XAcceptanceButton(
                color: Colors.red,
                title: 'رد درخواست',
                onPressed: () => BlocProvider.of<RequestCubit>(context)
                    .verifyRequest(request.srid, 'deny_seller'),
              ),
              XAcceptanceButton(
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
