/// FileName echo_popup_menu
///
/// @Author LinGuanYu
/// @Date 2023/3/18 17:03
///
/// @Description TODO

import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';


const double _kMenuScreenPadding = 8.0;

class WPopupMenu extends StatefulWidget {
  WPopupMenu({
    Key? key,
    required this.onValueChanged,
    required this.actions,
    required this.child,
    this.pressType = PressType.longPress,
    this.pageMaxChildCount = 5,
    this.backgroundColor = Colors.black,
    this.menuWidth = 250,
    this.menuHeight = 42,
    this.alignment,
    this.padding,
    Color? color,
    Decoration? decoration,
    this.foregroundDecoration,
    double? width,
    double? height,
    BoxConstraints? constraints,
    this.margin,
    this.transform,
  })  : assert(actions.isNotEmpty),
        assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(decoration == null || decoration.debugAssertIsValid()),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(
        color == null || decoration == null,
        'Cannot provide both a color and a decoration\n'
            'The color argument is just a shorthand for "decoration: new BoxDecoration(color: color)".'),
        decoration =
            decoration ?? (color != null ? BoxDecoration(color: color) : null),
        constraints = (width != null || height != null)
            ? constraints?.tighten(width: width, height: height) ??
            BoxConstraints.tightFor(width: width, height: height)
            : constraints,
        super(key: key);

  final BoxConstraints? constraints;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final EdgeInsets? padding;
  final Decoration? foregroundDecoration;
  final EdgeInsets? margin;
  final Matrix4? transform;
  final ValueChanged<int> onValueChanged;
  final List<String> actions;
  final Widget child;
  final PressType pressType; // 点击方式 长按 还是单击
  final int pageMaxChildCount;
  final Color backgroundColor;
  final double menuWidth;
  final double menuHeight;


  @override
  State<WPopupMenu> createState() => _WPopupMenuState();
}

class _WPopupMenuState extends State<WPopupMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        key: widget.key,
        padding: widget.padding,
        margin: widget.margin,
        decoration: widget.decoration,
        constraints: widget.constraints,
        transform: widget.transform,
        alignment: widget.alignment,
        child: widget.child,
      ),
      onTap: () {
        if (widget.pressType == PressType.singleClick) {
          echoLog("单机");
          onTap();
        }
      },
      onLongPress: () {
        if (widget.pressType == PressType.longPress) {
          echoLog("双击");
          onTap();
        }
      },
    );
  }

  void onTap() {
    Navigator.push(
        context,
        _PopupMenuRoute(
            context,
            widget.actions,
            widget.pageMaxChildCount,
            widget.backgroundColor,
            widget.menuWidth,
            widget.menuHeight,
            widget.padding,
            widget.margin))
        .then((index) {
      widget.onValueChanged(index);
    });
  }
}

enum PressType {
  // 长按
  longPress,
  // 单击
  singleClick,
}

class _PopupMenuRoute extends PopupRoute {
  final BuildContext btnContext;
  late double _height;
  late double _width;
  final List<String> actions;
  final int _pageMaxChildCount;
  final Color backgroundColor;
  final double menuWidth;
  final double menuHeight;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  _PopupMenuRoute(
      this.btnContext,
      this.actions,
      this._pageMaxChildCount,
      this.backgroundColor,
      this.menuWidth,
      this.menuHeight,
      this.padding,
      this.margin) {
    _height = btnContext.size?.height??0 -
        (padding == null
            ? margin == null ? 0 : margin?.vertical??0
            : padding?.vertical??0);
    _width = btnContext.size?.width??0 -
        (padding == null
            ? margin == null ? 0 : margin?.horizontal??0
            : padding?.horizontal??0);
  }

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, 2.0 / 3.0),
    );
  }

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _MenuPopWidget(
        btnContext,
        _height,
        _width,
        actions,
        _pageMaxChildCount,
        backgroundColor,
        menuWidth,
        menuHeight,
        padding,
        margin);
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}

class _MenuPopWidget extends StatefulWidget {
  final BuildContext btnContext;
  final double _height;
  final double _width;
  final List<String> actions;
  final int _pageMaxChildCount;
  final Color backgroundColor;
  final double menuWidth;
  final double menuHeight;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const _MenuPopWidget(
      this.btnContext,
      this._height,
      this._width,
      this.actions,
      this._pageMaxChildCount,
      this.backgroundColor,
      this.menuWidth,
      this.menuHeight,
      this.padding,
      this.margin,
      );

  @override
  __MenuPopWidgetState createState() => __MenuPopWidgetState();
}

class __MenuPopWidgetState extends State<_MenuPopWidget> {
  int _curPage = 0;
  final double _arrowWidth = 40;
  final double _separatorWidth = 1;
  final double _triangleHeight = 10;

  late RenderBox button;
  late RenderBox overlay;
  late RelativeRect position;

  @override
  void initState() {
    super.initState();
    button = widget.btnContext.findRenderObject() as RenderBox;
    overlay = Overlay.of(widget.btnContext).context.findRenderObject() as RenderBox;
    position = RelativeRect.fromRect(
      Rect.fromPoints(

        button.localToGlobal(
            Offset(
                widget.padding == null
                    ? widget.margin == null ? 0 : widget.margin?.left??0
                    : widget.padding?.left??0,
                widget.padding == null
                    ? widget.margin == null ? 0 : widget.margin?.top??0
                    : widget.padding?.top??0),
            ancestor: overlay),
        button.localToGlobal(
            Offset(
                widget.padding == null
                    ? widget.margin == null ? 0 :  widget.margin?.left??0
                    :  widget.padding?.left??0,
                widget.padding == null
                    ? widget.margin == null ? 0 :  widget.margin?.top??0
                    : widget.padding?.top??0),
            ancestor: overlay),
      ),
      Offset.zero & (overlay.size),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 这里计算出来 当前页的 child 一共有多少个
    int curPageChildCount =
    (_curPage + 1) * widget._pageMaxChildCount > widget.actions.length
        ? widget.actions.length % widget._pageMaxChildCount
        : widget._pageMaxChildCount;

    double curArrowWidth = 0;
    int curArrowCount = 0; // 一共几个箭头

    if (widget.actions.length > widget._pageMaxChildCount) {
      // 数据长度大于 widget._pageMaxChildCount
      if (_curPage == 0) {
        // 如果是第一页
        curArrowWidth = _arrowWidth;
        curArrowCount = 1;
      } else {
        // 如果不是第一页 则需要也显示左箭头
        curArrowWidth = _arrowWidth * 2;
        curArrowCount = 2;
      }
    }

    double curPageWidth = widget.menuWidth +
        (curPageChildCount - 1 + curArrowCount) * _separatorWidth +
        curArrowWidth;

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      child: Builder(
        builder: (BuildContext context) {
          var isInverted = (position.top +
              (MediaQuery.of(context).size.height -
                  position.top -
                  position.bottom) /
                  2.0 -
              (widget.menuHeight + _triangleHeight)) <
              (widget.menuHeight + _triangleHeight) * 2;
          return CustomSingleChildLayout(
            // 这里计算偏移量
            delegate: _PopupMenuRouteLayout(
                position,
                widget.menuHeight + _triangleHeight,
                Directionality.of(widget.btnContext),
                widget._width,
                widget.menuWidth,
                widget._height),
            child: SizedBox(
              height: widget.menuHeight + _triangleHeight,
              width: curPageWidth,
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    isInverted
                        ? CustomPaint(
                      size: Size(curPageWidth, _triangleHeight),
                      painter: TrianglePainter(
                        color: widget.backgroundColor,
                        position: position,
                        isInverted: true,
                        size: button.size,
                        screenWidth: MediaQuery.of(context).size.width,
                      ),
                    )
                        : Container(),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              color: widget.backgroundColor,
                              height: widget.menuHeight,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              // 左箭头：判断是否是第一页，如果是第一页则不显示
                              _curPage == 0
                                  ? Container(
                                height: widget.menuHeight,
                              )
                                  : InkWell(
                                onTap: () {
                                  setState(() {
                                    _curPage--;
                                  });
                                },
                                child: SizedBox(
                                  width: _arrowWidth,
                                  height: widget.menuHeight,
                                  child: Image.asset(
                                    'images/left_white.png',
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                              // 左箭头：判断是否是第一页，如果是第一页则不显示
                              _curPage == 0
                                  ? Container(
                                height: widget.menuHeight,
                              )
                                  : Container(
                                width: 1,
                                height: widget.menuHeight,
                                color: Colors.grey,
                              ),

                              // 中间是ListView
                              _buildList(curPageChildCount, curPageWidth,
                                  curArrowWidth, curArrowCount),

                              // 右箭头：判断是否有箭头，如果有就显示，没有就不显示
                              curArrowCount > 0
                                  ? Container(
                                width: 1,
                                color: Colors.grey,
                                height: widget.menuHeight,
                              )
                                  : Container(
                                height: widget.menuHeight,
                              ),
                              curArrowCount > 0
                                  ? InkWell(
                                onTap: () {
                                  if ((_curPage + 1) *
                                      widget._pageMaxChildCount <
                                      widget.actions.length) {
                                    setState(() {
                                      _curPage++;
                                    });
                                  }
                                },
                                child: SizedBox(
                                  width: _arrowWidth,
                                  height: widget.menuHeight,
                                  child: Image.asset(
                                    (_curPage + 1) *
                                        widget
                                            ._pageMaxChildCount >=
                                        widget.actions.length
                                        ? 'images/right_gray.png'
                                        : 'images/right_white.png',
                                    fit: BoxFit.none,
                                  ),
                                ),
                              )
                                  : Container(
                                height: widget.menuHeight,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    isInverted
                        ? Container()
                        : CustomPaint(
                      size: Size(curPageWidth, _triangleHeight),
                      painter: TrianglePainter(
                        color: widget.backgroundColor,
                        position: position,
                        size: button.size,
                        screenWidth: MediaQuery.of(context).size.width,),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildList(int curPageChildCount, double curPageWidth,
      double curArrowWidth, int curArrowCount) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: curPageChildCount,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.pop(
                context, _curPage * widget._pageMaxChildCount + index);
          },
          child: SizedBox(
            width: (curPageWidth -
                curArrowWidth -
                (curPageChildCount - 1 + curArrowCount) *
                    _separatorWidth) /
                curPageChildCount,
            height: widget.menuHeight,
            child: Center(
              child: Text(
                widget.actions[_curPage * widget._pageMaxChildCount + index],
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          width: 1,
          height: widget.menuHeight,
          color: Colors.grey,
        );
      },
    );
  }
}

// Positioning of the menu on the screen.
class _PopupMenuRouteLayout extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayout(this.position, this.selectedItemOffset,
      this.textDirection, this.width, this.menuWidth, this.height);

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // The distance from the top of the menu to the middle of selected item.
  //
  // This will be null if there's no item to position in this way.
  final double? selectedItemOffset;

  // Whether to prefer going to the left or to the right.
  final TextDirection textDirection;

  final double width;
  final double height;
  final double menuWidth;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    Size s = constraints.biggest -
        const Offset(_kMenuScreenPadding * 2.0, _kMenuScreenPadding * 2.0) as Size;
    return BoxConstraints.loose(s);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y;
    if (selectedItemOffset == null) {
      y = position.top;
    } else {
      y = position.top +
          (size.height - position.top - position.bottom) / 2.0 -
          (selectedItemOffset??0);
    }

    // Find the ideal horizontal position.
    double x;

    // 如果menu 的宽度 小于 child 的宽度，则直接把menu 放在 child 中间
    if (childSize.width < width) {
      x = position.left + (width - childSize.width) / 2;
    } else {
      // 如果靠右
      if (position.left > size.width - (position.left + width)) {
        if (size.width - (position.left + width) > childSize.width / 2 + _kMenuScreenPadding) {
          x = position.left - (childSize.width - width) / 2;
        } else {
          x = position.left + width - childSize.width;
        }
      } else if (position.left < size.width - (position.left + width)) {
        if (position.left > childSize.width / 2 + _kMenuScreenPadding) {
          x = position.left - (childSize.width - width) / 2;
        } else {
          x = position.left;
        }
      } else {
        x = position.right - width / 2 - childSize.width / 2;
      }
    }

    if (y < _kMenuScreenPadding) {
      y = _kMenuScreenPadding;
    } else if (y + childSize.height > size.height - _kMenuScreenPadding) {
      y = size.height - childSize.height;
    } else if (y < childSize.height * 2) {
      y = position.top + height;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupMenuRouteLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}



class TrianglePainter extends CustomPainter {
  late Paint _paint;
  final Color color;
  final RelativeRect position;
  final Size size;
  final double radius;
  final bool isInverted;
  final double? screenWidth;

  TrianglePainter(
      {required this.color,
        required this.position,
        required this.size,
        this.radius = 20,
        this.isInverted = false,
        this.screenWidth}) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color
      ..strokeWidth = 10
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width - this.size.width + this.size.width / 1.5,
        isInverted ? 0 : size.height);
    path.lineTo(
        size.width - this.size.width + this.size.width / 1.5 - radius / 3,
        isInverted ? size.height : 0);
    path.lineTo(
        size.width - this.size.width + this.size.width / 1.5 + radius / 3,
        isInverted ? size.height : 0);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}