import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/constants.dart';

typedef IntCallback = void Function(String searchValue);

class SearchBarComp extends StatefulWidget {
  final IntCallback? onPressed;
  const SearchBarComp({super.key, this.onPressed});

  @override
  State<SearchBarComp> createState() => _SearchBarCompState();
}

class _SearchBarCompState extends State<SearchBarComp> {
  bool value = false;
  final TextEditingController _textEditingController = TextEditingController();
  // void _fetchDataFromApi(String searchText) async {
  //   final response = await RemoteService().searchByFirstLetter(searchText[0]);
  //   if (response != null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => SearchResults(
  //                 meal: response,
  //               )),
  //     );
  //   }
  // }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onSubmitted: (text) {
        if (widget.onPressed != null) {
          widget.onPressed!(text);
        }
        // Call the API fetch function when the user submits text
        // _fetchDataFromApi(text);
      },
      onChanged: (text) {
        setState(() {
          if (text.isNotEmpty) {
            value = true;
          } else {
            value = false;
          }
        });
      },
      style: TextStyle(
        color: Theme.of(context).floatingActionButtonTheme.backgroundColor,
      ),
      cursorColor: Theme.of(context).colorScheme.tertiary,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(5.0),
        filled: true,
        fillColor: Theme.of(context).secondaryHeaderColor,
        // fillColor: Colors.orange.shade900,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
        hintText: 'Search movies...',
        hintStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          // color: Colors.grey.shade500,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        prefixIcon: Icon(
          CupertinoIcons.search,
          // color: Colors.grey.shade500,
          color: Theme.of(context).colorScheme.tertiary,
          size: 18,
        ),

        suffixIcon: value
            ? IconButton(
                icon: Icon(
                  CupertinoIcons.clear,
                  size: 18,
                  // color: Colors.grey.shade500,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                onPressed: () {
                  setState(() {
                    value = false;
                    _textEditingController.clear();
                  });
                },
              )
            : const SizedBox(),
      ),
    );
  }
}
