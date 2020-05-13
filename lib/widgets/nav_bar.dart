import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();

  final Function onTap;
  final int initialIndex;

  NavBar({@required this.onTap, this.initialIndex});
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialIndex != null) {
      _selectedIndex = widget.initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Theme.of(context).canvasColor,
      child: ClipPath(
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            // border: Border(
            //   top: BorderSide(),
            // ),
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: NavBartItem(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: _selectedIndex == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    label: Text(
                      'Home',
                      style: TextStyle(fontSize: 12),
                    ),
                    index: 0,
                  ),
                  onTap: () => onTap(0),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: NavBartItem(
                    icon: Icon(
                      Icons.widgets,
                      size: 30,
                      color: _selectedIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    label: Text(
                      'My Products',
                      style: TextStyle(fontSize: 12),
                    ),
                    index: 1,
                  ),
                  onTap: () => onTap(1),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: InkWell(
                  child: NavBartItem(
                    icon: Icon(
                      Icons.library_books,
                      size: 30,
                      color: _selectedIndex == 2
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    label: Text(
                      'Queries',
                      style: TextStyle(fontSize: 12),
                    ),
                    index: 2,
                  ),
                  onTap: () => onTap(2),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: NavBartItem(
                    icon: Icon(
                      Icons.person,
                      size: 30,
                      color: _selectedIndex == 3
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    label: Text(
                      'Profile',
                      style: TextStyle(fontSize: 12),
                    ),
                    index: 3,
                  ),
                  onTap: () => onTap(3),
                ),
              ),
            ],
          ),
        ),
        clipper: NavBarClipper(),
      ),
    );
  }
}

class NavBartItem extends StatelessWidget {
  final Widget icon;
  final Widget label;
  final int index;
  NavBartItem(
      {@required this.icon, @required this.label, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        label,
      ],
    );
  }
}

class NavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.lineTo(4 * sw / 12, 0);
    path.cubicTo(5 * sw / 12, 0, 5 * sw / 12, sh / 2, 6 * sw / 12, sh / 2);
    path.cubicTo(7 * sw / 12, sh / 2, 7 * sw / 12, 0, 8 * sw / 12, 0);
    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
