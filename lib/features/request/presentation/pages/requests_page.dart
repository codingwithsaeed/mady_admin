// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mady_admin/core/utils/show_snackbar.dart';
import 'package:mady_admin/features/request/domain/entities/request.dart';
import 'package:mady_admin/features/request/presentation/cubit/request_cubit.dart';
import 'package:mady_admin/features/request/presentation/pages/single_request_page.dart';
import 'package:mady_admin/di/injection.dart';

class RequestsPage extends StatelessWidget {
  static const String id = 'RequestsPage';
  const RequestsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<RequestCubit>()..getRequests(),
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocConsumer<RequestCubit, RequestState>(
      listener: cubitListener,
      builder: cubitBuilder,
    );
  }

  Widget cubitBuilder(context, state) {
    return RefreshIndicator(
        child: returnBody(context, state),
        onRefresh: () => BlocProvider.of<RequestCubit>(context).getRequests());
  }

  Widget returnBody(BuildContext context, RequestState state) {
    if (state is RequestLoading) return buildLoading();
    if (state is RequestLoaded) {
      if (state.requests.isNotEmpty)
        return buildRequestList(context, state.requests);
      return buildEmptyBody();
    }
    return Center(
        child: TextButton(
      onPressed: () => BlocProvider.of<RequestCubit>(context).getRequests(),
      child: const Text('رفرش'),
    ));
  }

  void cubitListener(context, state) {
    if (state is RequestError) showSnackbar(context, message: state.message);
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
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget buildLoading() => const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );

  Widget buildEmptyBody() => const Center(
      child: Text('هیچ درخواستی وجود ندارد', style: TextStyle(fontSize: 20.0)));
}
