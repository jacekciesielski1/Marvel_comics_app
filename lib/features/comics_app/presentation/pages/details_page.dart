import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '/constants.dart';
import '../../domain/entities/comics.dart';
import '../widgets/loading widget.dart';

//page for displaying comics details after tapping on comics cover
class DetailsPage extends StatelessWidget {
  final List<Result> comics;
  final int index;
  const DetailsPage(this.comics, this.index, {Key? key}) : super(key: key);

  // function for launching website in browser
  launchMarvelWebsite(Uri url) async {
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Details"),
          backgroundColor: Colors.red,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "${comics[index].thumbnail.path}.jpg",
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: Material(
                  elevation: 10,
                  shadowColor: Colors.blue,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => const LoadingIndicator(),
                    imageUrl: "${comics[index].thumbnail.path}.jpg",
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
            ),
            Container(
              padding: kDetailsPagePadding,
              child: Text(
                comics[index].title,
                style: kDetailsPageTitle,
              ),
            ),
            Padding(
              padding: kDetailsPagePadding,
              child: Text(
                //some comics do not have data about writers(writers list may be empty), then it assigns Stan Lee
                "Written by: ${comics[index].creators.items.isEmpty ? "Stan Lee" : comics[index].creators.items[0].name}",
                style: kDetailsPageWriters,
              ),
            ),
            Expanded(
              child: Container(
                padding: kDetailsPagePadding,
                child: SingleChildScrollView(
                  child: Text(
                    //many comics descriptions are empty so i created default description too
                    comics[index].description ??
                        "Your favourite hero return in this new comic filled with thrilling events!",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextButton(
                onPressed: () {
                  //some comics may not have websites so there is a default value if websites list is empty
                  final Uri url = Uri.parse(comics[index].urls.isEmpty
                      ? "https://www.marvel.com/"
                      : comics[index].urls[0].url);
                  launchMarvelWebsite(url);
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    shadowColor: Colors.yellow,
                    elevation: 10,
                    backgroundColor: Colors.amber),
                child: kDetailsPageButtonText,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
