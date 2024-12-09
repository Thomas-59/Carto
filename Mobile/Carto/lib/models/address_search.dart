import 'package:json_annotation/json_annotation.dart';

import 'address.dart';
part 'address_search.g.dart';

@JsonSerializable()
class AddressSearch {
  @JsonKey(name:"type")
  final String type;
  @JsonKey(name:"version")
  final String version;
  @JsonKey(name:"features")
  final List<Address> addressList;
  @JsonKey(name:"attribution")
  final String attribution;
  @JsonKey(name:"licence")
  final String licence;
  @JsonKey(name:"query")
  final String query;
  @JsonKey(name:"limit")
  final int limit;

  AddressSearch(this.type, this.version, this.addressList, this.attribution,
      this.licence, this.query, this.limit);

  factory AddressSearch.fromJson(Map<String, dynamic> json) =>
      _$AddressSearchFromJson(json);

  Map<String, dynamic> toJson() => _$AddressSearchToJson(this);
}