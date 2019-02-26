import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatorUtil {
  static void pushPage(BuildContext context, Widget page, {String pageName}) {
    if (context == null || page == null || pageName.isEmpty) return;
    Navigator.push(
        context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }

  static void pushWeb(BuildContext context,
      {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || url.isEmpty) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
              builder: (ctx) => WebScaffold(
                title: title,
                titleId: titleId,
                url: url,
              )));
    }
  }

  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
