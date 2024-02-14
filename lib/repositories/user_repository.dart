import 'package:agenda_pastora_app/models/user.dart';
import 'package:agenda_pastora_app/services/api_service.dart';

class UserCreationResult {
  User? user;
  String? errorMessage;

  UserCreationResult({this.user, this.errorMessage});
}

class UserRepoistory {
  final ApiService _apiService = ApiService();

  Future<List<User>> findAll() async {
    try {
      var res = await _apiService.get('users', null);

      if (res['success']) {
        var list = res['results'] as List;
        List<User> responsibles =
            list.map((e) => User.fromJson(e)).toList();

        return responsibles;
      }

      return [];
    } catch (error) {
      return [];
    }
  }

  Future<UserCreationResult> create(User UserData) async {
    try {
      var res = await _apiService.post('users', UserData.toJson(), null);
      print(res['result']);

      if (res['success'] && res['result'] != null) {
        User user = User.fromJson(res['result']);
        print(User);

        return UserCreationResult(user: user);
      } else {
        return UserCreationResult(errorMessage: res['message']);
      }
    } catch (error) {
      print(error);
      return UserCreationResult(errorMessage: error.toString());
    }
  }
}
