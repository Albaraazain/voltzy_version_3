import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models/location.dart';
import '../../features/jobs/models/job.dart';

/// Converts GeoPoint to/from JSON
class GeoPointConverter
    implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(
      json['latitude'] as double,
      json['longitude'] as double,
    );
  }

  @override
  Map<String, dynamic> toJson(GeoPoint geoPoint) {
    return {
      'latitude': geoPoint.latitude,
      'longitude': geoPoint.longitude,
    };
  }
}

class LocationConverter
    implements JsonConverter<Location, Map<String, dynamic>> {
  const LocationConverter();

  @override
  Location fromJson(Map<String, dynamic> json) {
    if (json['geopoint'] is GeoPoint) {
      final geoPoint = json['geopoint'] as GeoPoint;
      return Location(
        address: json['address'] as String? ?? '',
        latitude: geoPoint.latitude,
        longitude: geoPoint.longitude,
        city: json['city'] as String?,
        state: json['state'] as String?,
        zipCode: json['zipCode'] as String?,
      );
    }
    return Location.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Location location) {
    final json = location.toJson();
    json['geopoint'] = GeoPoint(location.latitude, location.longitude);
    return json;
  }
}

class JobConverter implements JsonConverter<Job, Map<String, dynamic>> {
  const JobConverter();

  @override
  Job fromJson(Map<String, dynamic> json) => Job.fromJson(json);

  @override
  Map<String, dynamic> toJson(Job job) => job.toJson();
}
