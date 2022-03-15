// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/presentation/cubit/seller_cubit.dart';
import 'package:mady_admin/features/seller/presentation/pages/add_seller_page.dart';
import 'package:mady_admin/di/injection.dart';

import 'single_seller_page.dart';

class SellersPage extends StatelessWidget {
  static const String id = 'SellersPage';
  const SellersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SellerCubit>(
      create: (context) => getIt<SellerCubit>(),
      child: const SellersPageImpl(),
    );
  }
}

class SellersPageImpl extends StatefulWidget {
  const SellersPageImpl({Key? key}) : super(key: key);

  @override
  State<SellersPageImpl> createState() => _SellersPageImplState();
}

class _SellersPageImplState extends State<SellersPageImpl>
    with AutomaticKeepAliveClientMixin {
  Future<void> refreshData() =>
      BlocProvider.of<SellerCubit>(context).getSellers();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => refreshData(),
        child: BlocConsumer<SellerCubit, SellerState>(
          listener: cubitListener,
          builder: cubitBuilder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: (() async {
          dynamic isAdded =
              await Navigator.pushNamed(context, AddSellerPage.id);
          if (isAdded != null && isAdded as bool) refreshData();
        }),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cubitBuilder(context, state) {
    if (state is SellerLoading) return buildLoading();
    if (state is SellerLoaded) {
      if (state.list.isNotEmpty) return buildSellersList(context, state.list);
      return buildEmptyBody();
    }
    return Center(
        child: TextButton(
      onPressed: () async => refreshData(),
      child: const Text('رفرش'),
    ));
  }

  Widget buildLoading() => const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );

  void cubitListener(context, state) {
    if (state is SellerError) showSnackbar(context, message: state.message);
  }

  Widget buildSellersList(BuildContext context, List<Seller> sellers) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(sellers[index].logo),
          ),
          title: Row(
            children: [
              Text(
                sellers[index].storeName,
                textDirection: TextDirection.ltr,
              ),
              const Expanded(child: Text('')),
            ],
          ),
          onTap: () => Navigator.pushNamed(context, SingleSellerPage.id,
              arguments: sellers[index]),
        ),
      ),
      itemCount: sellers.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget buildEmptyBody() => const Center(
      child:
          Text('هیچ فروشنده ای وجود ندارد', style: TextStyle(fontSize: 20.0)));
}
