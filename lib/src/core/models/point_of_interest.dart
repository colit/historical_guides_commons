import 'package:latlong2/latlong.dart';

class PointOfInterest {
  PointOfInterest({
    this.id,
    required this.titel,
    this.description,
    required this.position,
    this.removed = false,
  });
  final String? id;
  final LatLng position;
  final String titel;
  final String? description;
  final bool removed;

  PointOfInterest copyWith({
    String? titel,
    String? description,
    LatLng? position,
    bool? removed,
  }) {
    return PointOfInterest(
      id: id,
      titel: titel ?? this.titel,
      description: description ?? this.description,
      position: position ?? this.position,
      removed: removed ?? this.removed,
    );
  }

  factory PointOfInterest.fromGraphQL(Map<String, dynamic> node) {
    return PointOfInterest(
      id: node['objectId'],
      titel: node['title'],
      position: LatLng(
        node['position']['latitude'],
        node['position']['longitude'],
      ),
      description: node['description'],
    );
  }
}
