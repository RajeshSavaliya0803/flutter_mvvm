import 'package:flutter/material.dart';
import 'package:flutter_mvvm/apiServices/api_response.dart';
import 'package:flutter_mvvm/apiServices/api_response.dart';
import 'package:flutter_mvvm/bloc/user_bloc.dart';
import 'package:flutter_mvvm/contoller/user_controller.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/widget/loader.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UsersBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = UsersBloc();
  }

  @override
  Widget build(BuildContext context) {
    final UserController controller = Get.put(UserController());
    return Scaffold(
      body: SafeArea(
          // child: StreamBuilder<ApiResponse<List<User>>>(
          //     stream: _bloc.userListStream,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         switch (snapshot.data!.status) {
          //           case Status.loading:
          //             return const Loader();
          //             break;
          //           case Status.completed:
          //             return _buildItems(context, snapshot.data!.data);
          //             break;
          //           case Status.error:
          //             print("Error");
          //             break;
          //         }
          //       }
          //       return Container();
          //     }),
          child: Container(
              alignment: Alignment.center,
              child: controller.obx((users) => _buildItems(context, users),
                  onLoading: const Loader(),
                  onEmpty: const Text("No User Available"),
                  onError: (error) => Text(error!)))),
    );
  }

  _buildItems(BuildContext context, List<User>? users) {
    return ListView.builder(
        itemCount: users!.length,
        itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(
                child: Text(users[index].name![0]),
                backgroundColor: Colors.blue,
              ),
              title: Text('${users[index].name}'),
              subtitle: Text('${users[index].email}'),
            ));
  }
}
