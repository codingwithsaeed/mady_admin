// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/seller/domain/entities/seller.dart';
import 'package:mady_admin/features/seller/presentation/cubit/seller_cubit.dart';
import 'package:mady_admin/injection.dart';

import 'single_seller_page.dart';

class SellersPage extends StatefulWidget {
  static const String id = 'SellersPage';
  const SellersPage({Key? key}) : super(key: key);

  @override
  State<SellersPage> createState() => _SellersPageState();
}

class _SellersPageState extends State<SellersPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocProvider<SellerCubit>(
        create: (context) => getIt<SellerCubit>()..getSellers(),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return BlocConsumer<SellerCubit, SellerState>(
      listener: cubitListener,
      builder: cubitBuilder,
    );
  }

  Widget cubitBuilder(context, state) {
    if (state is SellerLoaded) {
      if (state.list.isNotEmpty) return buildSellersList(context, state.list);
      return buildEmptyBody();
    }
    return const Center(child: Text('...'));
  }

  void cubitListener(context, state) {
    if (state is SellerLoading) {
      if (!isLoading) {
        showLoading(context);
        setState(() => isLoading = true);
      }
    } else {
      if (isLoading) {
        Navigator.of(context).pop();
        setState(() => isLoading = false);
      }
      if (state is SellerError) showSnackbar(context, state.message);
    }
  }

  Widget buildSellersList(BuildContext context, List<Seller> sellers) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(sellers[index].logo),
          ),
          title: Text(sellers[index].storeName),
          onTap: () async {
            await Navigator.pushNamed(context, SingleSellerPage.id,
                arguments: sellers[index]);
            BlocProvider.of<SellerCubit>(context).getSellers();
          },
        ),
      ),
      itemCount: sellers.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
    );
  }

  Widget buildEmptyBody() => const Center(
      child: Text('هیچ فروشنده ای وجود ندارد', style: TextStyle(fontSize: 20.0)));
}
