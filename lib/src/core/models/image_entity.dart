import 'dart:math';

class ImageEntity {
  static const keyObjectId = 'objectId';
  static const keyId = 'uuid';
  static const keyMap = 'map';
  static const keyPublished = 'published';
  static const keyTitle = 'title';
  static const keyDescription = 'description';
  static const keyLatitude = 'latitude';
  static const keyLongitude = 'longitude';
  static const keyAuthor = 'author';
  static const keyAuthorURL = 'authorURL';
  static const keyLicense = 'license';
  static const keyLicenseURL = 'licenseURL';
  static const keySource = 'source';
  static const keySourceURL = 'sourceURL';
  static const keyImage = 'image';
  static const keyPointOfInterest = 'pointOfInterest';

  ImageEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.objectId,
    this.yearPublished = 1900,
    this.title,
    this.description,
    this.author,
    this.authorURL,
    this.license,
    this.licenseURL,
    this.source,
    this.sourceURL,
    this.pointOfInterestId,
    this.imageURL,
    this.imageName,
  });

  final String? objectId;
  final int id;
  final String? imageURL;
  final String? imageName;
  final int? yearPublished;
  final String? title;
  final String? description;
  final double latitude;
  final double longitude;
  final String? author;
  final String? authorURL;
  final String? license;
  final String? licenseURL;
  final String? source;
  final String? sourceURL;
  final String? pointOfInterestId;

  factory ImageEntity.fromMap(Map<String, dynamic> map) => ImageEntity(
        id: map[keyId],
        objectId: map[keyObjectId],
        latitude: map[keyLatitude],
        longitude: map[keyLongitude],
        yearPublished: map[keyPublished],
        title: map[keyTitle],
        description: map[keyDescription],
        author: map[keyAuthor] ?? 'Author unbekannt',
        authorURL: map[keyAuthorURL],
        license: map[keyLicense],
        licenseURL: map[keyLicenseURL],
        source: map[keySource],
        sourceURL: map[keySourceURL],
        pointOfInterestId: map[keyPointOfInterest],
        imageURL: map[keyImage],
      );

  factory ImageEntity.withPosition(double latitude, double longitude) =>
      ImageEntity(
        id: Random().nextInt(pow(2, 31).floor() - 1),
        latitude: latitude,
        longitude: longitude,
      );

  factory ImageEntity.fromQuery(Map<String, dynamic> map) {
    String? imageURL;
    String? imageName;
    if (map.keys.contains('image')) {
      imageURL = map['image']['url'];
      imageName = map['image']['name'];
    }
    return ImageEntity(
      id: map['uuid'],
      objectId: map['objectId'],
      author: map['author'],
      authorURL: map['authorURL'],
      title: map['title'],
      yearPublished: map['published'],
      description: map['description'],
      license: map['license'],
      licenseURL: map['licenseURL'],
      source: map['source'],
      sourceURL: map['sourceURL'],
      imageURL: imageURL,
      imageName: imageName,
      latitude: map['location']['latitude'],
      longitude: map['location']['longitude'],
    );
  }

  ImageEntity copyWith({
    int? id,
    String? objectId,
    double? latitude,
    double? longitude,
    String? author,
    String? authorURL,
    String? title,
    int? yearPublished,
    String? description,
    String? license,
    String? licenseURL,
    String? source,
    String? sourceURL,
    String? imageURL,
    String? imageName,
  }) =>
      ImageEntity(
        id: id ?? this.id,
        objectId: objectId ?? this.objectId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        yearPublished: yearPublished ?? this.yearPublished,
        title: title ?? this.title,
        description: description ?? this.description,
        author: author ?? this.author,
        authorURL: authorURL ?? this.authorURL,
        license: license ?? this.license,
        licenseURL: licenseURL ?? this.licenseURL,
        source: source ?? this.source,
        sourceURL: sourceURL ?? this.sourceURL,
        imageURL: imageURL ?? this.imageURL,
        imageName: imageName ?? this.imageName,
      );
}
