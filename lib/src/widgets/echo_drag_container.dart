/// FileName echo_drag_container
///
/// @Author LinGuanYu
/// @Date 2023/3/17 16:35
///
/// @Description TODO 手势缩放组件
import 'package:echo_utils/echo_utils.dart';
import 'package:flutter/material.dart';

class EchoDragContainer extends StatefulWidget {
  final Widget child;
  final Function? onTap;
  /// 获取widget的大小以及widget左上角的位置
  final Function(Offset,Size)? getPositionAndSize;
  const EchoDragContainer({Key? key, required this.child, this.onTap, this.getPositionAndSize}) : super(key: key);

  @override
  State<EchoDragContainer> createState() => _EchoDragContainerState();
}

class _EchoDragContainerState extends State<EchoDragContainer> {

  GlobalKey key = GlobalKey();

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

  late Duration _tapDownTimeStamp;

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
        // onTap: (){
        //   if(widget.onTap!=null){
        //     widget.onTap!();
        //   }
        // },
        onTapDown: (details){
          ///第一种获取元素的位置
          // //相对于父组件的位置
          // Offset localOffset = details.localPosition;
          // //获取相对于屏幕的位置
          // Offset globalOffset = details.globalPosition;
          // //获取widget的左上角的位置
          // Offset leftTopOffset = globalOffset-localOffset;
          // echoLog("widget的左上角的位置$leftTopOffset");
          ///第二种获取元素位置的办法
          BuildContext? keyContext = key.currentContext;
          if(keyContext!=null){
            //获取renderBox
            RenderBox? renderBox = keyContext.findRenderObject() as RenderBox?;
            if(renderBox!=null){
              //获取widget的左上角的位置
              Offset leftTopOffset1 = renderBox.localToGlobal(Offset.zero);
              //对应widget的大小
              Size size = renderBox.paintBounds.size;
              echoLog("第二种方式：widget的左上角的位置$leftTopOffset1");
              echoLog("第二种方式：widget的大小$size");
              if(widget.getPositionAndSize!=null){
                widget.getPositionAndSize!(leftTopOffset1,size);
              }
            }
          }
          // ///第三种获取元素位置和大小的方法
          // ///添加最后一帧
          // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          //     //获取全局context
          //   RenderObject? renderObject = context.findRenderObject();
          //   if(renderObject!=null){
          //     //获取元素大小
          //     Size size = renderObject.paintBounds.size;
          //     //获取元素位置
          //     var mm = renderObject.getTransformTo(null)?.getTranslation();
          //     Offset offset = Offset(mm?.x??0, mm?.y??0);
          //     echoLog("第3种方式：widget的左上角的位置$offset");
          //     echoLog("第3种方式：widget的大小$size");
          //   }
          //
          // });
          // setState(() {
          //
          // });
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
        ///网上有人存在缩放延迟的问题 http://events.jianshu.io/p/7e5de6c9a647
        ///使用的是listener进行处理tap事件
        child: Listener(
          key: key,
          onPointerDown: (PointerDownEvent event) {
            // 记录点击时间
            _tapDownTimeStamp = event.timeStamp;
          },
          onPointerUp: (PointerUpEvent event) {
            // 手指抬起时，计算时间差，100ms以内算点击事件
            int interval = event.timeStamp.inMilliseconds -
                _tapDownTimeStamp.inMilliseconds;

            if (interval <= 100) {
              // 处理tap事件
              if(widget.onTap!=null){
                widget.onTap!();
              }
            }
          },
          child: Container(
              child: widget.child),
        ),
      ),
    );
  }
}
