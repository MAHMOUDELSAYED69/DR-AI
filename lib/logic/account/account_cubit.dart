import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/data/model/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  final _auth = FirebaseAuth.instance.currentUser!.email;
  final _firestore = FirebaseFirestore.instance;
  Future<void> getprofileData() async {
    emit(AccountLoading());
    try {
      _firestore.collection('users').doc(_auth).snapshots().listen((event) {
        UserDataModel userDataModel = UserDataModel.fromJson(event.data()!);
        log(userDataModel.name.toString());
        emit(AccountSuccess(userDataModel: userDataModel));
      });
    } on Exception catch (err) {
      emit(AccountFailure(message: err.toString()));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    emit(AccountLogout(message: "Logout successfully"));
  }
}
