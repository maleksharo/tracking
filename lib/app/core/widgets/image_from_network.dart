import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageFromNetworkWidget extends StatelessWidget {
  final String url;
  final BoxFit boxFit;

  const ImageFromNetworkWidget({
    required this.url,
    super.key,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: boxFit,
      progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
        child: Center(child: CupertinoActivityIndicator()),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
