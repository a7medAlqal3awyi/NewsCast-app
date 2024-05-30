import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:your_project_name/core/helper/exetentions.dart';

import '../core/helper/reformate_method.dart';
import '../core/helper/spacing.dart';

class DetailsScreen extends StatefulWidget {
  final String url;
  final String title;
  final String content;
  final String publishedAt;
  final String category;

  const DetailsScreen({
    super.key,
    required this.url,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.category,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var time = reformatDate(widget.publishedAt);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      child: FancyShimmerImage(
                        imageUrl: widget.url,
                        shimmerDuration: const Duration(seconds: 5),
                        height: 400.h,
                        width: double.infinity,
                        boxFit: BoxFit.cover,
                        errorWidget: Image.network(
                            "https://demofree.sirv.com/nope-not-here.jpg"),
                      ),
                    ),
                    Positioned(
                      top: 35.h,
                      left: 10.w,
                      right: 10.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 12.h),
                            child: Container(
                              width: 40.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.white.withOpacity(.3),
                              ),
                              child: Center(
                                child: IconButton(
                                    onPressed: () => context.pop(),
                                    icon: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                      size: 22,
                                    )),
                              ),
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white.withOpacity(.3),
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () {
                                    Share.share(widget.title);
                                  },
                                  icon: Icon(
                                    Icons.share_sharp,
                                    color: Colors.white,
                                    size: 22,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 245.h,
                        left: 20.w,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.teal.withOpacity(.8),
                          ),
                          width: 100.w,
                          height: 40.h,
                          child: Center(
                            child: Text(
                              widget.category,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                      top: 295.h,
                      right: 15.w,
                      left: 20.w,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 40.w,
                        ),
                        child: Text(
                          widget.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.sp,
                              height: 1.3,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 380.h,
                  right: 0.w,
                  left: 0.w,
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(22.r),
                          topLeft: Radius.circular(22.r),
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Content",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              color: Color(0xFF333647)),
                        ),
                        verticalSpacing(10),
                        Text(
                          widget.content,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Color(0xFF666C8E)),
                        ),
                        verticalSpacing(20),
                        Text(
                          "Published at : ${time}",
                          style: TextStyle(
                            color: Color(0xFF666C8E),
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
