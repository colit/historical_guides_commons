class GraphQLQueries {
  GraphQLQueries._();

  static const getMaps = r'''
    query getMaps{
      maps {
        edges{
          node {
            objectId,
            name,
            year,
            file
          }
        }
      }
    }
  ''';

  static const getMapReferences = r'''
    query getMapReferences{
      mapReferences {
        edges {
          node {
            objectId,
            key,
            year,
            name,
            mapbox100,
            mapbox50,
            bounds {
              ... on Element {
                value
              }
            }
          }
        }
      }
    }
  ''';

  static const getMapUrlforId = r'''
    query getMapUrlforId($mapId: ID!) {
      map(id: $mapId) {
        url
      }
    }
  ''';

  static const userLogin = r'''
    mutation logIn($username: String!, $password: String!) {
      logIn(input: { username: $username, password: $password }) {
        viewer {
          sessionToken
          user {
            username
            email
          }
        }
      }
    }
  ''';

  static const validateToken = r'''
    query viewer {
      viewer {
        sessionToken
        user {
          username
          email
        }
      }
    }
  ''';

  static const getTours = r'''
  query GetTours {
    tracks {
      edges {
        node {
          id
          objectId
          name
          length
          latitudeNE
          longitudeNE
          latitudeSW
          longitudeSW
          start {
            latitude
            longitude
          }
          geojson {
            url
          }
          vectorAssets {
            url
          }
        }
      }
    }
  }
  ''';

  static const getImageDetails = r'''
    query getImageDetails($id: Float!) {
      images (where: {uuid: {equalTo: $id}}) {
        edges {
          node {
            uuid
            published
            title
            description
            author
            authorURL
            license
            licenseURL
            source
            sourceURL
            image {
              url
            }
          }
        }
      }
    }
  ''';

  static const getTourDetails = r'''
    query getTourDetails($id: ID!) {
      tracks (where: {objectId: {equalTo: $id}}) {
        edges {
          node {
            objectId
            name
            length
            latitudeNE
            longitudeNE
            latitudeSW
            longitudeSW
            geojson {
              name
              url
            }
            vectorAssets {
              url
            }
            start {
              latitude
              longitude
            }
          }
        }
      }
    }
  ''';

  static const createTour = r'''
    mutation CreateTrack(
      $file: Upload!,
      $name: String!,
      $length: Float!,
      $startLat: Float!,
      $startLong: Float!,
      $neLat: Float!,
      $neLong: Float!,
      $swLat: Float!,
      $swLong: Float!,
    ) {
      createTrack(
        input: {
          fields: {
            name: $name
            length: $length
            geojson: { upload: $file }
            start: {
              latitude:$startLat
              longitude:$startLong
            }
            longitudeNE:$neLong
            latitudeNE: $neLat
            longitudeSW: $swLong
            latitudeSW: $swLat
          }
        }
      ) {
        track {
          name
          length
          geojson {
            name
            url
          }
          longitudeNE
          latitudeNE
          longitudeSW
          latitudeSW
          start {
            latitude
            longitude
          }
        }
      }
    }
    ''';

  static const deleteTour = r'''
    mutation DeleteTour($id: ID!) {
      deleteTrack(input: { id: $id }) {
        track {
          id
        }
      }
    }
  ''';
}
