import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendor/utility/app_color.dart';

class AppNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit boxFit;
  const AppNetworkImage({Key? key, required this.url, required this.width, required this.height, this.boxFit=BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: "$url",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
              colorFilter:
              ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(strokeWidth: 1, color: AppColors.menuColor,),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
