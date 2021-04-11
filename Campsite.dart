import 'package:cloud_firestore/cloud_firestore.dart';

class Campsite {
  //Global variables
  String name;
  int distance;
  String gravelSize;
  String gravelQuantity;
  String suspension;
  String treadDepth;
  bool permit;
  bool spare;
  GeoPoint latlng;

  //Document Reference
  DocumentReference reference;

  //Constructor with invoked variables as parameters
  Campsite(this.name,
      {this.distance,
      this.gravelSize,
      this.gravelQuantity,
      this.suspension,
      this.treadDepth,
      this.permit,
      this.spare,
      this.latlng});

  //Factory to generate Campsites from Document Snapshot
  factory Campsite.fromSnapshot(DocumentSnapshot snapshot) {
    //Call Constructor Campsite to store all data from Json
    Campsite site = Campsite.fromJson(snapshot.data);

    //Populate site with snapshot data
    site.reference = snapshot.reference;

    //return site
    return site;
  }

  //Call Factory
  factory Campsite.fromJson(Map<String, dynamic> json) =>
      _campsiteFromJson(json);

  //Map keys to values
  Map<String, dynamic> toJson() => _campsiteToJson(this);

  //? ?? ? ??? ? ??
  @override
  String toString() => "Campsite<$name>";
}

//Create _campsitesFromJson Method
//Pass map and return Firestore data as declared
Campsite _campsiteFromJson(Map<String, dynamic> json) {
  return Campsite(json['name'] as String,
      distance: json['distance'] as int,
      latlng: json['latlng'] as GeoPoint,
      gravelQuantity: json['gravelQuantity'] as String,
      gravelSize: json['gravelSize'] as String,
      suspension: json['suspension'] as String,
      treadDepth: json['treadDepth'] as String,
      permit: json['permit'] as bool,
      spare: json['spare'] as bool);
}

//method _campsiteToJson
Map<String, dynamic> _campsiteToJson(Campsite instance) => <String, dynamic>{
      'name': instance.name,
      'distance': instance.distance,
      'latlng': instance.latlng,
      'gravelSize': instance.gravelSize,
      'gravelQuantity': instance.gravelQuantity,
      'suspension': instance.suspension,
      'treadDepth': instance.treadDepth,
      'permit': instance.permit,
      'spare': instance.spare,
    };
