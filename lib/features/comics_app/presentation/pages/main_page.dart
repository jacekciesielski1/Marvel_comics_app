import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '/features/comics_app/presentation/bloc/comics_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../widgets/build_image.dart';
import '../widgets/loading widget.dart';
import '../widgets/message_display.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final searchTextController = TextEditingController();
  String searchText = " ";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: kAppbarText,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      textCapitalization: TextCapitalization.words,
                      style: kTextfieldStyle,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Search for comic book by title",
                        hintStyle: kHintTextStyle,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          if (searchTextController.text.isEmpty) {
                            value = " ";
                          }
                          searchText = value;
                          dispatch();
                        });
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (searchTextController.text.isEmpty) {
                          searchText = " ";
                        }
                        dispatch();
                      });
                    },
                    child:
                        const Icon(Icons.search, color: Colors.red, size: 30),
                  ),
                ],
              ),
              Expanded(
                child: BlocBuilder<ComicsBloc, ComicsState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(
                          message:
                              "Start searching for comics by hero name, for example: Deadpool, Ant-man, Thor, Avengers....");
                    } else if (state is Loading) {
                      return const LoadingIndicator();
                    } else if (state is Loaded) {
                      final comics = state.comics.data.results;
                      return CarouselSlider.builder(
                        itemCount: comics.length,
                        itemBuilder: (context, index, realIndex) {
                          return buildImage(comics, index, context);
                        },
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                        ),
                      );
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message);
                    } else {
                      return const MessageDisplay(
                          message: "Bloc got messed up");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispatch() {
    searchTextController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<ComicsBloc>().add(GetConcreteComics(title: searchText));
  }
}
