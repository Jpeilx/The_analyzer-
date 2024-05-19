import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/core/constant/assets_data.dart';
import 'package:the_analyzer/core/widget/shimmer_widget.dart';

class CachedImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final BoxShape boxShap;
  final String? errorImage;
  final BoxFit? boxfit;
  const CachedImage(
      {super.key,
      this.boxShap = BoxShape.circle,
      this.width = 55,
      this.height = 55,
      this.errorImage,
      this.boxfit,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: boxShap,
          image: DecorationImage(
            image: imageProvider,
            fit: boxfit ?? BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => ShimmerWidget.circular(
        height: height.h,
        width: width.w,
        shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.r),
          topRight: Radius.circular(4.r),
        )),
      ),
      errorWidget: (context, url, error) => Image.asset(
        errorImage ?? AssetsData.noImage,
        height: height,
        width: width,
      ),
    );
  }
}
