import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  /// This  [_controller] will manage everything inside our WebView:
  /// loading URLs, executing JavaScript, refreshing pages, etc.
  ///
  late final WebViewController _controller;
  late final scrollPosition;
  String _currentWebPageTitle = 'Loading...';

  @override
  void initState() async {
    _controller = WebViewController()
      // Enables JavaScript in your web pages. By default, JavaScript is turned off for security reasons.
      // JavaScriptMode.unrestricted → allows JavaScript execution (commonly needed for modern websites)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // sets background color of the webview
      ..setBackgroundColor(const Color(0x00000000))
      // NavigationDelegate allows you to listen to events during webpage loading —
      // like when the page starts loading, finishes loading, progress updates, or if there’s an error.
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Loading progress : $progress');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading : $url');
            setState(() {
              _currentWebPageTitle = 'Loading...';
            });
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading : $url');
            String? jsTitle =
                await _controller.runJavaScriptReturningResult("document.title")
                    as String?;
            if (mounted) {
              setState(() {
                _currentWebPageTitle = (jsTitle != null && jsTitle.isNotEmpty)
                    ? jsTitle
                    : 'Title Not Found';
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
            if (mounted) {
              setState(() {
                _currentWebPageTitle = 'Error loading page';
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..setOnConsoleMessage((consoleMessage) {
        debugPrint('Console : ${consoleMessage.message}');
      })
      ..setUserAgent('MyCustomUserAgent/1.0')
      ..setOnScrollPositionChange((ScrollPositionChange change) {
        if (mounted) {
          setState(() {
            scrollPosition = 'X : ${change.x}, Y : ${change.y}';
          });
        }
      })
      ..loadRequest(Uri.parse('https://flutter.dev'));
    super.initState();
    await _controller.setVerticalScrollBarEnabled(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        centerTitle: true,
        title: Text(
          'Webview',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _controller.reload();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              bool canGoBack = await _controller.canGoBack();
              if (canGoBack) {
                _controller.goBack();
              } else {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () async {
              bool canGoForward = await _controller.canGoForward();
              if (canGoForward) _controller.goForward();
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
        leading: Row(children: []),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        onPressed: () async {
          await _controller.scrollBy(0, 0);
          await _controller.scrollTo(0, 0);

          // _controller
          //   ..scrollTo(0, 0)
          //   ..scrollBy(0, 0)
          //   ..setVerticalScrollBarEnabled(true);
        },
        child: Icon(Icons.arrow_circle_up, size: 25, color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade50,
                    Colors.blue.shade100,
                    Colors.blue.shade200,
                    Colors.blue.shade300,
                    Colors.blue.shade400,
                    Colors.blue.shade500,
                    Colors.blue.shade400,
                    Colors.blue.shade300,
                    Colors.blue.shade200,
                    Colors.blue.shade100,
                    Colors.blue.shade50,
                  ],
                ),
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: WebViewWidget(controller: _controller),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Current Page Title : $_currentWebPageTitle',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _controller.runJavaScript(
                            "document.body.style.backgroundColor = 'lightblue';",
                          );
                        },
                        label: Text('Change Background'),
                        icon: Icon(Icons.color_lens),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          String? url = await _controller.currentUrl();
                          debugPrint('Currently loaded URL : $url');
                        },
                        label: Text('Get Title'),
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          // This Clears Cache Data
                          await _controller.clearLocalStorage();
                        },
                        label: Text('Clear Storage'),
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await _controller.loadHtmlString("""
                                  <html>
                                    <body style="background-color:#f8f8f8;">
                                      <h2>Hello from HTML String!</h2>
                                      <button onclick="FlutterChannel.postMessage('Hi Flutter!')">Send to Flutter</button>
                                    </body>
                                  </html>
                               """);
                        },
                        label: Text('Load HTML'),
                        icon: Icon(Icons.refresh),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
