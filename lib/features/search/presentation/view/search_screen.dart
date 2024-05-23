import 'package:architecture/features/search/presentation/provider/search_provider.dart';
import 'package:architecture/general/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'widget/textfield_widget.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 229, 229, 229),
          // appBar: AppBar(
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.black,
          //   title: const Text(
          //     "Search User",
          //     style:
          //         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          //   ),
          //   leading: Consumer<SearchUserProvider>(
          //       builder: (context, searchProvider, child) {
          //     return IconButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //           searchProvider.userSearchList.clear();
          //           searchProvider.searchController.clear();
          //         },
          //         icon: const Icon(Icons.arrow_back_ios_rounded));
          //   }),
          //   iconTheme:
          //       const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
          // ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<SearchUserProvider>(
                  builder: (context, searchProvider, child) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Consumer<SearchUserProvider>(
                            builder: (context, searchProvider, child) {
                          return IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                searchProvider.userSearchList.clear();
                                searchProvider.searchController.clear();
                              },
                              icon: const Icon(Icons.arrow_back_ios_rounded));
                        }),
                        Expanded(child: const SearchForm()),
                      ],
                    ),
                    Expanded(
                        child: searchProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : searchProvider.userSearchList.isEmpty
                                ? Center(
                                    child: Text(
                                      searchProvider
                                              .searchController.text.isEmpty
                                          ? ""
                                          : 'No User Found',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  )
                                : ListView.builder(
                                    controller: searchProvider.scrollController,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    itemCount:
                                        searchProvider.userSearchList.length,
                                    itemBuilder: (context, index) {
                                      final data =
                                          searchProvider.userSearchList[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: data.url == ''
                                                ? CircleAvatar(
                                                    radius: 30.r,
                                                    backgroundImage: AssetImage(
                                                        AppImages.personImage),
                                                    backgroundColor:
                                                        Colors.grey,
                                                  )
                                                : CircleAvatar(
                                                    radius: 30.r,
                                                    backgroundImage:
                                                        NetworkImage(data.url),
                                                    backgroundColor:
                                                        Colors.grey,
                                                  ),
                                            title: Text(data.name),
                                            subtitle: Text('Age:${data.age}'),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            tileColor: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (index ==
                                                  searchProvider.userSearchList
                                                          .length -
                                                      1 &&
                                              searchProvider.isMoreDataLoading)
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 3,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            )
                                        ],
                                      );
                                    },
                                  ))
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
