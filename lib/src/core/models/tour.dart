import 'package:historical_guides_commons/src/core/models/point_of_interest.dart';
import 'package:latlong2/latlong.dart';

class Tour {
  Tour._(
    this.id,
    this.name,
    this.geoJSON,
    this.startPoint,
    this.length,
    this.boundsSW,
    this.boundsNE,
    this.vectorAssets,
    this.pointsOfInterest,
  );
  final String id;
  final String name;
  final String geoJSON;
  final LatLng startPoint;
  final double length;
  final LatLng boundsSW;
  final LatLng boundsNE;
  final String? vectorAssets;
  final List<PointOfInterest> pointsOfInterest;

  Tour copyWith({
    String? name,
    String? geoJSON,
    String? vectorAssets,
    List<PointOfInterest>? pointsOfInterest,
  }) {
    return Tour._(
      id,
      name ?? this.name,
      geoJSON ?? this.geoJSON,
      startPoint,
      length,
      boundsSW,
      boundsNE,
      vectorAssets ?? this.vectorAssets,
      pointsOfInterest ?? this.pointsOfInterest,
    );
  }

  factory Tour.fromMap(Map<dynamic, dynamic> map) {
    return Tour._(
      map['objectId'],
      map['name'],
      map['geoJSON'],
      map['start'],
      map['length'],
      map['bounds']['southwest'],
      map['bounds']['northeast'],
      map['vectorAssets'],
      map['pointsOfInterest'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'objectId': id,
      'name': name,
      'geoJSON': geoJSON,
      'length': length,
      'start': startPoint,
      'bounds': {
        'southwest': boundsSW,
        'northeast': boundsNE,
      }
    };
  }

  factory Tour.fromGraphQL(dynamic node) {
    return Tour._(
      node['objectId'],
      node['name'],
      node['geojson']['url'],
      LatLng(
        node['start']['latitude'],
        node['start']['longitude'],
      ),
      node['length'],
      LatLng(node['latitudeSW'], node['longitudeSW']),
      LatLng(node['latitudeNE'], node['longitudeNE']),
      node['vectorAssets']['url'],
      node['pointsOfInterest'] ?? [],
    );
  }
}
