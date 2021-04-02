import 'package:cloud_firestore/cloud_firestore.dart';

class Campsite {

  String name;
  int distance;
  GeoPoint latlng;
  DocumentReference reference;


  Campsite(this.name,
      {this.distance, this.latlng});

  factory Campsite.fromSnapshot(DocumentSnapshot snapshot) {
    Campsite site = Campsite.fromJson(snapshot.data);
    site.reference = snapshot.reference;
    return site;
  }

  factory Campsite.fromJson(Map<String, dynamic> json) => _campsiteFromJson(json);

  Map<String, dynamic> toJson() => _campsiteToJson(this);
  @override
  String toString() => "Campsite<$name>";
}

Campsite _campsiteFromJson(Map<String, dynamic> json) {
  return Campsite(
      json['name'] as String,
      distance: json["distance"] as int,
      latlng: json['latlng'] as GeoPoint);
}


List<Campsite> _convertCampsites(List campsitesMap) {
  if (campsitesMap == null) {
    return null;
  }
  List<Campsite> campsites = [];
  campsitesMap.forEach((val) {
    campsites.add(Campsite.fromJson(val));
  });
  return campsites;
}

Map<String, dynamic> _campsiteToJson(Campsite instance) => <String, dynamic> {
  'name': instance.name,
  'distance': instance.distance,
  'latlng': instance.latlng
};

List<Map<String, dynamic>> _CampsiteList(List<Campsite> campsites) {
  if (campsites == null) {
    return null;
  }
  List<Map<String, dynamic>> campsiteMap = [];
  campsites.forEach((campsite) {
    campsiteMap.add(campsite.toJson());
  });
  return campsiteMap;
}