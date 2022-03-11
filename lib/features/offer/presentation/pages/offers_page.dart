// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/features/offer/domain/entities/offer.dart';
import 'package:mady_admin/features/offer/presentation/cubit/offer_cubit.dart';
import 'package:mady_admin/features/offer/presentation/pages/add_offer_page.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfferCubit>(
      create: (context) => getIt<OfferCubit>(),
      child: const OffersPageImpl(),
    );
  }
}

class OffersPageImpl extends StatefulWidget {
  const OffersPageImpl({Key? key}) : super(key: key);

  @override
  State<OffersPageImpl> createState() => _OffersPageImplState();
}

class _OffersPageImplState extends State<OffersPageImpl>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  Future<void> refreshData() =>
      BlocProvider.of<OfferCubit>(context).getAllOffers();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => refreshData(),
        child: BlocConsumer<OfferCubit, OfferState>(
          listener: cubitListener,
          builder: cubitBuilder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final bool? isAdded =
              await Navigator.pushNamed(context, AddOfferPage.id) as bool;
          if (isAdded!) refreshData();
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cubitBuilder(context, state) {
    if (state is OfferLoaded) {
      if (state.list.isNotEmpty) return buildOffersList(context, state.list);
      return buildEmptyBody();
    }
    return Center(
        child: TextButton(
      onPressed: () async => refreshData(),
      child: const Text('رفرش'),
    ));
  }

  void cubitListener(context, state) {
    if (state is OfferLoading) {
      if (!isLoading) {
        showLoading(context);
        setState(() => isLoading = true);
      }
    } else {
      if (isLoading) {
        Navigator.of(context).pop();
        setState(() => isLoading = false);
      }
      if (state is OfferError) showSnackbar(context, message: state.message);
    }
  }

  Widget buildOffersList(BuildContext context, List<Offer> offers) {
    return GridView.builder(
      itemCount: offers.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              XCircleLogo(
                logo: offers[index].picture,
                radius: 60,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(offers[index].content)
            ],
          ),
        );
      },
    );
  }

  Widget buildEmptyBody() => const Center(
      child: Text('هیچ آفری وجود ندارد', style: TextStyle(fontSize: 20.0)));
}
