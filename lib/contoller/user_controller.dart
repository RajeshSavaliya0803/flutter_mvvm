
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/users_repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController with StateMixin<List<User>>{

  UsersRepository? _usersRepository;

  @override
  void onInit() {
    super.onInit();
    _usersRepository = UsersRepository();

  }


  @override
  void onReady() {
    super.onReady();
    fetchUsers();
  }

  fetchUsers() async{
    try{
      change(null,status: RxStatus.loading());
      List<User> users = await _usersRepository!.getUsers();
      // userListSink.add(ApiResponse.completed(users));
      if(users.isEmpty){
        change([],status: RxStatus.empty());
      }else{
        change(users,status: RxStatus.success());
      }
    }catch (e){
      // userListSink.add(ApiResponse.error(e.toString()));
      change(null,status: RxStatus.error(e.toString()));
    }
  }
}