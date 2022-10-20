import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:data_order_thriftshop/db/database_instance.dart';
import 'package:data_order_thriftshop/models/transaksi_model.dart';

class UpdateScreen extends StatefulWidget {
  final TransaksiModel transaksiMmodel;
  const UpdateScreen({Key? key, required this.transaksiMmodel})
      : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameBarangController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController totalHargaController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    databaseInstance.database();
    nameController.text = widget.transaksiMmodel.name!;
    nameBarangController.text = widget.transaksiMmodel.barang!;
    totalController.text = widget.transaksiMmodel.total!.toString();
    totalHargaController.text = widget.transaksiMmodel.totalHarga!.toString();
    _value = widget.transaksiMmodel.type!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
        backgroundColor: Color(0xFFd78e28),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Nama Pelanggan"),
            TextField(
              controller: nameController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Nama Barang"),
            TextField(
              controller: nameBarangController,
            ),
            SizedBox(
              height: 20,
            ),
            Text("Ukuran"),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: Text("S"),
                    leading: Radio(
                        groupValue: _value,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: Text("M"),
                    leading: Radio(
                        groupValue: _value,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: Text("L"),
                    leading: Radio(
                        groupValue: _value,
                        value: 3,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    minLeadingWidth: 0,
                    title: Text("XL"),
                    leading: Radio(
                        groupValue: _value,
                        value: 4,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                          });
                        }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Total Pesanan"),
            TextField(
              controller: totalController,
            ),
            SizedBox(
              height: 30,
            ),
            Text("Total Harga"),
            TextField(
              controller: totalHargaController,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  await databaseInstance.update(widget.transaksiMmodel.id!, {
                    'name': nameController.text,
                    'barang': nameBarangController.text,
                    'type': _value,
                    'total': totalController.text,
                    'totalHarga': totalHargaController.text,
                    'updated_at': DateTime.now().toString(),
                  });
                  Navigator.pop(context);
                },
                child: Text("Update")),
          ],
        ),
      )),
    );
  }
}
