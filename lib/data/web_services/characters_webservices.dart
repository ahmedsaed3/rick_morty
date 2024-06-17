
import 'package:dio/dio.dart';

import '../models/characters.dart';

class ApiCharacter {
  var URL = 'https://rickandmortyapi.com/api/character';
  late Dio dio;
  ApiCharacter(){
    BaseOptions Options = BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 5),

    );

    dio = Dio(Options);

  }
  Future<List<dynamic>> GetCharacters ()async {

    try{
      Response response = await dio.get(URL);
      return response.data['results'];
    }
    catch(e){
      print(e.toString());
      return [];
    }
  }

}