import 'package:rockfarm/model/userResponse.dart';

import 'package:rockfarm/apiProvide/UserApiProvider.dart';

// The repository class will mediate between high level components of our architecture (like bloc-s) and UserApiProvider .
// The UserRepository class will be repository for our random user selected from API.
class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser() {
    return _apiProvider.getUser();
  }
}
