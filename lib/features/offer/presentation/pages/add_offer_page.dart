// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mady_admin/core/utils/show_loading.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/core/utils/utils.dart';
import 'package:mady_admin/core/x/x_widgets.dart';
import 'package:mady_admin/features/offer/domain/entities/add_offer.dart';
import 'package:mady_admin/features/offer/presentation/cubit/offer_cubit.dart';
import 'package:mady_admin/di/injection.dart';
import 'package:mady_admin/utils/consts.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddOfferPage extends StatefulWidget {
  static const id = 'AddOfferPage';
  const AddOfferPage({Key? key}) : super(key: key);

  @override
  State<AddOfferPage> createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  AddOffer offer = AddOffer();
  String date = 'انتخاب تاریخ';
  String sTime = 'زمان شروع';
  String eTime = 'زمان پایان';
    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('افزودن آفر'),
        centerTitle: true,
      ),
      body: BlocProvider<OfferCubit>(
        create: (context) => getIt<OfferCubit>(),
        child: BlocConsumer<OfferCubit, OfferState>(
          listener: cubitListener,
          builder: cubitBuilder,
        ),
      ),
    );
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
      if (state is OfferPictureLoaded) {
      FocusManager.instance.primaryFocus!.unfocus();
      setState(() => offer.picture = state.link);
      showSnackbar(context, message: 'تصویر آپلود شد.', color: Colors.green);
    }
    if (state is OfferError) {
      FocusManager.instance.primaryFocus!.unfocus();
      showSnackbar(context, message: state.message);
    }
    if (state is AddOfferSuccess) Navigator.pop(context, true);
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
                lable: 'شماره موبایل فروشنده',
                onChanged: (data) => setState(() => offer.sellerPhone = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'شماره موبایل را وارد کنید';
                  return null;
                }),
            XLableTextField(
                lable: 'محتویات بسته را وارد کنید',
                onChanged: (data) => setState(() => offer.content = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'محتویات بسته را وارد کنید';
                  return null;
                }),
            XButton(
              onPressed: () async {
                Jalali? picked = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1401, 1),
                  lastDate: Jalali(1401, 12, 29),
                );
                String pickedDate =
                    picked!.formatCompactDate().replaceAll("/", "-");
                setState(() {
                  date = pickedDate;
                  offer.date = pickedDate;
                });
                FocusManager.instance.primaryFocus!.unfocus();
              },
              title: date,
              color: Colors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: XButton(
                    onPressed: () async {
                      var picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      var pickedTime = picked!.persianFormat(context);
                      setState(() {
                        sTime = pickedTime;
                        offer.sTime = pickedTime;
                      });
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    title: sTime,
                    color: Colors.red,
                  ),
                ),
                Expanded(
                  child: XButton(
                    onPressed: () async {
                      var picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      var pickedTime = picked!.persianFormat(context);
                      setState(() {
                        eTime = pickedTime;
                        offer.eTime = pickedTime;
                      });
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    title: eTime,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            XLableTextField(
                lable: 'قیمت اصلی',
                onChanged: (data) => setState(() => offer.price = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'قیمت اصلی را وارد کنید';
                  return null;
                }),
            XLableTextField(
                lable: 'درصد تخفیف',
                onChanged: (data) => setState(() => offer.percent = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'درصد تخفیف را وارد کنید';
                  return null;
                }),
            XLableTextField(
                lable: 'قیمت با تخفیف',
                onChanged: (data) => setState(() => offer.currentPrice = data),
                validator: (text) {
                  if (text == null || text.isEmpty)
                    return 'قیمت با تخفیف را وارد کنید';
                  return null;
                }),
            XLableTextField(
                lable: 'تعداد را وارد کنید',
                onChanged: (data) => setState(() => offer.count = data),
                validator: (text) {
                  if (text == null || text.isEmpty) return 'تعداد را وارد کنید';
                  return null;
                }),
            XButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                final encodedImage = base64Encode(await image!.readAsBytes());
                final fileName = Utils.getRandomString(10);
                BlocProvider.of<OfferCubit>(context)
                    .uploadPicture(name: fileName, image: encodedImage);
              },
              title: 'بارگذاری تصویر',
              color: Colors.red,
            ),
            XDropDown<String>(
              hint: 'انتخاب نوع آفر',
              value: offer.isSpecial,
              items: Consts.offerTypes,
              height: 65,
              onChanged: (value) => setState(() => offer.isSpecial = value),
            ),
            XDropDown<String>(
              hint: 'انتخاب وضعیت',
              value: offer.status,
              items: Consts.offerStatus,
              height: 65,
              onChanged: (value) => setState(() => offer.status = value),
            ),
            XButton(
              onPressed: () {
                offer.validate().fold((message) {
                  showSnackbar(context, message: message);
                }, (isNotNull) {
                  BlocProvider.of<OfferCubit>(context).addOffer(offer);
                });
              },
              title: 'ثبت آفر',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
