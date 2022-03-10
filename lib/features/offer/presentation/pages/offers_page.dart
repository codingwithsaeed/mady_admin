// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/features/offer/domain/entities/category_offer.dart';
import 'package:mady_admin/features/offer/presentation/cubit/offer_cubit.dart';
import 'package:mady_admin/features/offer/presentation/pages/add_offer_page.dart';
import 'package:mady_admin/features/offer/presentation/pages/single_offer_page.dart';

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
      if (state.list.isNotEmpty)
        return buildOffersList(context, trimEmptyCategories(state.list));
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

  Widget buildOffersList(BuildContext context, List<CategoryOffer> offers) {
    return ListView.builder(
      itemBuilder: (_, index) => Card(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offers[index].name,
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemBuilder: (_, innerIndex) {
                  return Stack(
                    children: [
                      XCircleLogo(
                        logo: offers[index].data![innerIndex].picture,
                      ),
                      Text(offers[index].data![innerIndex].content)
                    ],
                  );
                },
                itemCount: offers[index].data!.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              ),
            ],
          ),
          onTap: () => Navigator.pushNamed(context, SingleOfferPage.id,
              arguments: offers[index]),
        ),
      ),
      itemCount: offers.length,
      padding: const EdgeInsets.all(5.0),
    );
  }

  Widget buildEmptyBody() => const Center(
      child: Text('هیچ آفری وجود ندارد', style: TextStyle(fontSize: 20.0)));

  List<CategoryOffer> trimEmptyCategories(List<CategoryOffer> list) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].data!.isEmpty) list.removeAt(i);
    }
    return list;
  }
}
