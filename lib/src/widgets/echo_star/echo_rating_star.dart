import 'package:flutter/material.dart';

import 'enum_star.dart';

/// FileName echo_rating_star
///
/// @Author LinGuanYu
/// @Date 2023/8/23 09:41
///
/// @Description

class EchoRatingStar extends StatefulWidget {
  /// 星星类型
  final EchoStarType echoStarType;

  /// 正常颜色
  final Color normalColor;

  /// 星星高亮颜色
  final Color highLightColor;

  /// 总共有多少星星
  final int totalStarNum;

  /// 水平方向星星之间的间隔
  final double horizontalSpace;

  /// 选择星星的回调
  final Function(num star)? selectCallback;

  /// 星星的大小
  final double starSize;

  /// 初始化选中的星星个数
  final int initSelectStarNum;
  const EchoRatingStar(
      {super.key,
      this.echoStarType = EchoStarType.completeStar,
      this.highLightColor = Colors.yellow,
      this.normalColor = Colors.grey,
      this.totalStarNum = 5,
      this.horizontalSpace = 8,
      this.selectCallback,
      this.starSize = 30,
      this.initSelectStarNum = 0});

  @override
  State<EchoRatingStar> createState() => _EchoRatingStarState();
}

class _EchoRatingStarState extends State<EchoRatingStar> {
  /// 宽度之和
  late double _containerWidth;

  /// 记录手指在屏幕上的位置
  late Offset _touchPosition;

  /// 当前手指在评分组件上滑动的位置 0-1
  double clipWidth = 0;

  @override
  void initState() {
    ///所有星星的宽度和间隔之和
    _containerWidth = widget.totalStarNum * widget.starSize +
        widget.horizontalSpace * (widget.totalStarNum - 1);

    ///默认选中的位置计算
    double initWidth = 0;
    if (widget.initSelectStarNum > 1) {
      initWidth = widget.starSize * widget.initSelectStarNum +
          widget.horizontalSpace * (widget.initSelectStarNum - 1);
    }
    print("总共宽度$_containerWidth");
    print("initWidth:$initWidth");
    _touchPosition = Offset(initWidth, 0);
    super.initState();
    //Widget渲染完成后的回调
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ///计算宽度饼刷新页面
      setState(() {
        clipWidth = calculateClipWidth();
        print("clip:$clipWidth");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildGes();
  }

  Row buildStarWidget(Color color) {
    List<Widget> list = [];
    for (int i = 0; i < widget.totalStarNum; i++) {
      double rightSpace = widget.horizontalSpace;

      ///最后一个不添加右边距
      if (i == widget.totalStarNum - 1) {
        rightSpace = 0;
      }

      list.add(Padding(
        padding: EdgeInsets.only(right: rightSpace),
        child: Icon(
          Icons.star,
          color: color,
          size: widget.starSize,
        ),
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }

  buildGes() {
    return GestureDetector(
      //手指按下
      onPanDown: (DragDownDetails details) {
        _touchPosition = details.localPosition;
        print("点击的位置$_touchPosition");
        setState(() {
          clipWidth = calculateClipWidth();
          print("距离$clipWidth");
        });
      },
      //手指平移，水平方向
      onHorizontalDragUpdate: (details) {
        _touchPosition = details.localPosition;
        setState(() {
          clipWidth = calculateClipWidth();
        });
      },
      child: buildContentContainer(),
    );
  }

  buildContentContainer() {
    return SizedBox(
      height: widget.starSize,
      width: _containerWidth,
      child: Stack(
        children: [
          /// 普通垫底
          buildStarWidget(widget.normalColor),
          buildSelectedStarWidget(),
        ],
      ),
    );
  }

  buildSelectedStarWidget() {
    return ClipRect(
        child: Align(
      alignment: Alignment.topLeft,
      widthFactor: clipWidth,
      child: buildStarWidget(widget.highLightColor),
    ));
  }

  double calculateClipWidth() {
    /// 用来记录当前的评分
    num callStar = 0;
    print(_touchPosition);

    /// 计算当前滑动到星星的位置
    double start =
        _touchPosition.dx / (widget.starSize + widget.horizontalSpace);
    switch (widget.echoStarType) {
      case EchoStarType.completeStar:

        /// 取整，四舍五入
        // callStar = start.round().toInt();
        callStar = start.ceil().toInt();
        break;
      case EchoStarType.halfStar:
        //取半
        List list = start.toString().split(".");
        String split = list[1];
        double splitDouble = double.parse("0.$split");
        if (splitDouble > 0.5) {
          callStar = double.parse("${int.tryParse(list[0]) ?? 0 + 1}");
        } else {
          callStar = double.parse("${list[0]}.5");
        }
        break;
      default:
        break;
    }

    print("计算吧$callStar");

    /// 边界计算限制
    if (callStar < 0) {
      callStar = 0;
    } else if (callStar > widget.totalStarNum) {
      callStar = widget.totalStarNum;
    }

    /// 评分变动的回调
    if (widget.selectCallback != null) {
      widget.selectCallback!(callStar);
    }

    /// 计算当前高亮显示的位置
    double clipWidth = 0;
    if (callStar > 1) {
      clipWidth = (callStar * widget.starSize +
              (callStar.ceil() - 1) * widget.horizontalSpace) /
          _containerWidth;
    } else {
      clipWidth = (callStar * widget.starSize +
              callStar.ceil() * widget.horizontalSpace) /
          _containerWidth;
    }
    return clipWidth;
  }
}
