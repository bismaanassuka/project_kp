import 'package:Webcare/theme/colors.dart';
import 'package:flutter/material.dart';

import '../theme/text_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_date_picker.dart'; // Import the custom date picker

class AddTransScreen extends StatefulWidget {
  @override
  _AddTransScreenState createState() => _AddTransScreenState();
}

class _AddTransScreenState extends State<AddTransScreen> {
  bool isIncome = true;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ADD TRANSACTION', style: appBarText),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(160, 60),
                              backgroundColor:
                              isIncome ? tertiaryColor : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isIncome = true;
                              });
                            },
                            child: Text('Pemasukkan',
                                style: primaryText.copyWith(
                                    color: isIncome ? primaryColor : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(160, 60),
                              backgroundColor:
                              !isIncome ? tertiaryColor : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isIncome = false;
                              });
                            },
                            child: Text('Pengeluaran',
                                style: primaryText.copyWith(
                                    color: !isIncome ? primaryColor : Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Judul',
                        hintText: 'Masukkan judul transaksi',
                        errorText: _titleController.text.isEmpty
                            ? 'Judul wajib diisi'
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: 'Nominal',
                        prefixText: 'Rp ',
                        hintText: 'Masukkan nominal transaksi',
                        errorText: _amountController.text.isEmpty
                            ? 'Nominal wajib diisi'
                            : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Keterangan',
                        hintText: 'Masukkan keterangan',
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showCustomDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate)
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Tanggal',
                            hintText: 'Pilih tanggal',
                            errorText: _selectedDate == null
                                ? 'Tanggal wajib diisi'
                                : null,
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: _selectedDate == null
                                ? ''
                                : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 90),
                    CustomButton(
                        buttonText: 'SIMPAN',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Perform save operation
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Transaksi disimpan')),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
