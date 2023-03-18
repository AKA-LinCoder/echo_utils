/// FileName echo_drag_container
///
/// @Author LinGuanYu
/// @Date 2023/3/17 16:35
///
/// @Description TODO 手势缩放组件
import 'package:flutter/material.dart';

class EchoDragContainer extends StatefulWidget {
  final Widget child;
  final Function? onTap;
  const EchoDragContainer({Key? key, required this.child, this.onTap}) : super(key: key);

  @override
  State<EchoDragContainer> createState() => _EchoDragContainerState();
}

class _EchoDragContainerState extends State<EchoDragContainer> {
  ///当前缩放比例
  double currentScale = 1;

  ///缩放比例变化
  double _scale = 0;

  ///当前平移偏移量
  Offset currentOffset = Offset.zero;

  ///手指按下的点位
  Offset downFocalOffset = Offset.zero;

  ///手指滑动的偏移量
  Offset flagOffset = Offset.zero;

  ///当前旋转角度
  double currentRotation = 0;

  ///旋转角度
  double _rotation = 0;

  @override
  Widget build(BuildContext context) {
    return Transform(
      ///默认焦点是widget左上角
      alignment: FractionalOffset.center, //旋转中心
      transform: Matrix4.identity()
      ///注意：一定得先进行平移再进行旋转，如果先旋转在平移会造成坐标系的偏移，导致平移时的效果和预期效果不一致
        ///平移
        ..translate(
            (currentOffset + flagOffset).dx, (currentOffset + flagOffset).dy)
        ///旋转
        ..rotateZ(currentRotation + _rotation)
        ///等比缩放
        ..scale(currentScale + _scale, currentScale + _scale),
      child: GestureDetector(
        onTap: (){
          if(widget.onTap!=null){
            widget.onTap!();
          }
        },
        onScaleStart: (details) {
          ///记录这次开始的位置
          downFocalOffset = details.focalPoint;
        },
        onScaleUpdate: (details) {
          //获取当前的缩放值
          double scale = details.scale;
          ///获取当前手指滑动的距离
          Offset focalPoint = details.focalPoint;
          if (flagOffset != downFocalOffset) {
            if (details.pointerCount > 1) {
              if (scale == 1) {} else {
                ///scale不为1就当作是在缩放
                _scale = scale - 1;
              }
            } else {
              flagOffset = (focalPoint - downFocalOffset);
            }
          }

          setState(() {
            //获取当前旋转角度,正值代表顺时针旋转，负值逆时针旋转
            _rotation = details.rotation;
          });
        },
        onScaleEnd: (details) {
          ///记录最后的缩放大小
          currentScale += _scale;
          _scale = 0;
          ///记录最后的旋转大小
          currentRotation += _rotation;
          _rotation = 0;
          ///记录最后的平移距离
          currentOffset += flagOffset;
          flagOffset = Offset.zero;
        },
        child: Container(
            child: widget.child),
      ),
    );
  }
}
