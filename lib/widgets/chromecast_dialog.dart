import 'dart:async';

import 'package:dart_chromecast/casting/cast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mdns_plugin/flutter_mdns_plugin.dart';
import 'package:movie/style/themestyle.dart';
import 'package:observable/observable.dart';
import 'package:video_player/video_player.dart';

import 'service_discovery.dart';

class ChromecastDialog extends StatefulWidget {
  final ServiceDiscovery serviceDiscovery;
  final VideoPlayerController videoController;

  ChromecastDialog({this.videoController, this.serviceDiscovery});
  @override
  _ChromecastDialogState createState() => _ChromecastDialogState();
}

class _ChromecastDialogState extends State<ChromecastDialog> {
  List<CastDevice> _devices = [];
  bool _connected = false;
  CastSender _castSender;
  @override
  void initState() {
    widget.serviceDiscovery.changes.listen((List<ChangeRecord> _) {
      _updateDevices();
    });
    _updateDevices();
    super.initState();
  }

  void _connectToDevice(CastDevice device) async {
    _castSender = CastSender(device);
    _connected = await _castSender.connect();
    if (!_connected) {
      print('Something wrong with chromecast');
      return;
    }
    setState(() {});
    _castSender.launch();
  }

  void _disconnectToDevice() {
    _castSender.castSessionController.close();
    _castSender.stop();
    _castSender.disconnect().then((d) {
      if (d)
        setState(() {
          _connected = false;
        });
    });
  }

  _deviceDidUpdate() {
    setState(() => {});
  }

  CastDevice _deviceByName(String name) {
    return _devices.firstWhere((CastDevice d) => d.name == name,
        orElse: () => null);
  }

  CastDevice _castDeviceFromServiceInfo(ServiceInfo serviceInfo) {
    CastDevice castDevice = CastDevice(
        name: serviceInfo.name,
        type: serviceInfo.type,
        host: serviceInfo.address,
        port: serviceInfo.port);
    return castDevice;
  }

  _updateDevices() {
    _devices =
        widget.serviceDiscovery.foundServices.map((ServiceInfo serviceInfo) {
      CastDevice device = _deviceByName(serviceInfo.name);
      if (null == device) {
        device = _castDeviceFromServiceInfo(serviceInfo);
      }
      return device;
    }).toList();
    _deviceDidUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _Header(),
              _connected
                  ? _ConnectedPanel(
                      castSender: _castSender,
                      onDisconnect: _disconnectToDevice,
                    )
                  : _DeviceList(
                      devices: _devices,
                      onConnect: _connectToDevice,
                    ),
              _ControlsPanel(
                castSender: _castSender,
                controller: widget.videoController,
              ),
            ],
          ),
        ));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(children: [
        Icon(
          Icons.cast,
          color: const Color(0xFFFFFFFF),
        ),
        SizedBox(width: 20),
        Text(
          'Chromecast',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        Spacer(),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.close,
            color: const Color(0xFFFFFFFF),
          ),
        )
      ]),
    );
  }
}

class _DeviceList extends StatelessWidget {
  final List<CastDevice> devices;
  final Function(CastDevice) onConnect;
  const _DeviceList({this.devices, this.onConnect});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: devices.length > 0
          ? ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemCount: devices?.length ?? 0,
              separatorBuilder: (_, index) => SizedBox(height: 20),
              itemBuilder: (_, index) => _DeviceItem(
                device: devices[index],
                onTap: onConnect,
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Color(0xFFFFFFFF),
                ),
              ),
            ),
    );
  }
}

class _DeviceItem extends StatelessWidget {
  final CastDevice device;
  final Function(CastDevice) onTap;
  const _DeviceItem({
    @required this.device,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(device),
      child: Container(
        child: Text(
          device?.name ?? 'no name',
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

class _ConnectedPanel extends StatelessWidget {
  final CastSender castSender;
  final Function onDisconnect;
  const _ConnectedPanel({this.onDisconnect, this.castSender});
  @override
  Widget build(BuildContext context) {
    final Color _baseColor = const Color(0xFFFFFFFF);
    return Container(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            castSender?.device?.name ?? 'no name',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _baseColor,
            ),
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: onDisconnect,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: _baseColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Disconnect',
                style: TextStyle(
                  color: _baseColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ControlsPanel extends StatefulWidget {
  final CastSender castSender;
  final VideoPlayerController controller;
  const _ControlsPanel({this.castSender, this.controller});
  @override
  _ControlsPanelState createState() => _ControlsPanelState();
}

class _ControlsPanelState extends State<_ControlsPanel> {
  CastSender _castSender;
  double duration = 0;
  bool _isPlaying = false;
  Timer _timer;

  @override
  void initState() {
    _castSender = widget.castSender;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_castSender != null &&
          _castSender?.castSession?.isConnected == true) {
        duration = _castSender.castSession.castMediaStatus.position;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _ControlsPanel oldWidget) {
    if (widget.castSender != _castSender) _onConnected();
    super.didUpdateWidget(oldWidget);
  }

  _onConnected() async {
    _castSender = widget.castSender;
    await Future.delayed(Duration(milliseconds: 300), () {
      _castSender?.load(
        CastMedia(
          contentId: widget.controller.dataSource,
          title: 'Video',
          autoPlay: true,
        ),
      );
    });
    _castSender.castMediaStatusController.stream.listen((onData) {
      setState(() {
        _isPlaying = onData.isPlaying;
        duration = onData.position;
      });
    }, onDone: () {
      setState(() {});
    });
    setState(() {});
  }

  _onPlay() {
    if (_castSender == null) return;
    _isPlaying ? _castSender.pause() : _castSender.play();
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  _onForward() {
    if (_castSender == null) return;
    _castSender.seek(_castSender.castSession.castMediaStatus.position + 30.0);
  }

  _onReplay() {
    if (_castSender == null) return;
    _castSender.seek(_castSender.castSession.castMediaStatus.position - 30.0);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: _theme.backgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ControlButton(
                  icon: Icons.replay_30_outlined,
                  onTap: _onReplay,
                ),
                _ControlButton(
                  icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                  onTap: _onPlay,
                ),
                _ControlButton(
                  icon: Icons.forward_30_outlined,
                  onTap: _onForward,
                ),
              ],
            ),
            SizedBox(height: 50),
            Text(duration.toString()),
            /*SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: LinearProgressIndicator(
                value: 0.9,
                valueColor: AlwaysStoppedAnimation(Color(0xFFAAEECC)),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  const _ControlButton({this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 50,
      ),
    );
  }
}
