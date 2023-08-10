import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_click_doctor/services/api.dart';
import 'package:rxdart/rxdart.dart';

import '../../../widgets/alerts.dart';
import 'login_events.dart';
import 'login_state.dart';

class LoginBloc {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  final storage = FlutterSecureStorage();

  final ApiService _apiService = ApiService();

  // Streams to expose data
  Stream<String> get usernameStream => _usernameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<LoginState> get stateStream => _stateController.stream;

  // Constructor
  LoginBloc() {
    _stateController.add(InitialLoginState());

    // _usernameController.stream.listen((username) {
    //   // Perform validation logic if needed
    // });

    // _passwordController.stream.listen((password) {
    //   // Perform validation logic if needed
    // });
  }

  // Handle events
  void handleEvent(LoginEvent event) {
    if (event is UsernameChangedEvent) {
      _usernameController.add(event.username);
    } else if (event is PasswordChangedEvent) {
      _passwordController.add(event.password);
    } else if (event is SubmitLoginEvent) {
      _performLogin();
    }
  }

  Future<void> _performLogin() async {
    _stateController.add(LoadingLoginState());

    final username = _usernameController.value;
    final password = _passwordController.value;

    try {
      final response = await _apiService.login(username, password);

      if (response['code'] == 200) {
        var token = response['token'];
        var id = response['id'];
        var userId = response['userId'];
        var photo = response['profilePhoto'];
        var doctortype = response['doctortype'];
        var usern = username;
        var pass = password;

        storage.write(key: 'token', value: token);
        storage.write(key: 'id', value: id.toString());
        storage.write(key: 'userId', value: userId.toString());
        storage.write(key: 'profilePhoto', value: photo.toString());
        storage.write(key: 'username', value: usern.toString());
        storage.write(key: 'password', value: pass.toString());
        storage.write(key: 'dtype', value: doctortype);

        return _stateController.add(
            SuccessLoginState()); //Navigator.pushNamed(context, RoutePaths.myTabBar);
      } else {
        throw Exception(
            'Error in login'); //invalidUserNamePasswordAlert(context);
      }
    } catch (error) {
      _stateController.add(ErrorLoginState(error.toString()));
    }
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _stateController.close();
    _apiService.dispose();
  }
}
