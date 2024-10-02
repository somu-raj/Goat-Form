import 'package:flutter/material.dart';
import 'package:madhu_farma/Helper/session.dart';

import '../ApiPath/Api.dart';
import '../Helper/Appbar.dart';
import '../Model/MedicineRecord/Get_medicine_model.dart';
import '../Utils/Colors.dart';

class DetailsMedicineRecord extends StatefulWidget {
  String? mId;

  DetailsMedicineRecord({Key? key, this.mId}) : super(key: key);

  @override
  State<DetailsMedicineRecord> createState() => _DetailsMedicineRecordState();
}

class _DetailsMedicineRecordState extends State<DetailsMedicineRecord> {
  @override
  void initState() {
    // TODO: implement initState
    getMedicineListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: customAppBar(
          context: context,
          text: "Medicine Details",
          isTrue: true,
        ),
        body:

        SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: getMedicineModel == null || getMedicineModel == ""
                    ? Center(child: CircularProgressIndicator())
                    : getMedicineModel!.data![0].shaduleData!.isEmpty ?? false ? Center(child: Text("No Medicine Details")): Container(
                        child: ListView.builder(
                         // separatorBuilder: (context, index) => const Divider(),
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getMedicineModel!.data![0].shaduleData!.length,
                            itemBuilder: (context, index) {
                              return  Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(getTranslated(context, "CATEGORY")),
                                             SizedBox(height: 5,),
                                             Text("${getMedicineModel!.data![0].shaduleData![index].category}")
                                           ],
                                         ),
                                         Column(
                                           children: [
                                             Text(getTranslated(context, "BODY_WEIGHT")),
                                             SizedBox(height: 5,),
                                             Text("${getMedicineModel!.data![0].shaduleData![index].bodyWeight}")
                                           ],
                                         ),
                                         Column(
                                           children: [
                                             Text(getTranslated(context, "DOSE")),
                                             SizedBox(height: 5,),
                                             Text("${getMedicineModel!.data![0].shaduleData![index].dose}")
                                           ],
                                         ),
                                         Column(
                                           children: [
                                             Text(getTranslated(context, "UNIT")),
                                             SizedBox(height: 5,),
                                             Text("${getMedicineModel!.data![0].shaduleData![index].medicineUnit}")
                                           ],
                                         ),
                                       ],
                                     )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )))

    );
  }

  GetMedicineModel? getMedicineModel;

  getMedicineListApi() async {
    var parameter = {'medicine_id': widget.mId};
    print("------Surendra-------${parameter}----------");
    apiBaseHelper
        .postAPICall(Uri.parse(ApiService.getMedicineList), parameter)
        .then((getData) {
      String msg = getData['message'];
      setState(() {
        getMedicineModel = GetMedicineModel.fromJson(getData);
      });
    });
  }
}
