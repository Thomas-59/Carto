import 'package:carto/models/establishment.dart';
import 'package:dio/dio.dart';

/// The service to manage a establishment
class EstablishmentService{
 /// the dio service
 final Dio dio= Dio();

 /// Give all certified establishment in the data base
 Future<List<Establishment>> getAllEstablishment() async {
  var response = await dio.get("https://carto.onrender.com/establishment/all");
  List<dynamic> data = response.data;
  return data.map((json) => Establishment.fromJson(json)).toList();
 }

 /// Add a establishment in the data base
 Future<BigInt> createEstablishment(Establishment establishment) async {
  Response response = await dio.post(
     "https://carto.onrender.com/establishment",
     data: establishment.toJson()
  );
  return BigInt.from(response.data);
 }
}