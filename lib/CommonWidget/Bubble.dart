// ignore_for_file: file_names, constant_identifier_names, prefer_typing_uninitialized_variables, unnecessary_this, prefer_const_constructors

import 'package:flutter/material.dart';
 
const _ArrowWidth = 12.0;    //箭头宽度
const _ArrowHeight = 8.0;  //箭头高度
const _MinHeight = 32.0;    //内容最小高度
const _MinWidth = 50.0;     //内容最小宽度
 
class Bubble extends StatelessWidget {
  final BubbleDirection direction;
  final Radius? borderRadius;
  final Widget? child;
  final BoxDecoration? decoration;
  final Color? color;
  final _left;
  final _right;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxConstraints? constraints;
  final double? width;
  final double? height;
  final Alignment? alignment;
  const Bubble(
      {Key? key,
      this.direction = BubbleDirection.left,
      this.borderRadius,
      this.child, 
      this.decoration, 
      this.color, 
      this.padding, 
      this.margin, 
      this.constraints, 
      this.width, 
      this.height, 
      this.alignment})
      : _left = direction == BubbleDirection.left ? _ArrowWidth : 0.0,
        _right = direction == BubbleDirection.right ? _ArrowWidth : 0.0,
        super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
          _BubbleClipper(direction, this.borderRadius ?? Radius.circular(4.0)),
      child: Container(
        alignment: this.alignment,
        width: this.width,
        height: this.height,
        constraints: (this.constraints??BoxConstraints()).copyWith(minHeight: _MinHeight,minWidth: _MinWidth),
        margin: this.margin,
        decoration: this.decoration,
        color: this.color,
        padding: EdgeInsets.fromLTRB(this._left, 0.0, this._right, 0.0).add(this.padding??EdgeInsets.fromLTRB(7.0, 6.0, 7.0, 10.0)),
        child: this.child,
      ),
    );
  }
}
 
///方向
enum BubbleDirection { left, right, bottom, top  }
 
class _BubbleClipper extends CustomClipper<Path> {
  final BubbleDirection direction;
  final Radius radius;
  _BubbleClipper(this.direction, this.radius);
 
  @override
  Path getClip(Size size) {
    final path = Path();
    final path2 = Path();
    final centerPoint = (size.height / 2).clamp(_MinHeight/2, _MinHeight/2);
   
    if (this.direction == BubbleDirection.bottom) {
     
      path.moveTo((size.width/2 - _ArrowWidth/2), (size.height - _ArrowHeight));
      path.lineTo(size.width/2, size.height);
      path.lineTo((size.width/2 + _ArrowWidth/2), (size.height - _ArrowHeight));
      path.close();
      
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, (size.height - _ArrowHeight)), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));

    } else if (this.direction == BubbleDirection.top) {

      //绘制左边三角形
      path.moveTo((size.width/2 - _ArrowWidth/2), _ArrowHeight);
      path.lineTo(size.width/2, 0);
      path.lineTo((size.width/2 + _ArrowWidth/2), _ArrowHeight);
      path.close();
      
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, _ArrowHeight, size.width, (size.height - _ArrowHeight)), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));

    } else if (this.direction == BubbleDirection.left) {
      //绘制左边三角形
      path.moveTo(0, centerPoint);
      path.lineTo(_ArrowWidth, centerPoint - _ArrowHeight/2);
      path.lineTo(_ArrowWidth, centerPoint + _ArrowHeight/2);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(_ArrowWidth, 0, (size.width - _ArrowWidth), size.height), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));
    } else {
      //绘制右边三角形
      path.moveTo(size.width, centerPoint);
      path.lineTo(size.width - _ArrowWidth, centerPoint - _ArrowHeight/2);
      path.lineTo(size.width - _ArrowWidth, centerPoint + _ArrowHeight/2);
      path.close();
      //绘制矩形
      path2.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, (size.width - _ArrowWidth), size.height), this.radius));
      //合并
      path.addPath(path2, Offset(0, 0));
    }
    return path;
  }
 
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}