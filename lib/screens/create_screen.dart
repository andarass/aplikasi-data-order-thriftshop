import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:data_order_thriftshop/db/database_instance.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
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
                  int idInsert = await databaseInstance.insert({
                    'name': nameController.text,
                    'barang': nameBarangController.text,
                    'type': _value,
                    'total': totalController.text,
                    'totalHarga': totalHargaController.text,
                    'created_at': DateTime.now().toString(),
                    'updated_at': DateTime.now().toString(),
                  });
                  print("sudah masuk : " + idInsert.toString());
                  Navigator.pop(context);
                },
                child: Text("Simpan")),
          ],
        ),
      )),
    );
  }
}
