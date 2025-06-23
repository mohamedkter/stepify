import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentNotifications = [
      {
        "type": "offer",
        "title": "Exclusive 30% Off!",
        "message": "Grab your favorite sneakers before the offer ends!",
        "time": "2m ago",
      },
      {
        "type": "order",
        "title": "Order Confirmed",
        "message": "Your order for Nike Jordan has been confirmed.",
        "time": "10m ago",
      },
    ];

    final yesterdayNotifications = [
      {
        "type": "offer",
        "title": "Flash Sale 🔥",
        "message": "Get up to 40% off on Adidas runners today only!",
        "time": "1d ago",
      },
      {
        "type": "order",
        "title": "Order Shipped",
        "message": "Your Puma Ultra has been shipped. Track now.",
        "time": "1d ago",
      },
    ];

    return Scaffold(
      backgroundColor: ColorsManager.secondaryColor,
      appBar: AppBar(
        title:
            Text("Notifications", style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.delete_outline_outlined, size: 28)),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.secondaryColor,
                  shape: const CircleBorder(),
                  fixedSize: Size(30.w, 30.w),
                ),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: ColorsManager.textColor,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        children: [
          if (recentNotifications.isNotEmpty) ...[
            Text("Recent",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            ...recentNotifications
                .map((item) => _buildNotificationItem(item))
                .toList(),
            SizedBox(height: 20.h),
          ],
          if (yesterdayNotifications.isNotEmpty) ...[
            Text("Yesterday",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            ...yesterdayNotifications
                .map((item) => _buildNotificationItem(item))
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, String> item) {
    final isOffer = item["type"] == "offer";
    final icon = isOffer ? Icons.local_offer : Icons.shopping_bag;
    final iconColor = isOffer ? Colors.deepOrange : Colors.green;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundColor: iconColor.withOpacity(0.1),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["title"]!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 4.h),
                Text(item["message"]!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[700],
                    )),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(item["time"]!,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}
