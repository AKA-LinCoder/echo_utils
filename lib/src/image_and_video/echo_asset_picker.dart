// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';
//
// import '../../echo_utils.dart';
//
// /// FileName echo_asset_picker
// ///
// /// @Author LinGuanYu
// /// @Date 2023/3/15 10:32
// ///
// /// @Description TODO 图像和视频获取
//
// // 最大数量
// const int _maxAssets = 9;
// // 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
// const Duration _maximumRecordingDuration = Duration(seconds: 15);
// // 一行显示几个
// const int _lineCount = 3;
// // 每个GridView item间距(GridView四周与内部item间距在此统一设置)
// const double _itemSpace = 5.0;
// // 右上角删除按钮大小
// const double _deleteBtnWH = 20.0;
// // 默认添加图片
// const String _addBtnIcon = 'assets/images/selectPhoto_add.png';
// // 默认删除按钮图片
// const String _deleteBtnIcon = 'assets/images/selectPhoto_close.png';
// // 默认背景色
// const Color _bgColor = Colors.transparent;
//
// enum AssetType {
//   photo,
//   video,
//   photoAndVideo,
// }
//
// class EchoAssetPicker extends StatefulWidget {
//
//   final AssetType assetType; // 资源类型
//   final int maxAssets; // 最大数量
//   final int lineCount; // 一行显示几个
//   final double itemSpace; // 每个GridView item间距(GridView四周与内部item间距在此统一设置)
//   final Duration? maximumRecordingDuration; // 录制视频最长时长, 默认为 15 秒，可以使用 `null` 来设置无限制的视频录制
//   final Color bgColor; // 背景色
//   final Function(List<AssetEntity> assetEntityList)? callBack; // 选择回调
//
//   const EchoAssetPicker({Key? key,
//     this.assetType = AssetType.photo,
//     this.maxAssets = _maxAssets,
//     this.lineCount = _lineCount,
//     this.itemSpace = _itemSpace,
//     this.maximumRecordingDuration = _maximumRecordingDuration,
//     this.bgColor = _bgColor,
//     this.callBack,
//   }) : super(key: key);
//
//   @override
//   State<EchoAssetPicker> createState() => _EchoAssetPickerState();
// }
//
// class _EchoAssetPickerState extends State<EchoAssetPicker> {
//
//   RxList<AssetEntity> selectedAssets = <AssetEntity>[].obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: widget.bgColor,
//       child: GridView.builder(
//           padding: EdgeInsets.all(widget.itemSpace),
//           itemCount: selectedAssets.length == widget.maxAssets ? selectedAssets.length : selectedAssets.length+1,
//           gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
//             // 可以直接指定每行（列）显示多少个Item
//             crossAxisCount: widget.lineCount, // 一行的Widget数量
//             crossAxisSpacing: widget.itemSpace, // 水平间距
//             mainAxisSpacing: widget.itemSpace, // 垂直间距
//             childAspectRatio: 1.0, // 子Widget宽高比例
//           ),
//           itemBuilder: (context, index) {
//             if (selectedAssets.length == widget.maxAssets) {
//               return _itemWidget(index);
//             }
//             if (index == selectedAssets.length) {
//               return _addBtnWidget();
//             } else {
//               return _itemWidget(index);
//             }
//           }),
//     );
//   }
//
//   // 添加按钮
//   Widget _addBtnWidget() {
//     return GestureDetector(
//       child: const Image(image: AssetImage(_addBtnIcon)),
//       onTap: () => _showBottomSheet(),
//     );
//   }
//
//   // 图片和删除按钮
//   Widget _itemWidget(index) {
//     return GestureDetector(
//       child: Container(
//         color: Colors.transparent,
//         child: Stack(
//           alignment: Alignment.topRight,
//           children: <Widget>[
//             ConstrainedBox(
//               constraints: const BoxConstraints.expand(),
//               child: _loadAsset(selectedAssets[index]),
//             ),
//             GestureDetector(
//               child: const Image(
//                 image: AssetImage(_deleteBtnIcon),
//                 width: _deleteBtnWH,
//                 height: _deleteBtnWH,
//               ),
//               onTap: () => _deleteAsset(index),
//             )
//           ],
//         ),
//       ),
//       onTap: () => _clickAsset(index),
//     );
//   }
//
//   Widget _loadAsset(AssetEntity asset) {
//     return Image(image: AssetEntityImageProvider(asset), fit: BoxFit.cover);
//   }
//
//   void _deleteAsset(index) {
//     setState(() {
//       selectedAssets.removeAt(index);
//       // 选择回调
//       widget.callBack?.call(selectedAssets);
//     });
//   }
//
//   // 全屏查看
//   void _clickAsset(index) {
//     AssetPickerViewer.pushToViewer(
//       context,
//       currentIndex: index,
//       previewAssets: selectedAssets,
//       themeData: AssetPicker.themeData(_themeColor),
//     );
//   }
//
//   // 点击添加按钮
//   void _showBottomSheet() {
//     List<BottomSheetModel> modes = [
//       BottomSheetModel(
//           title: "相册",
//           onPressed: (context) async {
//             //TODO 需要展示出这个人的成绩以供最后确认
//             openAlbum(context);
//           },
//           textStyle: TextStyle(fontSize: 15),
//           itemHeight: 50),
//       BottomSheetModel(
//           title: "拍摄",
//           onPressed: (context) async {
//             openCamera(context);
//           },
//           textStyle: TextStyle(fontSize: 15),
//           itemHeight: 50),
//       BottomSheetModel(
//           title: "取消",
//           onPressed: (context) {},
//           textStyle: TextStyle(fontSize: 15, color: Colors.redAccent),
//           itemHeight: 50),
//     ];
//     echoBottomSheet(context, modes);
//   }
//
//
//   ///@title openAlbum
//   ///@description TODO 打开相册
//   ///@param: context
//   ///@return: Future<void>
//   ///@updateTime 2023/3/15 11:16
//   ///@author LinGuanYu
//   Future<void> openAlbum(BuildContext context) async {
//     // 相册权限
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();
//     if (ps != PermissionState.authorized && ps != PermissionState.limited) {
//       EasyLoading.showError('暂无相册权限,请前往设置开启权限');
//       return;
//     }
//
//     RequestType requestType = RequestType.video;
//     final List<AssetEntity>? result = await AssetPicker.pickAssets(
//       context,
//       pickerConfig: AssetPickerConfig(
//         maxAssets: widget.maxAssets,
//         requestType: requestType,
//         selectedAssets: selectedAssets,
//         // themeColor: _themeColor,
//         textDelegate: const AssetPickerTextDelegate(),
//       ),
//     );
//     if (result != null) {
//       selectedAssets.addAll(result);
//     }
//   }
//
//   ///@title openCamera
//   ///@description TODO 打开相机
//   ///@param: context
//   ///@return: Future<void>
//   ///@updateTime 2023/3/15 14:46
//   ///@author LinGuanYu
//   Future<void> openCamera(BuildContext context) async {
//
//     // 相机权限
//     var isGrantedCamera = await Permission.camera.request().isGranted;
//     if (!isGrantedCamera) {
//       // EasyLoading.showError('暂无相机权限,请前往设置开启权限');
//       return;
//     }
//
//     // 麦克风权限
//     var isGrantedMicrophone = await Permission.microphone.request().isGranted;
//     if (!isGrantedMicrophone) {
//       // EasyLoading.showError('暂无麦克风权限,请前往设置开启权限');
//       return;
//     }
//
//     // 相册权限
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();
//     if (ps != PermissionState.authorized && ps != PermissionState.limited) {
//       // EasyLoading.showError('暂无相册权限,请前往设置开启权限');
//       return;
//     }
//
//
//     AssetEntity? videoResult;
//     AssetEntity? result = await CameraPicker.pickFromCamera(
//       context,
//       pickerConfig: CameraPickerConfig(
//         // 只能录像
//           enableRecording: true,
//           onlyEnableRecording: true,
//           enableTapRecording: true,
//           // 录制视频最长时长
//           maximumRecordingDuration: maximumRecordingDuration,
//           textDelegate: const CameraPickerTextDelegate(),
//           onError: (error, stack) {
//             EasyLoading.showError("相机启动失败请稍后重试");
//           },
//           onEntitySaving: (context, type, file) async {
//             try {
//               videoResult = await PhotoManager.editor.saveVideo(
//                 file,
//                 title: id,
//               );
//               Navigator.of(context)
//                 ..pop()
//                 ..pop();
//             } catch (e) {
//             } finally {}
//           }
//       ),
//     );
//
//     if (result != null) {
//       states.selectedAssets.add(result);
//     }
//     if (videoResult != null) {
//       states.selectedAssets.add(videoResult!);
//     }
//
//   }
//
// }
