import 'package:carto/models/establishment.dart';
import 'package:json_annotation/json_annotation.dart';
part 'establishment_data.g.dart';

/// A class who represent a list of establishments
@JsonSerializable()
class EstablishmentData{
  /// The list of establishments
  final List<Establishment> establishmentList;

  /// The initializer of the class
  EstablishmentData(this.establishmentList);

  /// A factory to get a EstablishmentData from json
  factory EstablishmentData.fromJson(Map<String, dynamic> json) =>
      _$EstablishmentDataFromJson(json);

  /// Parse a List of establishments to json
  Map<String, dynamic> toJson() => _$EstablishmentDataToJson(this);

  /// Give the list of establishments
  List<Establishment> getEstablishments(){
    return establishmentList;
  }
}