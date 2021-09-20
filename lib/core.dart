import 'package:flutter/material.dart';

class Core extends StatefulWidget {
  Core({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CoreState createState() => _CoreState();
}

class _CoreState extends State<Core> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (int index) {
          setState(
            () {
              _selectedPageIndex = index;
            },
          );
        },
        children: [
          Container(
            key: Key('timerPage'),
            color: Colors.green,
            child: Center(
              child: Text('Timer'),
            ),
          ),
          Container(
            key: Key('stopwatchPage'),
            color: Colors.blue,
          ),
          Container(
            key: Key('settingsPage'),
            color: Colors.red,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: Key('bottomNavigationBar'),
        currentIndex: _selectedPageIndex,
        onTap: (int index) {
          _selectedPageIndex = index;
          _controller.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timer,
              semanticLabel: 'Timer',
            ),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timelapse_rounded,
              semanticLabel: 'Stopwatch',
            ),
            label: 'Stopwatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              semanticLabel: 'Settings',
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
