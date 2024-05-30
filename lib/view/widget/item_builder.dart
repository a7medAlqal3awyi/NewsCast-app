import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helper/reformate_method.dart';
import '../../core/helper/spacing.dart';

import '../details_screen.dart';

class ItemBuilder extends StatelessWidget {
  final Map list;
  final String category;
  const ItemBuilder({super.key, required this.list, required this.category});


  @override
  Widget build(BuildContext context) {
    var time = reformatDate(list['publishedAt']);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              category:category ,
              url: '${list['urlToImage']}',
              title: '${list['title']}',
              content: '${list['content']}',
              publishedAt: '${list['publishedAt']}',
            ),
          ),
        );
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FancyShimmerImage(
                  shimmerDuration: const Duration(seconds: 2),
                  imageUrl: '${list['urlToImage']}',
                  boxFit: BoxFit.cover,
                  height: 160.h,
                  width: 150.w,
                  errorWidget: Image.network(
                      fit: BoxFit.cover,
                      height: 160.h,
                      width: 150.w,
                      "https://demofree.sirv.com/nope-not-here.jpg"),

                ),
              ),
              horizontalSpacing(10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${list['title']}',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                    verticalSpacing(8),
                    Text(
                      '${list['description']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    verticalSpacing(8),
                    Text(
                      time.toString(),
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
