import 'package:latlong2/latlong.dart';

class Station {
  Station({
    required this.id,
    required this.titel,
    this.description,
    required this.position,
    this.removed = false,
    this.hidden = false,
  });
  final String id;
  final LatLng position;
  final String titel;
  final String? description;
  final bool removed;
  final bool hidden;

  Station copyWith({
    String? titel,
    String? description,
    LatLng? position,
    bool? removed,
    bool? hidden,
  }) {
    return Station(
      id: id,
      titel: titel ?? this.titel,
      description: description ?? this.description,
      position: position ?? this.position,
      removed: removed ?? this.removed,
      hidden: hidden ?? this.hidden,
    );
  }

  static Station get empty {
    return Station(
      id: '',
      titel: '',
      position: LatLng(0, 0),
    );
  }

  factory Station.fromGraphQL(Map<String, dynamic> node) {
    return Station(
      id: node['objectId'],
      titel: node['title'],
      description: node['description'],
      position: LatLng(
        node['position']['latitude'],
        node['position']['longitude'],
      ),
    );
  }
}
