import 'package:flutter/material.dart';
import 'package:hiringbell/models/constants.dart';
import 'package:hiringbell/models/dropdown_items.dart';
import 'package:hiringbell/services/http_service.dart';
import 'package:hiringbell/utilities/Util.dart';

class FilterRecordsSection extends StatefulWidget {
  final Function(DropdownItems)? onSelected;
  final String? searchUrl;

  const FilterRecordsSection({
    super.key,
    required this.searchUrl,
    required this.onSelected,
  });

  @override
  State<FilterRecordsSection> createState() => _FilterRecordsSectionState();
}

class _FilterRecordsSectionState extends State<FilterRecordsSection> {
  final bool isDark = false;
  bool isReady = false;
  final http = HttpService.getInstance();
  final util = Util.getInstance();
  bool filterMode = false;
  List<DropdownItems> listItem = [];
  final searchText = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    String searchString = "";
    if(searchText.text.length > 3) {
      searchString = searchText.text;
    } else {
      searchString = "";
    }

    var result = await http.httpPost(widget.searchUrl!,
        {"searchString": searchString, "pageSize": 10, "pageIndex": 1});

    if (result == null || result.responseBody == null) {
      util.showToast("fail to get country detail", type: Constants.fail);
      return;
    }

    listItem = [];
    for (var x in result.responseBody as List) {
      listItem.add(DropdownItems(
        value: x["value"],
        text: x["text"],
        icon: const Icon(Icons.flag),
      ));
    }

    setState(() {
      listItem = listItem;
      isReady = true;
    });
  }

  Widget bindData() {
    if (listItem.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                widget.onSelected!(listItem[index]);
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                child: ListTile(
                  leading: listItem[index].icon,
                  title: Text(listItem[index].text),
                ),
              ),
            );
          });
    } else {
      return const Padding(
        padding: EdgeInsets.only(
          top: Constants.contentVSpace * 2,
        ),
        child: Center(
          child: Text(
            "No record found",
            style: TextStyle(
              fontSize: Constants.fontSize * 2,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  Widget filterWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
        SearchBar(
          controller: searchText,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          leading: const Icon(Icons.edit_note_sharp),
          hintText: "type to search here...",
          onChanged: (text) {
            if (text.length > 3) {
              setState(() {
                isReady = false;
                filterMode = true;
              });

              loadData();
            }
          },
          trailing: <Widget>[
            filterMode
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isReady = false;
                        filterMode = false;
                      });

                      searchText.text = "";
                      loadData();
                    },
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    onPressed: () {
                      loadData();
                    },
                    icon: const Icon(Icons.search),
                  ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        if (isReady)
          bindData()
        else
          const Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      width: double.infinity,
      child: filterWidget(),
    );
  }
}
