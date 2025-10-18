import 'package:starkzapp_project/data/models/user_model.dart';
import 'package:starkzapp_project/data/services/api_service.dart';

class UserRepository {
  final ApiService api_service = ApiService();

  Future<List<UserModel>> getUsers() {
    return api_service.fetchUsers();
  }
}
