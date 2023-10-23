import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/Screen/tabprofiles/FavoriteVideos.dart';
import 'package:tiktok_clone/Screen/tabprofiles/LikeVideo.dart';
import 'package:tiktok_clone/Screen/tabprofiles/MyVideos.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiktok_clone/Screen/tabprofiles/editprofilepages/EditProfile.dart';
import 'package:tiktok_clone/controllers/profile_controller.dart';
import 'package:tiktok_clone/widgets/editpage.dart';

import '../widgets/ButtonEditProfile_widget.dart';

class ProFilePage extends StatefulWidget {
  final String uid;
  const ProFilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage>
    with TickerProviderStateMixin {
  bool isBio = false; //biến check để hiện thị mô tả hoặc thêm mô tả thông tin
  ScrollController scrollController = ScrollController();
  TabController? tabController;

  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    tabController = TabController(length: 3, vsync: this);
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: FutureBuilder(
                future: null,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        //thanh menu
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.menu,
                                  color: Colors.pink,
                                  size: 15,
                                )),
                            //Tên người dùng
                            Text(
                              "Tên người dùng",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.logout,
                                  color: Colors.pink,
                                  size: 15,
                                )),
                          ],
                        ),
                        //ảnh Profile
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            SizedBox(
                              height: 70,
                              width: 70,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: controller.user['profilePhoto'],
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              // child: CircleAvatar(
                              //   backgroundColor: Colors.black,
                              // ),
                            ),
                            Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.upload,
                                      color: Colors.pink,
                                      size: 20,
                                    )))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //thông tin Email
                        Text(
                          controller.user['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Following
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                children: [
                                  Text(
                                    controller.user['following'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ), //số lượng
                                  const Text(
                                    "Following",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 10),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                children: [
                                  Text(
                                    controller.user['followers'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ), //số lượng
                                  const Text("Follower",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ))
                                ],
                              ),
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  color: Colors.grey.withOpacity(0.8),
                                  fontSize: 10),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.15,
                              child: Column(
                                children: [
                                  Text(
                                    controller.user['likes'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ), //số lượng
                                  Text(
                                    "Like",
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.8),
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            ),
                            //follower
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //botton editt
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Center(
                                  child: InkWell(
                                onTap: () {
                                  if (widget.uid == authController.user.uid) {
                                    EditProifilePage();
                                  } else {
                                    controller.followUser();
                                  }
                                },
                                child: Text(
                                  widget.uid == authController.user.uid
                                      ? 'Edit profile'
                                      : controller.user['isFollowing']
                                          ? 'UnFollow'
                                          : 'Follow',
                                ),
                              )),
                            )

                            //Sửa hồ sơ
                            // ButtonEditProfile(
                            //     check: true, nameButton: "Edit profile"),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // ButtonEditProfile(
                            //     check: false, nameButton: "Add frined"),
                            // //Sửa hồ sơ
                          ],
                        ),
                        SizedBox(height: 5),
                        if (!isBio)
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.25)),
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                size: 5,
                                color: Colors.black,
                              ),
                              label: Text("Add bio",
                                  style: TextStyle(
                                      fontSize: 7, color: Colors.black)),
                            ),
                          ),
                        if (isBio)
                          Text("mô tả",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Sửa hồ sơ
                            Container(
                              height: 15,
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.access_time_outlined,
                                  size: 10,
                                  color: Colors.red,
                                ),
                                label: Text("Your orders",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //Sửa hồ sơ
                            Container(
                              height: 15,
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 10,
                                  color: Colors.red,
                                ),
                                label: Text("Add yours",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                        //tab view
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            controller: tabController,
                            indicatorColor: Colors.black,
                            indicatorWeight: 1,
                            tabs: [
                              Tab(
                                icon: Icon(
                                  Icons.list,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                              Tab(
                                icon: Icon(
                                  Icons.bookmark_added_outlined,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                              Tab(
                                icon: Icon(
                                  Icons.heart_broken,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                            controller: tabController,
                            children: const [
                              MyVideoTab(),
                              FavorriteVideoTab(),
                              LikeVideoTab(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }
}
