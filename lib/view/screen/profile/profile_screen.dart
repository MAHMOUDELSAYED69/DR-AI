import 'dart:developer';
import 'dart:io';
import 'package:dr_ai/core/cache/cache.dart';
import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/constant/routes.dart';
import 'package:dr_ai/data/service/firebase/firebase_service.dart';
import 'package:dr_ai/logic/image/image_cubit.dart';
import 'package:dr_ai/view/widget/custom_button.dart';
import 'package:dr_ai/view/widget/custom_profile_card_botton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../core/constant/color.dart';
import '../../../core/helper/scaffold_snakbar.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  GoogleSignIn googleSignIn = GoogleSignIn();

  bool isImageLoading = false;
  bool isLogOutLoading = false;
  String? imageUrl;
  void pickImage() {
    BlocProvider.of<ImageCubit>(context).pickImageFromGallery();
  }

  void logOut() {
    CacheData.clearData(clearData: true);
    FirebaseService.logOut();
    scaffoldSnackBar(context, "Log out");
    Navigator.pushNamedAndRemoveUntil(
        context, MyRoutes.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          child: Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context,MyRoutes.nav, (route) => false),
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text("Profile",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 68,
                    child: Container(
                      width: 343,
                      height: 182,
                      decoration: BoxDecoration(
                          color: MyColors.green2.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  Positioned(
                    top: 32,
                    width: 102,
                    height: 102,
                    child: BlocConsumer<ImageCubit, ImageState>(
                      listener: (context, state) {
                        if (state is Imageloading) {
                          isImageLoading = true;
                        }
                        if (state is ImageSuccess) {
                          isImageLoading = false;
                          imageUrl = state.imageUrl;
                        }
                        if (state is ImageFailure) {
                          isImageLoading = false;
                          scaffoldSnackBar(context,
                              "There was an error please try again later!");
                          log(state.message);
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: MyColors.green, width: 4),
                              shape: BoxShape.circle),
                          child: ModalProgressHUD(
                            inAsyncCall: isLoading,
                            child: InkWell(
                              onTap: pickImage,
                              child: isImageLoading == true
                                  ? const CircleAvatar(
                                      backgroundColor: MyColors.green2,
                                      radius: 35,
                                      child: CircularProgressIndicator(
                                        color: MyColors.green,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 35,
                                      backgroundColor: MyColors.green2,
                                      backgroundImage: imageUrl != null
                                          ? FileImage(File(imageUrl!))
                                          : user.photoURL != null
                                              ? FileImage(File(user.photoURL!))
                                              : null,
                                      child: imageUrl == null &&
                                              user.photoURL == null
                                          ? SizedBox(
                                              child: Text(
                                                user.displayName
                                                    .toString()
                                                    .toUpperCase()[0],
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: MyColors.white,
                                                    fontSize: 32),
                                              ),
                                            )
                                          : null, // Replace with your default avatar image
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Column(
                      children: [
                        const Gap(8),
                        Text(user.displayName ?? "Guest",
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.green))),
                        const Gap(2),
                        Text(user.email.toString(),
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(
                              fontSize: 14,
                            )))
                      ],
                    ),
                  ),
                  Positioned(
                    top: 270,
                    child: Column(
                      children: [
                        CustomProfileCardButton(
                          content: user.displayName ?? "Guest",
                          onTap: () {},
                          leadingImage: MyImages.userAdd,
                          trailingImage: MyImages.edit,
                        ),
                        CustomProfileCardButton(
                          content: user.email.toString(),
                          scale: 2,
                          onTap: () {},
                          leadingImage: MyImages.email,
                          trailingImage: MyImages.edit,
                        ),
                        CustomProfileCardButton(
                          content: "Health Information",
                          scale: 2,
                          onTap: () {},
                          leadingImage: MyImages.task,
                          trailingImage: MyImages.arrowDown,
                        ),
                        CustomProfileCardButton(
                          content: "Privacy",
                          scale: 2,
                          onTap: () {},
                          leadingImage: MyImages.securityCard,
                          trailingImage: MyImages.arrowDown,
                        ),
                        CustomProfileCardButton(
                          content: "Setting",
                          scale: 2,
                          onTap: () {},
                          leadingImage: MyImages.setting,
                          trailingImage: MyImages.arrowDown,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                          height: 60,
                          onPressed: logOut,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                MyImages.logOut,
                                scale: 4.2,
                                color: MyColors.white,
                              ),
                              const SizedBox(width: 10),
                              Text("Logout",
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                    color: MyColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  )))
                            ],
                          ),
                          color: MyColors.black)),
                  Positioned(
                      top: 93,
                      right: 112,
                      child: IconButton(
                          onPressed: pickImage,
                          icon: const CircleAvatar(
                            radius: 12,
                            backgroundColor: MyColors.green2,
                            backgroundImage: AssetImage(MyImages.add),
                          ))),
                ],
              )
            ],
          )),
    );
  }
}