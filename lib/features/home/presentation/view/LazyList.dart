import 'package:architecture/features/home/presentation/provider/provider.dart';
import 'package:architecture/features/home/presentation/view/widgets/FloatingActionBtn.dart';
import 'package:architecture/features/home/presentation/view/widgets/Sort_AlertDialoge.dart';
import 'package:architecture/features/home/presentation/view/widgets/User_card.dart';
import 'package:architecture/features/search/presentation/view/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Lazylist extends StatelessWidget {
  const Lazylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      floatingActionButton: FloatingActionBtn(
        context: context,
      ),
      body: SafeArea(
        child: Consumer<HomeProvider>(
          builder: (context, pro, child) => Column(
            children: [
              Container(
                color: Colors.grey.shade300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchUserScreen(),
                                  )),
                              child: CupertinoSearchTextField(
                                enabled: false,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SortingAlert();
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.filter_list)))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        'Users List',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: pro.scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  itemCount: pro.usersList.length,
                  itemBuilder: (context, index) {
                    final data = pro.usersList[index];

                    return Column(
                      children: [
                        userCard(data: data),
                        SizedBox(
                          height: 10,
                        ),
                        if (index == pro.usersList.length - 1 &&
                            !pro.isMoreDataLoading)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.blue,
                              ),
                            ),
                          )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
