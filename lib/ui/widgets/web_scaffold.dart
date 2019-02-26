import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_app/utils/navigator_utils.dart';

class WebScaffold extends StatefulWidget {
  const WebScaffold({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new WebScaffoldState();
  }
}

class WebScaffoldState extends State<WebScaffold> {

  void _onPopSelected(String value) {
    switch (value) {
      case "browser":
        NavigatorUtil.launchInBrowser(widget.url, title: widget.title);
        break;
      case "collection":
        break;

      case "share":
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            padding: const EdgeInsets.all(0.0),
            onSelected: _onPopSelected,
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    value: "browser",
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0.0),
                      dense: false,
                      title: Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.language,
                              color: Color(0xFF666666),
                              size: 22.0,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '浏览器打开',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF666666),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                      value: "share",
                      child: ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          dense: false,
                          title: new Container(
                            alignment: Alignment.center,
                            child: new Row(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  color: Color(0xFF666666),
                                  size: 22.0,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '分享',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF666666),
                                  ),
                                )
                              ],
                            ),
                          ))),
                ],
          )
        ],
      ),
    );
  }
}
