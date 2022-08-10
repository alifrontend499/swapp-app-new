import 'package:flutter/material.dart';

// icons
import 'package:unicons/unicons.dart';

class MapSearch extends SearchDelegate {

  @override
  Widget? buildLeading(BuildContext context) {
    return (
        IconButton(
          icon: const Icon(
            UniconsLine.arrow_left,
          ),
          color: Colors.black54,
          splashColor: Colors.transparent,
          onPressed: () => close(context, null),
        )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          UniconsLine.times,
        ),
        color: Colors.black54,
        splashColor: Colors.transparent,
        onPressed: () => {
          if(query.isEmpty) {
            close(context, null)
          } else {
            query = ''
          }
        },
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return (
        Container(
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return (
        Container(
        )
    );
  }

}
