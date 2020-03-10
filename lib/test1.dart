import 'package:legends/test.dart';
import 'package:console/console.dart';

var messageByteStream = Stream.empty();
void main() {
  messageByteStream = Console.adapter.byteStream().asBroadcastStream();
  xmppManager();
}
