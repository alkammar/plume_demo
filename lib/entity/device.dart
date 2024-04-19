import 'dart:typed_data';
import 'dart:ui';

sealed class Device {}

class Idle extends Device {}

class Scanning extends Device {}

class Scanned extends Device {
  final Uri uri;
  final Uint8List image;
  final List<Offset> corners;

  Scanned(
    this.uri,
    this.image,
    this.corners,
  );
}
