import 'dart:async';
import 'package:rockfarm/model/userResponse.dart';
import 'package:rockfarm/repository/UserRepository.dart';
import 'package:rxdart/rxdart.dart';

// UserBloc is the only component which can be used from UI class (in terms of clean architecture).
// UserBloc fetches data from repository and publish it via rx subjects.
class UserBloc {
  final UserRepository _repository = UserRepository();

  // BehaviorSubject is subject which returns last emitted value when new observer joins.
  // This can be helpful when our widget will change his state.
  // The observer will be our widget which will show user data.
  final BehaviorSubject<UserResponse> _subject =
      BehaviorSubject<UserResponse>();

  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  getUser() async {
    _setIsLoading(true);
    _subject.sink.add(null);
    UserResponse response = await _repository.getUser();
    // getUser method gets data from repository and publish them in _subject
    _subject.sink.add(response);
    _setIsLoading(false);
  }

  // dispose method should be called, when UserBloc will be no longer used.
  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;
}

final bloc = UserBloc();
