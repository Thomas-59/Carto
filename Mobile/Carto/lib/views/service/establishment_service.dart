import 'package:carto/models/establishment.dart';
import 'package:carto/models/establishment_data.dart';
import 'package:dio/dio.dart';

class EstablishmentService{
 final Dio dio= Dio();

 Future<List<Establishment>> getAllEstablishment() async {
  var response = await dio.get("http://127.0.0.1:8080/establishment/all");

  // Convertir la liste JSON en une liste d'objets `Establishment`
  List<dynamic> data = response.data; // Assurez-vous que `response.data` est bien une liste
  return data.map((json) => Establishment.fromJson(json)).toList();
 }
}