import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class MapPage extends StatefulWidget {
  MapPage({
    Key key,
    @required this.lat,
    @required this.lng,
    @required this.mapController,
    @required this.markers,
    this.isNominatim = true,
    this.apiKey,
    this.customMapLayer,
  }) : super(key: key);
  final List<Marker> markers;
  final double lat;
  final double lng;
  final MapController mapController;
  final bool isNominatim;
  final String apiKey;
  final TileLayerOptions customMapLayer;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Widget body(BuildContext context) {
    return new FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
          center: LatLng(widget.lat, widget.lng), zoom: 13, maxZoom: 18),
      layers: [
        widget.isNominatim
            ? widget.customMapLayer == null
                ? new TileLayerOptions(
                    urlTemplate:
                        'https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    tileProvider: NonCachingNetworkTileProvider())
                : widget.customMapLayer
            : widget.customMapLayer == null
                // ? new TileLayerOptions(
                //     urlTemplate: "https://api.tiles.mapbox.com/v4/"
                //         "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                //     additionalOptions: {
                //       'accessToken': widget.apiKey,
                //       'id': 'mapbox.streets',
                //     },
                //   )
            ? new TileLayerOptions(
          urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
          additionalOptions: {
            'attribution' :'© <a href="https://www.mapbox.com/about/maps/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> <strong><a href="https://www.mapbox.com/map-feedback/" target="_blank">Improve this map</a></strong>',
            'accessToken': widget.apiKey,
            'id': 'mapbox/streets-v11',
          },
        )
                : widget.customMapLayer,
        MarkerLayerOptions(
          markers: widget.markers,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: body(context),
    );
  }
}
