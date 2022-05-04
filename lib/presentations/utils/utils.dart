import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  static openEmail({
    required Uri toEmail,
    required String subject,
  }) async {
    final url = Uri.parse('mailto:$toEmail?subject=${Uri.encodeFull(subject)}');
    await _launchUrl(url);
  }

  static Future openLink({required Uri url}) => _launchUrl(url);
}
