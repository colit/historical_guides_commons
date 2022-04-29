import 'package:geojson_vi/geojson_vi.dart';
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

  Map<String, dynamic> get poisAsGeoJson {
    List<GeoJSONFeature> features = [];
    var index = 0;

    for (final point in pointsOfInterest) {
      if (!point.removed) {
        final map = {
          'type': 'Point',
          'coordinates': [
            point.position.longitude,
            point.position.latitude,
          ]
        };
        final geometry = GeoJSONGeometry.fromMap(map);
        features.add(GeoJSONFeature(
          geometry,
          properties: {
            'uuid': index++,
          },
        ));
      }
    }
    final featureCollection = GeoJSONFeatureCollection(features);
    return featureCollection.toMap();
  }

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
    final points = List<Map<String, dynamic>>.from(node['stations'] ?? []);
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
      node['pointsOfInterest'] ??
          [for (final point in points) PointOfInterest.fromGraphQL(point)],
    );
  }
}
