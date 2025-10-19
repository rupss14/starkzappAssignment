import 'package:flutter/foundation.dart';
import 'package:starkzapp_project/data/models/user_model.dart';
import 'package:starkzapp_project/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;

 
  final Map<String, bool> _likedUsers = {};

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _userRepository.getUsers();
      _users = result;

      
      _likedUsers.removeWhere(
          (key, value) => !_users.any((user) => user.imageUrl == key));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
  void toggleLike(int index) {
    final user = _users[index];
    final key = user.imageUrl;
    _likedUsers[key] = !(_likedUsers[key] ?? false);
    notifyListeners();
  }

  
  bool isLiked(int index) {
    final user = _users[index];
    final key = user.imageUrl;
    return _likedUsers[key] ?? false;
  }
}
