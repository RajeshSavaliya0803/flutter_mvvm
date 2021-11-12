
import 'dart:async';
import 'dart:developer' as d;
import 'package:flutter_mvvm/apiServices/api_response.dart';
import 'package:flutter_mvvm/model/user_model.dart';
import 'package:flutter_mvvm/repository/users_repository.dart';

class UsersBloc{

  UsersRepository? _usersRepository;

  StreamController<ApiResponse<List<User>>>? _usersListStreamController;

  StreamSink<ApiResponse<List<User>>> get userListSink =>
      _usersListStreamController!.sink;

  Stream<ApiResponse<List<User>>> get userListStream =>
      _usersListStreamController!.stream;
  
  UsersBloc(){
    _usersListStreamController = StreamController<ApiResponse<List<User>>>();
    _usersRepository = UsersRepository();
    fetchUsers();
  }

  fetchUsers() async{
    userListSink.add(ApiResponse.loading());
    try{
      List<User> users = await _usersRepository!.getUsers();
      userListSink.add(ApiResponse.completed(users));
    }catch (e){
      userListSink.add(ApiResponse.error(e.toString()));
      d.log("Error: $e");
    }
  }

  dispose(){
    _usersListStreamController?.close();
  }

}

