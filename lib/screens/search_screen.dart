import 'package:flutter/material.dart';
import 'package:flutter_application_utopia/actions/actions.dart';
import 'package:flutter_application_utopia/const/commonColor.dart';
import 'package:flutter_application_utopia/const/common_widgets.dart';
import 'package:flutter_application_utopia/const/navBar.dart';
import 'package:flutter_application_utopia/model/friends.dart';

class SearchScreen extends StatefulWidget {
  final searchText;
  const SearchScreen({Key? key, this.searchText}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<Search> data = [];
  atStart() async {
    if (widget.searchText != null) {
      searchController.text = widget.searchText;
      data = await getSearch(searchController.text);

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    atStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getCustomenavBar(2),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Search",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: grey,
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              getSearchtextField("What Would You Like To Search ? ", "",
                  searchController, onChanged),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Suggestions",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                title: Text(" ${data[index].name}"),
                                subtitle:
                                    Text(" ${data[index].type.split(' ')[0]}"),
                                trailing:
                                    data[index].type.split(' ')[0] == "channel"
                                        ? IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.person_add_alt),
                                          )
                                        : IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.done_all),
                                          ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onChanged(data1) {
    data = data1;
    setState(() {});
  }
}
