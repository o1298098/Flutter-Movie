import 'package:dart_chromecast/casting/cast_device.dart';
import 'package:dart_chromecast/casting/cast_media.dart';
import 'package:dart_chromecast/casting/cast_sender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/service_discovery.dart';
import 'package:observable/observable.dart';
import 'package:video_player/video_player.dart';

class DevicePicker extends StatefulWidget {
  final ServiceDiscovery serviceDiscovery;
  final VideoPlayerController videoController;

  DevicePicker({this.serviceDiscovery, this.videoController});

  @override
  _DevicePickerState createState() => _DevicePickerState();
}

class _DevicePickerState extends State<DevicePicker> {
  List<CastDevice> _devices = [];

  bool connected = false;
  bool _isPlaying = false;
  CastSender _castSender;
  @override
  void initState() {
    super.initState();
    widget.serviceDiscovery.changes.listen((List<ChangeRecord> _) {
      _updateDevices();
    });
    _updateDevices();
  }

  @override
  void dispose() {
    if (!(_castSender?.connectionDidClose ?? true)) _castSender.disconnect();
    super.dispose();
  }

  void _connectToDevice(CastDevice device) async {
    _castSender = CastSender(device);
    connected = await _castSender.connect();
    if (!connected) {
      // show error message...
      return;
    }
    setState(() {});
    //if you want to connect to your custom app, send AppID as a parameter i.e. _castSender.launch("appId")
    _castSender.launch();
  }

  _updateDevices() {
    setState(() {
      _devices =
          widget.serviceDiscovery.foundServices.map((ServiceInfo serviceInfo) {
        return CastDevice(
            name: serviceInfo.name,
            type: serviceInfo.type,
            host: serviceInfo.hostName,
            port: serviceInfo.port);
      }).toList();
    });
  }

  Widget _buildListViewItem(CastDevice castDevice) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(castDevice.friendlyName),
          onTap: () async {
            _connectToDevice(castDevice);
            connected = true;
            setState(() {});
            await Future.delayed(Duration(milliseconds: 300), () {
              _castSender?.load(CastMedia(
                  contentId: widget.videoController.dataSource,
                  title: 'Test video',
                  autoPlay: true));
            });
            _castSender.castMediaStatusController.stream.listen((onData) {
              setState(() {
                _isPlaying = onData.isPlaying;
              });
            }, onDone: () {
              setState(() {
                connected = false;
              });
            });
          },
        ),
        Divider(
          height: 0.0,
        )
      ],
    );
  }

  Widget _buildControlButton(IconData icon, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Adapt.px(100),
        height: Adapt.px(50),
        child: Icon(icon),
      ),
    );
  }

  Widget _buildControlPanel() {
    return Column(children: <Widget>[
      SizedBox(height: Adapt.px(20)),
      Text(
        'Test Video',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: Adapt.px(30)),
      ),
      Container(
        height: Adapt.px(250),
        margin: EdgeInsets.all(Adapt.px(20)),
        color: Colors.grey,
      ),
      Padding(
          padding: EdgeInsets.symmetric(vertical: Adapt.px(40)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildControlButton(_isPlaying ? Icons.pause : Icons.play_arrow,
                  () => _isPlaying ? _castSender.pause() : _castSender.play()),
              _buildControlButton(Icons.pause, () => _castSender.pause()),
              _buildControlButton(
                  Icons.fast_rewind,
                  () => _castSender.seek(
                      _castSender.castSession.castMediaStatus.position - 10.0)),
              _buildControlButton(
                  Icons.fast_forward,
                  () => _castSender.seek(
                      _castSender.castSession.castMediaStatus.position + 10.0)),
            ],
          )),
      Expanded(child: SizedBox()),
      Divider(
        height: 0.0,
      ),
      InkWell(
        onTap: () {
          _castSender.castSessionController.close();
          _castSender.stop();
          _castSender.disconnect().then((d) {
            if (d)
              setState(() {
                connected = false;
              });
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Adapt.px(30)),
          child: Text(
            'Disconnect',
            style:
                TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      child: Container(
        height: Adapt.screenH() / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: Adapt.px(20)),
            Icon(
              Icons.cast,
              size: Adapt.px(60),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pick a casting device',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              height: 0.0,
              color: Colors.black,
            ),
            Expanded(
                child: _devices.length != 0
                    ? !connected
                        ? MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView(
                              key: Key('devices-list'),
                              children:
                                  _devices.map(_buildListViewItem).toList(),
                            ))
                        : _buildControlPanel()
                    : Center(
                        child: Container(
                            child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.black),
                      ))))
          ],
        ),
      ),
    );
  }
}
