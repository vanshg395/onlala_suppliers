import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();

  final Function onTap;

  NavBar({@required this.onTap});
}

class _NavBarState extends State<NavBar> {
  void onTap(int index) {
    widget.onTap(index);
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
                    icon: Image.asset('assets/icons/home.png'),
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
                    icon: Image.asset('assets/icons/myproduct.png'),
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
                    icon: Image.asset('assets/icons/message.png'),
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
                    icon: Image.asset('assets/icons/profile.png'),
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
        SizedBox(
          height: 5,
        ),
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
