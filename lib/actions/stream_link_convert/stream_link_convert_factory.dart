import 'package:movie/actions/stream_link_convert/archive.dart';
import 'package:movie/actions/stream_link_convert/bitporno.dart';
import 'package:movie/actions/stream_link_convert/clipwatching.dart';
import 'package:movie/actions/stream_link_convert/gamovideo.dart';
import 'package:movie/actions/stream_link_convert/gounlimited.dart';
import 'package:movie/actions/stream_link_convert/ninjastream.dart';
import 'package:movie/actions/stream_link_convert/powvideo.dart';
import 'package:movie/actions/stream_link_convert/prostream.dart';
import 'package:movie/actions/stream_link_convert/streamplay.dart';
import 'package:movie/actions/stream_link_convert/upstream.dart';
import 'package:movie/actions/stream_link_convert/vidtodo.dart';
import 'package:movie/actions/stream_link_convert/waaw.dart';

import 'cloudvideo.dart';
import 'dood.dart';
import 'fembed.dart';
import 'jawcloud.dart';
import 'jetload.dart';
import 'mixdrop.dart';
import 'mp4upload.dart';
import 'openlay.dart';
import 'streamtape.dart';
import 'supervideo.dart';
import 'uptostream.dart';
import 'uqload.dart';
import 'veoh.dart';
import 'vidcloud.dart';
import 'videobin.dart';
import 'videomega.dart';
import 'vidfast.dart';
import 'vidia.dart';
import 'vidlox.dart';
import 'vidoza.dart';
import 'vup.dart';

class StreamLinkConvertFactory {
  StreamLinkConvertFactory._();
  static final StreamLinkConvertFactory instance = StreamLinkConvertFactory._();
  List<String> hosts = [
    'archive',
    'bitporno',
    'clipwatching',
    'cloudvideo',
    'dood',
    'feurl',
    'fembed',
    'gamovideo',
    'gounlimited',
    'jawcloud',
    'jetload',
    'mediafire',
    'mixdrop',
    'mp4upload',
    "ninjastream",
    'openlay',
    'powvideo',
    'prostream',
    'streamplay',
    'streamtape',
    'supervideo',
    'upstream',
    'uptostream',
    'uqload',
    'veoh',
    'vidcloud',
    'videobin',
    'videomega',
    'vidfast',
    'vidia',
    'vidlox',
    'vidoza',
    'vidtodo',
    'vup',
    'waaw'
  ];
  Future<String> getLink(String link) async {
    final String _domain = _getDomain(link);
    String _link;
    switch (_domain) {
      case 'archive':
        _link = await Archive.getUrl(link);
        break;
      case 'bitporno':
        _link = await Bitporno.getUrl(link);
        break;
      case 'clipwatching':
        _link = await Clipwatching.getUrl(link);
        break;
      case 'cloudvideo':
        _link = await CloudVideo.getUrl(link);
        break;
      case 'dood':
        _link = await Dood.getUrl(link);
        break;
      case 'feurl':
      case 'fembed':
        _link = await Fembed.getUrl(link);
        break;
      case 'gamovideo':
        _link = await GamoVideo.getUrl(link);
        break;
      case 'gounlimited':
        _link = await Gounlimited.getUrl(link);
        break;
      case 'jawcloud':
        _link = await Jawcloud.getUrl(link);
        break;
      case 'jetload':
        _link = await Jetload.getUrl(link);
        break;
      case 'mixdrop':
        _link = await Mixdrop.getUrl(link);
        break;
      case 'mp4upload':
        _link = await Mp4upload.getUrl(link);
        break;
      case 'ninjastream':
        _link = await NinjaStream.getUrl(link);
        break;
      case 'openlay':
        _link = await Openlay.getUrl(link);
        break;
      case 'prostream':
        _link = await Prostream.getUrl(link);
        break;
      case 'powvideo':
        _link = await PowVideo.getUrl(link);
        break;
      case 'streamplay':
        _link = await StreamPlay.getUrl(link);
        break;
      case 'streamtape':
        _link = await Streamtape.getUrl(link);
        break;
      case 'supervideo':
        _link = await Supervideo.getUrl(link);
        break;
      case 'upstream':
        _link = await Upstream.getUrl(link);
        break;
      case 'uptostream':
        _link = await Uptostream.getUrl(link);
        break;
      case 'uqload':
        _link = await Uqload.getUrl(link);
        break;
      case 'veoh':
        _link = await Veoh.getUrl(link);
        break;
      case 'vidcloud':
        _link = await Vidcloud.getUrl(link);
        break;
      case 'videobin':
        _link = await Videobin.getUrl(link);
        break;
      case 'videomega':
        _link = await Videomega.getUrl(link);
        break;
      case 'vidfast':
        _link = await Vidfast.getUrl(link);
        break;
      case 'vidia':
        _link = await Vidia.getUrl(link);
        break;
      case 'vidlox':
        _link = await Vidlox.getUrl(link);
        break;
      case 'vidoza':
        _link = await Vidoza.getUrl(link);
        break;
      case 'vidtodo':
        _link = await Vidtodo.getUrl(link);
        break;
      case 'vup':
        _link = await Vup.getUrl(link);
        break;
      case 'waaw':
        _link = await Waaw.getUrl(link);
        break;
    }
    return _link;
  }

  String _getDomain(String link) {
    for (var e in hosts) if (link.contains(e)) return e;
    return '';
  }
}
