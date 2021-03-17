/*import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:observable/observable.dart';

class ServiceDiscovery extends ChangeNotifier {
  FlutterMdnsPlugin _flutterMdnsPlugin;
  List<ServiceInfo> foundServices = [];

  ServiceDiscovery() {
    _flutterMdnsPlugin = FlutterMdnsPlugin(
        discoveryCallbacks: DiscoveryCallbacks(
            onDiscoveryStarted: () => {},
            onDiscoveryStopped: () => {},
            onDiscovered: (ServiceInfo serviceInfo) => {},
            onResolved: (ServiceInfo serviceInfo) {
              print('found device ${serviceInfo.toString()}');
              if (null != serviceInfo.attr && null != serviceInfo.attr['fn']) {
                Uint8List l = Uint8List.fromList(serviceInfo.attr['fn']);
                serviceInfo.name = utf8.decode(l);
              }
              foundServices.add(serviceInfo);
              notifyChange();
            }));
  }

  startDiscovery() {
    _flutterMdnsPlugin.startDiscovery('_googlecast._tcp');
  }
}*/
