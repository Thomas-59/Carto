import 'package:carto/models/establishment.dart';
import 'package:dio/dio.dart';

class EstablishmentService{
 final Dio dio= Dio();

 Future<List<Establishment>> getAllEstablishment() async {
  var response = await dio.get("https://carto.onrender.com/establishment/all");
  List<dynamic> data = response.data;
  return data.map((json) => Establishment.fromJson(json)).toList();
 }

 void createEstablishment(Establishment establishment) async {
  await dio.post("https://carto.onrender.com/establishment",data: establishment.toJson());
  }
}