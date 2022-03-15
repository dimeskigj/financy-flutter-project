import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../services/location_service.dart';
import 'map.dart';

class MapWrapper extends StatelessWidget {
  final LatLng latLng;

  const MapWrapper({Key? key, required this.latLng}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
        child: Column(
          children: [
            DetailsMap(
              latLng: latLng,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FutureBuilder<String>(
                  future: LocationService.reverseGeocode(latLng),
                  builder: (BuildContext ctx, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data ?? '',
                        style: TextStyle(fontFamily: 'Roboto', color: Theme.of(context).colorScheme.onBackground),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error loading location...',
                          style: TextStyle(fontFamily: 'Roboto', color: Theme.of(context).colorScheme.primary));
                    } else {
                      return Text('Loading location...',
                          style: TextStyle(fontFamily: 'Roboto', color: Theme.of(context).colorScheme.onBackground));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
