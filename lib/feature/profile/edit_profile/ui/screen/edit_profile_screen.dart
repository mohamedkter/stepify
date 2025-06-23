import 'package:flutter/material.dart';
import 'package:stepify/core/themes/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController(text: "Mohamed Mahmoud");
  final emailController = TextEditingController(text: "mohamed@example.com");
  final phoneController = TextEditingController(text: "+1234567890");
  final addressController =
      TextEditingController(text: "123 Main Street, Cairo");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.secondaryColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        title:
            Text("Edit Profile", style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              print("Saved: ${nameController.text}");
              Navigator.pop(context);
            },
            child: Text(
              "Done",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: ColorsManager.primaryColor),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 16, color: ColorsManager.textColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          ProfileDataField(
            label: "Full Name",
            hintText: "Enter your full name",
            controller: nameController,
            showCheckIcon: false,
            readOnly: false,
          ),
          const SizedBox(height: 10),
          ProfileDataField(
            label: "Email",
            hintText: "Enter your email",
            controller: emailController,
            showCheckIcon: false,
            readOnly: false,
          ),
          const SizedBox(height: 10),
          ProfileDataField(
            label: "Phone Number",
            hintText: "Enter your phone number",
            controller: phoneController,
            showCheckIcon: false,
            readOnly: false,
          ),
          const SizedBox(height: 10),
          ProfileDataField(
            label: "Address",
            hintText: "Enter your address",
            controller: addressController,
            showCheckIcon: false,
            readOnly: false,
          ),
        ],
      ),
    );
  }
}

class ProfileDataField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool showCheckIcon;
  final bool readOnly;
  final TextEditingController? controller;

  const ProfileDataField({
    super.key,
    required this.label,
    required this.hintText,
    this.showCheckIcon = false,
    this.readOnly = true,
    this.controller,
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
            controller: controller,
            readOnly: readOnly,
            decoration: InputDecoration(
              suffixIcon: showCheckIcon
                  ? const Icon(Icons.check, color: ColorsManager.primaryColor)
                  : const Icon(Icons.edit,
                      size: 16, color: ColorsManager.errorColor),
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
