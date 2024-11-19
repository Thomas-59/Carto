import 'package:carto/models/establishment.dart';
import 'package:carto/models/establishment_data.dart';
import 'package:dio/dio.dart';

class EstablishmentService{
 final Dio dio= Dio();

 Future<List<Establishment>> getAllEstablishment() async {
  var response = await dio.get("http://localhost:8080/establishment/all");

  List<dynamic> data = response.data;
  return data.map((json) => Establishment.fromJson(json)).toList();
 }

 void createEstablishment(Establishment establishment) async {
  var response = await dio.post("http://localhost:8080/establishment",data: establishment.toJson());
 }
}