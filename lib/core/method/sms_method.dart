import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Stack SmsMethod( item ) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        alignment: item['type'] == 1 ? Alignment.topLeft : Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            constraints: BoxConstraints(maxWidth: 80.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                  bottomLeft: item['type'] == 1
                      ? Radius.circular(0)
                      : Radius.circular(30.0),
                  bottomRight: item['type'] == 1
                      ? Radius.circular(30.0)
                      : Radius.circular(0)),
              color: Colors.white,
              border: item['type'] == 1
                  ? Border.all(width: 3, color: Colors.green)
                  : Border.all(
                      width: 3, color: Color.fromARGB(255, 120, 61, 248)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                item['text'].toString(),
                style: TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        child: Container(
          padding: EdgeInsets.all(12.px),
          alignment:
              item['type'] == 1 ? Alignment.bottomRight : Alignment.bottomLeft,
          child: Text(
            item['time'].toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      )
    ],
  );
}
