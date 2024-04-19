import 'package:flutter/material.dart';
import 'package:morkam/widget/drawer.dart';
import 'package:morkam/widget/feedback.dart' as feedback;
import 'package:morkam/widget/more_apps.dart';
import 'package:morkam/widget/rate_us.dart';
import 'package:share_plus/share_plus.dart';

class SpeedTestDrawer extends MorkamDrawer {
  const SpeedTestDrawer({
    super.key,
  }) : super(titleText: 'QR Scanner');

  @override
  List<Widget> buildItems(BuildContext context) => [
        const MoreApps(),
        const RateUs(),
        ListTile(
          leading: const Icon(
            Icons.share,
            color: Colors.white,
          ),
          title: const Text(
            'Share',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          onTap: () async {
            Navigator.pop(context);
            Share.share('https://play.google.com/store/apps/details?id=com.morkam.scanner.qr');
          },
        ),
        const feedback.Feedback(),
      ];
}
