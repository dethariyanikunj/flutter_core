import 'package:url_launcher/url_launcher.dart';

class AppUrlUtils {
  Future openDialPad(String phoneNumber) async {
    Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
