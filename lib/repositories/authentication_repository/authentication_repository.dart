



import 'package:link_refurb/models/auth_model/authentication_model.dart';

import 'authentication_provider.dart';

class AuthenticationRepository{
  final AuthenticationProvider provider;

  AuthenticationRepository({required this.provider});

  Future<AuthenticationModel> login({required String password, required String email})async{
    var data =await provider.login(password: password, email: email);
    return authenticationModelFromJson(data);
  }

  Future logout()async{
    await provider.logout();
  }

  Future<AuthenticationModel> register({required String name,required String password, required String email})async{
    var data =await provider.register(password: password, email: email, name: name);
    return authenticationModelFromJson(data);
  }
  
}