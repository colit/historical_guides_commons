import 'package:geojson_vi/geojson_vi.dart';
import 'package:historical_guides_commons/src/core/models/station.dart';
import 'package:latlong2/latlong.dart';

class Tour {
  Tour._(
    this.id,
    this.name,
    this.description,
    this.geoJSON,
    this.startPoint,
    this.length,
    this.boundsSW,
    this.boundsNE,
    this.vectorAssets,
    this.stations,
  );
  final String id;
  final String name;
  final String geoJSON;
  final LatLng startPoint;
  final double length;
  final LatLng boundsSW;
  final LatLng boundsNE;
  final String? vectorAssets;
  final String? description;
  final List<Station> stations;

  Map<String, dynamic> get stationsAsGeoJson {
    List<GeoJSONFeature> features = [];
    var index = 0;

    for (final point in stations) {
      if (!point.removed && !point.hidden) {
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
          id: index,
          properties: {
            'uuid': index,
          },
        ));
        index++;
      }
    }
    final featureCollection = GeoJSONFeatureCollection(features);
    return featureCollection.toMap();
  }

  Tour hideStation(String id) {
    final newStations =
        stations.map((s) => s.copyWith(hidden: s.id == id)).toList();
    return copyWith(stations: newStations);
  }

  Tour showAllStations() {
    final newStations = stations.map((s) => s.copyWith(hidden: false)).toList();
    return copyWith(stations: newStations);
  }

  Tour copyWith({
    String? name,
    String? description,
    String? geoJSON,
    String? vectorAssets,
    List<Station>? stations,
  }) {
    return Tour._(
      id,
      name ?? this.name,
      description ?? this.description,
      geoJSON ?? this.geoJSON,
      startPoint,
      length,
      boundsSW,
      boundsNE,
      vectorAssets ?? this.vectorAssets,
      stations ?? this.stations,
    );
  }

  factory Tour.fromMap(Map<dynamic, dynamic> map) {
    return Tour._(
      map['objectId'],
      map['name'],
      map['description'],
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
      'description': description,
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
      node['description'],
      node['geojson']['url'],
      LatLng(
        node['start']['latitude'],
        node['start']['longitude'],
      ),
      node['length'],
      LatLng(node['latitudeSW'], node['longitudeSW']),
      LatLng(node['latitudeNE'], node['longitudeNE']),
      node['vectorAssets']?['url'],
      [for (final point in points) Station.fromGraphQL(point)],
    );
  }
}
