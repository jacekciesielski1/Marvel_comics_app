import 'package:flutter/material.dart';
import '/features/comics_app/presentation/pages/details_page.dart';
import '/constants.dart';
import '../../domain/entities/comics.dart';
import 'loading widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

// widget fo building images fo carousel slider
Widget buildImage(List<Result> comics, int index, context) {
  return GestureDetector(
    onTap: () {
      onImageTap(context, comics, index);
    },
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "${comics[index].thumbnail.path}.jpg",
              child: CachedNetworkImage(
                placeholder: (context, url) => const LoadingIndicator(),
                imageUrl: "${comics[index].thumbnail.path}.jpg",
                errorWidget: (context, url, error) =>
                    const Icon(Icons.wifi_off_outlined),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                comics[index].title,
                style: kComicsBoxTextStyle,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void onImageTap(context, List<Result> comics, int index) {
  FocusManager.instance.primaryFocus?.unfocus();
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DetailsPage(comics, index)));
}
