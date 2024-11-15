import 'package:carto/models/establishment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'establishment_data.g.dart';

@JsonSerializable()
class EstablishmentData{
  final List<Establishment> establishmentList;

  EstablishmentData(this.establishmentList);

  factory EstablishmentData.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$EstablishmentDataToJson(this);

  List<Establishment> getEstablishments(){
    return establishmentList;
  }
}