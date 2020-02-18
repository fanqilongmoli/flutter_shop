import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/util/image_utils.dart';

class LoadImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final String holderImg;

  LoadImage(this.image,
      {Key key,
      this.width,
      this.height,
      this.fit: BoxFit.cover,
      this.format: 'png',
      this.holderImg: 'none'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (TextUtil.isEmpty(image) || image == 'null') {
      return LoadAssetImage(holderImg,
          height: height, width: width, fit: fit, format: format);
    } else {
      if (image.startsWith('http')) {
        return CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => LoadAssetImage(holderImg,
                height: height, width: width, fit: fit),
            errorWidget: (context, url, error) => LoadAssetImage(holderImg,
                height: height, width: width, fit: fit),
            width: width,
            height: height,
            fit: fit);
      } else {
        return LoadAssetImage(image,
            height: height, width: width, fit: fit, format: format);
      }
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  LoadAssetImage(this.image,
      {Key key,
      this.width,
      this.height,
      this.fit,
      this.format: 'png',
      this.color})
      : super(key: key);

  final String image;
  final double width;
  final double height;
  final BoxFit fit;
  final String format;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageUtils.getImgPath(image, format: format),
        height: height,
        width: width,
        fit: fit,
        color: color,
        // 忽略图片语义
        excludeFromSemantics: true);
  }
}
