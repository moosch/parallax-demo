import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Parallax Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(body: Parallax()),
      );
}

class Parallax extends StatefulWidget {
  @override
  _ParallaxState createState() => _ParallaxState();
}

class _ParallaxState extends State<Parallax> {
  late PageController _pageController;
  late double _pageOffset;

  @override
  void initState() {
    super.initState();
    _pageOffset = 0;
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(
      () => setState(() => _pageOffset = _pageController.page ?? 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          pageCount: screens.length + 1,
          screenSize: MediaQuery.of(context).size,
          offset: _pageOffset,
        ),
        PageView(
          controller: _pageController,
          children: [
            ...screens
                .map((screen) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.4),
                          child: Text(
                            screen.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.black.withOpacity(0.4),
                          child: Text(
                            screen.body,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class BackgroundImage extends StatelessWidget {
  BackgroundImage({
    Key? key,
    required this.pageCount,
    required this.screenSize,
    required this.offset,
  }) : super(key: key);

  /// Size of page
  final Size screenSize;

  /// Number of pages
  final int pageCount;

  /// Currnet page position
  final double offset;

  @override
  Widget build(BuildContext context) {
    // Image aligment goes from -1 to 1.
    // We convert page number range, 0..6 into the image alignment range -1..1
    int lastPageIdx = pageCount - 1;
    int firstPageIdx = 0;
    int alignmentMax = 1;
    int alignmentMin = -1;
    int pageRange = (lastPageIdx - firstPageIdx) - 1;
    int alignmentRange = (alignmentMax - alignmentMin);
    double alignment = (((offset - firstPageIdx) * alignmentRange) / pageRange) + alignmentMin;

    return Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Image(
        image: AssetImage('assets/tokyo-street-pano.jpg'),
        alignment: Alignment(alignment, 0),
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class Screen {
  const Screen({required this.title, required this.body});
  final String title;
  final String body;
}

const List<Screen> screens = [
  Screen(title: '夜', body: 'Night'),
  Screen(title: '通り', body: 'Street'),
  Screen(title: 'ネオン', body: 'Neon sign'),
  Screen(title: '舗', body: 'Store'),
  Screen(title: '東京', body: 'Tokyo'),
  Screen(title: '夜', body: 'Night'),
  Screen(title: '通り', body: 'Street'),
  Screen(title: 'ネオン', body: 'Neon sign'),
  Screen(title: '舗', body: 'Store'),
  Screen(title: '東京', body: 'Tokyo'),
];
