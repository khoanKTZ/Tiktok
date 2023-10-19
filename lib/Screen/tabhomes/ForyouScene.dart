import 'package:flutter/material.dart';
import 'package:tiktok_clone/widgets/HomeSideBar_widget.dart';
import 'package:tiktok_clone/widgets/VideoDetail.dart';

class ForyouScene extends StatefulWidget {
  const ForyouScene({super.key});

  @override
  State<ForyouScene> createState() => _ForyouSceneState();
}

class _ForyouSceneState extends State<ForyouScene> {

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // VideoTile(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //tạo một vieo hiển thị video ở đây
                Expanded(flex: 3, child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: VideoDetail(),
                )),
                Expanded(child: Container(
                  height: MediaQuery.of(context).size.height / 1.75,
                  child: HomeSideBar(),
                )),
              ],
            ),
          ],
        );
      },
    );
  }
}
