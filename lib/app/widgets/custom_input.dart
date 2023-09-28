import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/app/utils/app_color.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  final bool isDate;
  final bool isNumber;
  final bool isNominal;
  final bool isClickEmpty;
  CustomInput({
    required this.controller,
    required this.label,
    required this.hint,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obsecureText = false,
    this.isDate = false,
    this.suffixIcon,
    this.isNumber = false,
    this.isNominal = false,
    this.isClickEmpty = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: AppColor.secondarySoft,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: widget.margin,
            decoration: BoxDecoration(
              color: (widget.disabled == false)
                  ? Colors.transparent
                  : AppColor.primaryExtraSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              readOnly: widget.disabled,
              obscureText: widget.obsecureText,
              style: TextStyle(fontSize: 14, fontFamily: 'FontLato'),
              maxLines: 1,
              controller: widget.controller,
              keyboardType:
                  widget.isNumber ? TextInputType.number : TextInputType.text,
              onChanged: (text) {
                if (widget.isNumber && widget.isNominal) {
                  final numericText = text.replaceAll(
                      RegExp(r'[^0-9]'), ''); // Menghapus karakter selain angka
                  final formattedText = NumberFormat.currency(
                    symbol: 'Rp ',
                    decimalDigits: 0, // Tidak ada desimal
                    locale: 'id_ID', // Lokal untuk format Rupiah
                  ).format(int.tryParse(numericText) ??
                      0); // Format sebagai angka dan menambahkan 'Rp '

                  // Set teks yang sudah diformat kembali ke controller
                  widget.controller.value = widget.controller.value.copyWith(
                    text: formattedText,
                    selection:
                        TextSelection.collapsed(offset: formattedText.length),
                  );
                }
              },
              onTap: () async {
                if (widget.isDate) {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now(), // Mengatur ke tanggal awal yang sesuai
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    print(
                        pickedDate); // PickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(
                        formattedDate); // Keluaran formatted date menggunakan intl package =>  2021-03-16

                    setState(() {
                      widget.controller.text =
                          formattedDate; //Set output date untuk nilai TextField .
                    });
                  } else {
                    print("Date is not selected");
                  }
                }
                if (widget.isClickEmpty) {
                  setState(() {
                    widget.controller.text = "";
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon ?? SizedBox(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'FontLato',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
