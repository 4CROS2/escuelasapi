import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends SliverPersistentHeaderDelegate {
  double extentHader = 80.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin:  const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(top: 10)),
      alignment: Alignment.center,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.12),
            blurRadius: 17,
            offset:const  Offset(8, 10)
          ),
        ],
      ),
      child: Text(
        'Api Consumer',
        style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
    );
  }

  @override
  double get maxExtent => extentHader;

  @override
  double get minExtent => extentHader;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
