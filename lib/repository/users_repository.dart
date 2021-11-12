import 'package:flutter_mvvm/apiServices/api_helper.dart';
import 'package:flutter_mvvm/model/user_model.dart';

class UsersRepository {

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<User>>getUsers() async {
    final response = await _helper.getUsers();
    return userFromJson(response);
  }

}
