import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/components/heading.dart';
import 'package:movies_app/components/nav_header.dart';
import 'package:movies_app/components/search_bar.dart';
import 'package:movies_app/components/search_list.dart';
import 'package:movies_app/utils/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late String searchValue = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      // height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(kDefaultPadding / 2),
                bottomRight: Radius.circular(kDefaultPadding / 2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SearchBarComp(
                onPressed: (value) => setState(() {
                  searchValue = value;
                }),
              ),
            ),
          ),
          searchValue.isNotEmpty
              ? const Heading(title: 'Search results')
              : SizedBox(
                  height: size.height * 0.6,
                  child: const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.search,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Ready to Discover?')
                      ],
                    ),
                  ),
                ),
          searchValue.isNotEmpty
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: SearchList(
                    searchValue: searchValue,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
