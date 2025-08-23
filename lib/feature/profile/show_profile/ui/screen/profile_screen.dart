import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stepify/core/themes/colors.dart';
import 'package:stepify/feature/checkout/data/datasource/order_remote_datasource.dart';
import 'package:stepify/feature/checkout/data/repositories/order_repository_impl.dart';
import 'package:stepify/feature/checkout/ui/cubit/my_orders_cubit.dart';
import 'package:stepify/feature/checkout/ui/screens/my_orders_screen.dart';
import 'package:stepify/feature/profile/edit_profile/ui/screen/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: ProfileAppBar(),
      body: ProfileBody(),
    );
  }
}

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.secondaryColor,
      elevation: 0,
      surfaceTintColor: Colors.white,
      title: Text("Profile", style: Theme.of(context).textTheme.bodyLarge),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const EditProfileScreen()),
            );
          },
          child: Text(
            "Edit",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: ColorsManager.primaryColor),
          ),
        )
      ],
      leading: IconButton(
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
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          ProfileHeader(),
          SizedBox(height: 20),
          ProfileDataField(
            label: "Full Name",
            value: "Mohamed Mahmoud",
            hintText: "Enter your full name",
            showCheckIcon: true,
          ),
          SizedBox(height: 10),
          ProfileDataField(
            label: "Email",
            value: "mohamed@example.com",
            hintText: "Enter your email",
            showCheckIcon: true,
          ),
          SizedBox(height: 10),
          ProfileDataField(
            label: "Phone Number",
            value: "+1234567890",
            hintText: "Enter your phone number",
            showCheckIcon: true,
          ),
          SizedBox(height: 10),
          ProfileDataField(
            label: "Address",
            value: "123 Main Street, Cairo",
            hintText: "Enter your address",
            showCheckIcon: false,
          ),
          SizedBox(height: 10),
          //My Orders Section
          ListTile(
            title: Text(
              "My Orders",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            trailing:
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            onTap: () {
                
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => BlocProvider<MyOrdersCubit>(
              create: (_) {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                final remote =
                    OrderRemoteDataSourceImpl(FirebaseFirestore.instance);
                final repo = OrderRepositoryImpl(remote);
                return MyOrdersCubit(repo: repo, uid: uid);
              },
              child: const MyOrdersScreen(),
            )),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileDataField extends StatelessWidget {
  final String label;
  final String value;
  final String hintText;
  final bool showCheckIcon;

  const ProfileDataField({
    super.key,
    required this.label,
    required this.value,
    required this.hintText,
    this.showCheckIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: value),
            readOnly: true,
            decoration: InputDecoration(
              suffixIcon: showCheckIcon
                  ? const Icon(Icons.check, color: ColorsManager.primaryColor)
                  : null,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.textColor.withOpacity(0.5),
                  ),
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                borderSide: BorderSide(color: ColorsManager.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/human4.jpg"),
              ),
              const Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Mohamed Mahmoud",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {
              // تعديل الصورة
            },
            child: Text(
              "Edit Profile Picture",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorsManager.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
