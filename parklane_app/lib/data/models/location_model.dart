// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  LocationModel({
    required this.id,
    required this.address,
    required this.name,
    required this.totalCapacity,
    required this.locationCode,
  });

  final int id;
  final Address address;
  final String name;
  final int totalCapacity;
  final LocationCode locationCode;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        address: Address.fromJson(json["address"]),
        name: json["name"],
        totalCapacity: json["totalCapacity"],
        locationCode: LocationCode.fromJson(json["locationCode"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address.toJson(),
        "name": name,
        "totalCapacity": totalCapacity,
        "locationCode": locationCode.toJson(),
      };

  LocationModel copyWith({
    int? id,
    Address? address,
    String? name,
    int? totalCapacity,
    LocationCode? locationCode,
  }) {
    return LocationModel(
      id: id ?? this.id,
      address: address ?? this.address,
      name: name ?? this.name,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      locationCode: locationCode ?? this.locationCode,
    );
  }
}

class Address {
  Address({
    required this.pincode,
    required this.city,
  });

  final int pincode;
  final String city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        pincode: json["pincode"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "pincode": pincode,
        "city": city,
      };

  Address copyWith({
    int? pincode,
    String? city,
  }) {
    return Address(
      pincode: pincode ?? this.pincode,
      city: city ?? this.city,
    );
  }
}

class LocationCode {
  LocationCode({
    required this.lat,
    required this.long,
  });

  final double lat;
  final double long;

  factory LocationCode.fromJson(Map<String, dynamic> json) => LocationCode(
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };

  LocationCode copyWith({
    double? lat,
    double? long,
  }) {
    return LocationCode(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }
}
