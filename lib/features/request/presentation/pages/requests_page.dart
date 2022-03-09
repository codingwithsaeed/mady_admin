// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/presentation/cubit/request_cubit.dart';
import 'package:mady_admin/features/request/presentation/pages/single_request_page.dart';
import 'package:mady_admin/injection.dart';

class RequestsPage extends StatefulWidget {
  static const String id = 'RequestsPage';
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<RequestCubit>()..getRequests(),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: cubitListener,
      builder: cubitBuilder,
    );
  }

  Widget cubitBuilder(context, state) {
    if (state is RequestLoaded) {
      if (state.requests.isNotEmpty)
        return buildRequestList(context, state.requests);
      return buildEmptyBody();
    }
    return const Center(child: Text('...'));
  }

  void cubitListener(context, state) {
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
      if (state is RequestError) showSnackbar(context, message:  state.message);
    }
  }

  Widget buildRequestList(BuildContext context, List<Request> requests) {
    return ListView.builder(
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(requests[index].logo),
          ),
          title: Text(requests[index].storeName),
          onTap: () async {
            await Navigator.pushNamed(context, SingleRequestPage.id,
                arguments: requests[index]);
            BlocProvider.of<RequestCubit>(context).getRequests();
          },
        ),
      ),
      itemCount: requests.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(5.0),
    );
  }

  Widget buildEmptyBody() => const Center(
      child: Text('هیچ درخواستی وجود ندارد', style: TextStyle(fontSize: 20.0)));

  Future<dynamic> showLoading(BuildContext context) => showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.red.withOpacity(0.1),
          insetPadding: const EdgeInsets.all(0.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SpinKitThreeBounce(
              color: Colors.red.shade900,
              size: 50.0,
            ),
          ),
        ),
      );
}
