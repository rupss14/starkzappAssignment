import 'package:flutter/foundation.dart';
import 'package:starkzapp_project/data/models/user_model.dart';
import 'package:starkzapp_project/data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository = UserRepository();

  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _error;

  // Map to track liked status by user identifier
  final Map<String, bool> _likedUsers = {};

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Fetch users
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _userRepository.getUsers();
      _users = result;

      // Remove likes for users no longer present
      _likedUsers.removeWhere(
          (key, value) => !_users.any((user) => user.imageUrl == key));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Toggle like
  void toggleLike(int index) {
    final user = _users[index];
    final key = user.imageUrl; // unique identifier
    _likedUsers[key] = !(_likedUsers[key] ?? false);
    notifyListeners();
  }

  /// Check if liked
  bool isLiked(int index) {
    final user = _users[index];
    final key = user.imageUrl;
    return _likedUsers[key] ?? false;
  }
}
