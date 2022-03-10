// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/core/utils/utils.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/features/seller/domain/entities/add_seller.dart';
import 'package:mady_admin/features/seller/domain/entities/shop_categories.dart';
import 'package:mady_admin/features/seller/presentation/cubit/seller_cubit.dart';
import 'package:mady_admin/features/seller/presentation/pages/select_address_page.dart';
import 'package:mady_admin/di/injection.dart';

class AddSellerPage extends StatefulWidget {
  static const id = 'AddSellerPage';
  const AddSellerPage({Key? key}) : super(key: key);

  @override
  State<AddSellerPage> createState() => _AddSellerPageState();
}

class _AddSellerPageState extends State<AddSellerPage> {
  AddSeller seller = AddSeller();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('افزودن فروشنده'),
        centerTitle: true,
      ),
      body: BlocProvider<SellerCubit>(
        create: (context) => getIt<SellerCubit>(),
        child: BlocConsumer<SellerCubit, SellerState>(
          listener: cubitListener,
          builder: cubitBuilder,
        ),
      ),
    );
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
      if (state is SellerLogoLoaded) {
        FocusManager.instance.primaryFocus!.unfocus();
        setState(() => seller.logo = state.link);
        showSnackbar(context, message: 'لوگو آپلود شد.', color: Colors.green);
      }
      if (state is SellerError) {
        FocusManager.instance.primaryFocus!.unfocus();
        showSnackbar(context, message: state.message);
      }
      if (state is SellerInserted) Navigator.pop(context, true);
    }
  }

  Widget cubitBuilder(context, state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            XLableTextField(
              lable: 'نام فروشگاه',
              onChanged: (data) => setState(() => seller.storeName = data),
              validator: (text) {
                if (text == null || text.isEmpty)
                  return 'نام فروشگاه را وارد کنید';
                return null;
              },
            ),
            XLableTextField(
                lable: 'شماره موبایل',
                onChanged: (data) => setState(() => seller.phone = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'شماره موبایل را وارد کنید';
                  return null;
                }),
            XDropDown<String>(
              hint: 'انتخاب دسته بندی',
              value: seller.category,
              items: Consts.categories,
              height: 65,
              onChanged: (value) => setState(() => seller.category = value),
            ),
            XLableTextField(
                lable: 'آدرس',
                isMultiline: true,
                onChanged: (data) => setState(() => seller.address = data),
                validator: (text) {
                  if (text == null || text.isEmpty) return 'آدرس را وارد کنید';
                  return null;
                }),
            XButton(
              onPressed: () async {
                try {
                  LatLng? pos =
                      await Navigator.pushNamed(context, SellectAddressPage.id)
                          as LatLng?;
                  FocusManager.instance.primaryFocus!.unfocus();

                  setState(() {
                    seller.lat = pos!.latitude.toString();
                    seller.lng = pos.longitude.toString();
                  });
                } on Exception catch (e) {
                  showSnackbar(context, message: e.toString());
                }
              },
              title: 'انتخاب آدرس روی نقشه',
              color: Colors.red,
            ),
            XButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                final encodedImage = base64Encode(await image!.readAsBytes());
                final fileName = Utils.getRandomString(6);
                BlocProvider.of<SellerCubit>(context)
                    .uploadLogo(name: fileName, image: encodedImage);
              },
              title: 'بارگذاری لوگو',
              color: Colors.red,
            ),
            XDropDown<String>(
              hint: 'انتخاب بسته',
              value: seller.pocket,
              items: Consts.pockets,
              height: 65,
              onChanged: (value) => setState(() => seller.pocket = value),
            ),
            XButton(
              onPressed: () {
                seller.validate().fold((message) {
                  showSnackbar(context, message: message);
                }, (isNotNull) {
                  print(isNotNull);
                  BlocProvider.of<SellerCubit>(context)
                      .insertSeller(params: seller);
                });
              },
              title: 'ثبت فروشنده',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
