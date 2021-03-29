class Campsite {
  String name;
  String distance;
  String latitude;
  String longitude;

  Campsite(this.name, this.distance, this.latitude, this.longitude);

  Campsite.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    distance = json['Distance'];
  }
}