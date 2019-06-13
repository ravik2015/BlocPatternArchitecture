import 'package:rockfarm/model/user.dart';

class UserResponse {
  final List<User> results;
  final String error;
  bool loading = true;

  UserResponse(this.results, this.error, this.loading);

  UserResponse.fromJson(Map<String, dynamic> json)
      : results =
            (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
        error = "",
        loading = false;

  UserResponse.withError(String errorValue)
      : results = List(),
        error = errorValue,
        loading = false;
}
