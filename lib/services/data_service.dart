import 'package:firebase/models/receips.dart';
import 'package:firebase/services/login_request.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final Httpservice  _httpservice =  Httpservice();

  factory DataService(){
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipes>?> getRecipes(String filter) async{
    String path = 'recipes/';

    if (filter.isNotEmpty){
      path += 'meal-type/$filter';
    }
    var response = await _httpservice.get(path);

    if(response?.statusCode ==200 && response?.data != null){
      List data = response!.data["recipes"];
      List<Recipes> recipes = data.map((e) => Recipes.fromJson(e)).toList();
      return recipes;
    }
  }
}