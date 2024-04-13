import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_player/src/feature/search/view/widgets/search_list_widget.dart';
import 'package:music_player/src/feature/search/view/widgets/search_top_bar.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});
  static const routePath = "/search";
  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchTopBarWidget(searchController: searchController),
          const SearchListWidget(),
        ],
      ),
    );
  }
}
