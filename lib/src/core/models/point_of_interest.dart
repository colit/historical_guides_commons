import 'package:latlong2/latlong.dart';

class PointOfInterest {
  PointOfInterest({
    required this.titel,
    this.description,
    required this.position,
  });
  final LatLng position;
  final String titel;
  final String? description;
}
