import 'package:firebase/services/login_request.dart';
import 'package:firebase/models/user.dart';

class AuthService{
  static final AuthService _singleton = AuthService.initialValue();

  User? user; 
  final _httpservice = Httpservice();
  factory AuthService(){
    return _singleton;
  }

  AuthService.initialValue();



  Future<bool> login(String username,String password) async{

    try{
      var response = await _httpservice.post("auth/login", {
        "username": username,
        "password": password
      });
      if (response?.statusCode ==200 && response?.data !=null){
        user = User.fromJson(response!.data);
        Httpservice().setup(bearerToken: user!.token);
        return true;
      }

    }catch(e){
      print(e);
    }
    return false;
    
  }
}