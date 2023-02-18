import 'package:freezed_annotation/freezed_annotation.dart';

part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
class Doctor with _$Doctor {
  factory Doctor({required String name, required String uid, required String userName}) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}
