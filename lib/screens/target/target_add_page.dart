import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:walleto/data/hive/saving_target_boxes.dart';
import 'package:walleto/data/model/category.dart';
import 'package:walleto/data/model/saving_target.dart';
import 'package:walleto/screens/home_page.dart';
import 'package:walleto/screens/widgets/custom_text_field.dart';
import 'package:walleto/screens/widgets/custome_drop_down.dart';
import 'package:walleto/shared/theme.dart';

class TargetAddPage extends StatefulWidget {
  static const routeName = "/target_add_page";

  @override
  State<TargetAddPage> createState() => _TargetAddPageState();
}

class _TargetAddPageState extends State<TargetAddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _targetNameController = TextEditingController();
  TextEditingController _nominalController = TextEditingController();
  TextEditingController _periodController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String? _selectedPriorityLevel;
  String? _selectedDurationType;
  @override
  Widget build(BuildContext context) {
    final Category argument =
        ModalRoute.of(context)!.settings.arguments as Category;
    Widget _buildContent() {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: "Nama Target",
                      hintText: "Masukan Nama Target",
                      keyboardType: TextInputType.text,
                      controller: _targetNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama tidak boleh kosong';
                        } else if (value.length > 15) {
                          return 'Nama target tidak boleh lebih dari 15 karakter';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      labelText: "Nominal",
                      hintText: "Masukan Nominal",
                      keyboardType: TextInputType.number,
                      controller: _nominalController,
                      inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nominal tidak boleh kosong';
                        } else if (int.parse(value) < 1000) {
                          return 'Nominal Minimal Rp. 1000';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: CustomTextField(
                            labelText: "Waktu",
                            hintText: "Masukan Waktu",
                            keyboardType: TextInputType.number,
                            controller: _periodController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Period tidak boleh kosong';
                              } else if (int.parse(value) == 0) {
                                return 'Period tidak boleh 0';
                              } else if (_selectedDurationType == "Hari" &&
                                  int.parse(value) >= 100) {
                                return 'Pilih Ke Pekan';
                              } else if (_selectedDurationType == "Pekan" &&
                                  int.parse(value) >= 48) {
                                return 'Pilih Bulan';
                              } else if (_selectedDurationType == "Bulan" &&
                                  int.parse(value) >= 12) {
                                return 'Pilih Ke Tahun';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          flex: 1,
                          child: CustomDropdownField(
                            value: _selectedDurationType,
                            labelName: "Jangka",
                            hintText: "Pilih Jangka",
                            options: const [
                              "Hari",
                              "Pekan",
                              "Bulan",
                              "Tahun",
                            ],
                            onChanged: (text) {
                              setState(() {
                                _selectedDurationType = text!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomDropdownField(
                      labelName: "Tingkat Prioritas",
                      value: _selectedPriorityLevel,
                      hintText: "Pilih Tingkat Prioritas",
                      options: const [
                        "Rendah",
                        "Sedang",
                        "Tinggi",
                      ],
                      onChanged: (text) {
                        setState(() {
                          _selectedPriorityLevel = text!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomTextField(
                      labelText: "Deskripsi",
                      hintText: "Masukan Deskripsi",
                      keyboardType: TextInputType.text,
                      controller: _descriptionController,
                      maxLines: 4,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Deskripsi tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 24.0,
                        ),
                        child: ElevatedButton(
                          child: Text(
                            'Simpan',
                            style: whiteTextStyle.copyWith(
                              fontSize: 18,
                              fontWeight: medium,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kBlueColor,
                            minimumSize: const Size.fromHeight(40),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 14.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SavingTarget target = SavingTarget(
                                nameTarget: _targetNameController.text,
                                nominal: int.parse(_nominalController.text),
                                period: int.parse(_periodController.text),
                                durationType: _selectedDurationType!,
                                currentMoney: 0,
                                category: argument,
                                priority: _selectedPriorityLevel!,
                                decription: _descriptionController.text,
                                createdAt:
                                    DateTime.now().millisecondsSinceEpoch,
                                foreign:
                                    "SVG-" + Random().nextInt(1000).toString(),
                              );
                              SavingTargetBoxes.storeSavingTarget(target);
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomePage.routeName,
                                (Route<dynamic> route) => false,
                                arguments: true,
                              );
                            } else {
                              const SpinKitFadingCircle(
                                  color: kBlueColor, size: 30.0);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: kBlueColor,
          elevation: 0.0,
          titleSpacing: 24.0,
          centerTitle: true,
          toolbarHeight: 80,
          title: Text(
            "Target",
            style: whiteTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
            ),
          ),
        ),
      ),
      body: SafeArea(child: _buildContent()),
    );
  }
}
