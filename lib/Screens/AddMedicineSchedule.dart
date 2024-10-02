import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../ApiPath/Api.dart';
import '../Helper/AppBtn.dart';
import '../Helper/CustomText.dart';
import '../Helper/session.dart';
import '../Medicine/NewMedicine.dart';
import '../Model/MedicineRecord/Get_medicine_model.dart';
import '../Model/MedicineRecord/Get_single_data_medicine_model.dart';
import '../Model/MilkRecord/milk_filtter_model.dart';
import '../Model/animal_cat_model_response.dart';
import '../Scanner/scanner_view.dart';
import '../Utils/Colors.dart';
import 'package:http/http.dart' as http;

import '../helper/appbar.dart';

class AddMedicineSchedule extends StatefulWidget {
  const AddMedicineSchedule({Key? key}) : super(key: key);

  @override
  State<AddMedicineSchedule> createState() => _AddMedicineScheduleState();
}

class _AddMedicineScheduleState extends State<AddMedicineSchedule> {
  @override

  final _formKey = GlobalKey<FormState>();
  final _tagId = TextEditingController();
  final ageCtr = TextEditingController();
  final _toDays = TextEditingController();
  final _fromDays = TextEditingController();
  // final toDateCtr = TextEditingController();
  // final fromDateCtr = TextEditingController();


  String? Schedule;
  String? Disease;
  String? Medicine;
  String? Period;
  String? Time;
  String? born;


  String? catValueNew ;
  List<String> catValueitems = ['Kids','Grower','Empty','Matted','Pregnant','Motherhood'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animalCatApi();
    getMedicineListApi();
    getAnimalFilterApi("");
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(text: getTranslated(context, "ADD_MEDICINE_SCHEDULE"), isTrue: true, context: context),
      body: SingleChildScrollView(
        child:Form(
          key: _formKey,
          child:Padding(padding: EdgeInsets.all(15),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${getTranslated(context, "SCHEDULE")}',style: TextStyle(color: colors.black54),),
                          SizedBox(height: 5,),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                              height: 55,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: colors.whiteTemp
                              ),

                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  //dropdownMaxHeight: 300,
                                  hint: Text(getTranslated(context, "SCHEDULE"),
                                    style: TextStyle(
                                        color: colors.black54,fontWeight: FontWeight.normal,fontSize: 14
                                    ),),
                                  // dropdownColor: colors.primary,
                                  value: Schedule,
                                  icon:  const Padding(
                                    padding: EdgeInsets.only(bottom: 0,left: 10),
                                    child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.black54,size: 30,),
                                  ),
                                  // elevation: 16,
                                  style:  TextStyle(color: colors.black54,fontWeight: FontWeight.bold),
                                  underline: Container(
                                    // height: 2,
                                    color:  colors.whiteTemp,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      Schedule = value!;

                                    });
                                  },
                                  items: ['Individual','Status']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,

                                      child:
                                      Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                                    );

                                  }).toList(),

                                ),

                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(width: 5,),
                   // getViewOnSelectedValue(),
                  ],
                ),
               SizedBox(height: 15,),
                getViewOnSelectedValue(),
                SizedBox(height: 15,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(' Tag ID:f002',style: TextStyle(fontSize:12),),
                //     Text('Breed:Sirohi',style: TextStyle(fontSize:12)),
                //     Text('Age:4 (Month)',style: TextStyle(fontSize:12)),
                //     Text('Weight: 35 kg ',style: TextStyle(fontSize:12)),
                //   ],
                // ),
                milkFiltterModel?.data?.weight == null ? Center(child: Text("No record found!!!")):   Card(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${getTranslated(context, "TAG_ID" )}" ": ",
                                  ),
                                  Text(
                                    "${milkFiltterModel!.data!.tagId}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colors.textColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${getTranslated(context, "BREED")}"": ",),
                                  Text(
                                    "${milkFiltterModel!.data!.breed}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colors.textColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${getTranslated(context, "AGE")}"": ",),
                                  Text(
                                    "${milkFiltterModel!.data!.age}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colors.textColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${getTranslated(context, "WEIGHT")}"": ",),
                                  Text(
                                    "${milkFiltterModel!.data!.weight}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colors.textColor,
                                        fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )

                ),
                SizedBox(height: 15,),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "DISEASE"),
                            style: TextStyle(color: colors.blacktextColor),
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              width: 152,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<MedicineDate>(
                                  hint:  Text(getTranslated(context, "DISEASE"),
                                    style: TextStyle(
                                        color: colors.black54,fontWeight: FontWeight.w500,fontSize:12
                                    ),),
                                  value: medicineData,
                                  icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:colors.black54,size: 25,),
                                  style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                  underline: Padding(
                                    padding: const EdgeInsets.only(left: 0,right: 0),
                                    child: Container(

                                      // height: 2,
                                      color:  colors.whiteTemp,
                                    ),
                                  ),
                                  onChanged: (MedicineDate? value) {
                                    setState(() {
                                      medicineData = value!;
                                      medicineId =  medicineData?.medicineId;


                                      //animalCountApi(animalCat!.id);
                                    });
                                  },
                                  items: getMedicineModel?.data?.map((items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Text(items.medicineName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                                                )),
                                          ),

                                        ],
                                      ),
                                    );
                                  })
                                      .toList(),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "MEDICINE"),
                            style: TextStyle(color: colors.blacktextColor),
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              width: 150,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<MedicineDate>(
                                  hint:  Text(getTranslated(context, "MEDICINE_NAME"),
                                    style: TextStyle(
                                        color: colors.black54,fontWeight: FontWeight.w500,fontSize:12
                                    ),),
                                  value: medicineData,
                                  icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:colors.black54,size: 25,),
                                  style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                  underline: Padding(
                                    padding: const EdgeInsets.only(left: 0,right: 0),
                                    child: Container(

                                      // height: 2,
                                      color:  colors.whiteTemp,
                                    ),
                                  ),
                                  onChanged: (MedicineDate? value) {
                                    setState(() {
                                      medicineData = value!;
                                      medicineId =  medicineData?.medicineId;


                                      //animalCountApi(animalCat!.id);
                                    });
                                  },
                                  items: getMedicineModel?.data?.map((items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child:  Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 0),
                                                  child: Text(items.medicineName.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                                                )),
                                          ),

                                        ],
                                      ),
                                    );
                                  })
                                      .toList(),
                                ),

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       getTranslated(context, "CATEGORIES"),
                    //       style: TextStyle(color: colors.blacktextColor),
                    //     ),
                    //     Card(
                    //       elevation: 3,
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButton2<AnimalCatList>(
                    //           hint:  Text(getTranslated(context, "SELECT_CATE"),
                    //             style: TextStyle(
                    //                 color: colors.black54,fontWeight: FontWeight.w500,fontSize:12
                    //             ),),
                    //           value: animalCat,
                    //           icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:colors.black54,size: 25,),
                    //           style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                    //           underline: Padding(
                    //             padding: const EdgeInsets.only(left: 0,right: 0),
                    //             child: Container(
                    //
                    //               // height: 2,
                    //               color:  colors.whiteTemp,
                    //             ),
                    //           ),
                    //           onChanged: (AnimalCatList? value) {
                    //             setState(() {
                    //               animalCat = value!;
                    //               catId =  animalCat?.id;
                    //
                    //
                    //               //animalCountApi(animalCat!.id);
                    //             });
                    //           },
                    //           items: animalCatResponse?.data?.map((items) {
                    //             return DropdownMenuItem(
                    //               value: items,
                    //               child:  Column(
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 children: [
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(top: 2),
                    //                     child: Container(
                    //
                    //                         child: Padding(
                    //                           padding: const EdgeInsets.only(top: 0),
                    //                           child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
                    //                         )),
                    //                   ),
                    //
                    //                 ],
                    //               ),
                    //             );
                    //           })
                    //               .toList(),
                    //         ),
                    //
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),


                SizedBox(height: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${getTranslated(context, "PEROID")}',style: TextStyle(color: colors.black54),),
                        SizedBox(height: 5,),
                        Card(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: colors.whiteTemp,
                              borderRadius: BorderRadius.circular(10)
                            ),

                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                //dropdownMaxHeight: 300,
                                hint: Text("Select",
                                  style: TextStyle(
                                      color: colors.black54,fontWeight: FontWeight.normal,fontSize: 14
                                  ),),
                                // dropdownColor: colors.primary,
                                value: Period,
                                icon:  const Padding(
                                  padding: EdgeInsets.only(bottom: 0,left: 10),
                                  child: Icon(Icons.keyboard_arrow_down_rounded,  color: colors.black54,size: 30,),
                                ),
                                // elevation: 16,
                                style:  TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                underline: Container(
                                  // height: 2,
                                  color:  colors.whiteTemp,
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    Period = value!;

                                  });
                                },
                                items: ['One Time','Continuous']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,

                                    child:
                                    Text(value,style: const TextStyle(color: colors.black54,fontWeight: FontWeight.normal),),
                                  );

                                }).toList(),

                              ),

                            ),
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 15,),
                  getViewBasedOnSelectedValue(),
                  ],
                ),

                SizedBox(height: 15,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Custom_Text(text: '${getTranslated(context, "UNIT")}'),
                      //     Card(
                      //       child: Container(
                      //         width: size.width / 2.7,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         child: DropdownButtonHideUnderline(
                      //           child: DropdownButton2<String>(
                      //             isExpanded: true,
                      //             hint: const Padding(
                      //               padding: EdgeInsets.only(bottom: 0),
                      //               child: Text(
                      //                 "ml",
                      //                 style: TextStyle(
                      //                     color: colors.blackTemp,
                      //                     fontWeight: FontWeight.normal,
                      //                     fontSize: 14),
                      //               ),
                      //             ),
                      //             // dropdownColor: colors.primary,
                      //             value: unitVNew,
                      //             icon: const Padding(
                      //               padding: EdgeInsets.only(right: 5),
                      //               child: Icon(
                      //                 Icons.keyboard_arrow_down_rounded,
                      //                 color: colors.black54,
                      //                 size: 30,
                      //               ),
                      //             ),
                      //             // elevation: 16,
                      //             style: TextStyle(
                      //                 color: colors.secondary,
                      //                 fontWeight: FontWeight.bold),
                      //             underline: Padding(
                      //               padding: const EdgeInsets.only(left: 0, right: 0),
                      //               child: Container(
                      //                 // height: 2,
                      //                 color: colors.whiteTemp,
                      //               ),
                      //             ),
                      //             onChanged: (String? value) {
                      //               // This is called when the user selects an item.
                      //               setState(() {
                      //                 unitVNew = value!;
                      //               });
                      //             },
                      //
                      //             items: unitType
                      //                 .map<DropdownMenuItem<String>>((String value) {
                      //               return DropdownMenuItem<String>(
                      //                 value: value,
                      //                 child: Column(
                      //                   mainAxisSize: MainAxisSize.min,
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   mainAxisAlignment: MainAxisAlignment.center,
                      //                   children: [
                      //                     Padding(
                      //                       padding: const EdgeInsets.all(4.0),
                      //                       child: Text(
                      //                         value,
                      //                         style: const TextStyle(
                      //                             color: colors.textColor,
                      //                             fontWeight: FontWeight.normal),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               );
                      //             }).toList(),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                     Container(
                       width: 270,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Custom_Text(text: '${getTranslated(context, "TIME")}'),
                           Card(
                               elevation: 1,
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                               child:
                               Container(
                                 // color: Colors.white,
                                 child: DropdownButton2<String>(
                                   isExpanded: true,
                                   value:Time,
                                   //elevation: 5,
                                   style: TextStyle(color: Colors.black87),

                                   items: <String>[
                                     'Morning',
                                     'Evening',
                                     'Mor & Evening',
                                   ].map<DropdownMenuItem<String>>((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value),
                                     );
                                   }).toList(),
                                   onChanged: (String? value)  {
                                     setState(() {
                                       Time= value!;
                                     });
                                   },
                                   icon: Icon(Icons.keyboard_arrow_down_sharp),
                                   underline: Container(  // Use a container with zero height to remove the underline
                                     height: 0,
                                     color: Colors.white,
                                   ),
                                 ),
                               )),
                         ],
                       ),
                     ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(top: 15,right: 5),
                        child: Container(
                          width: 52,
                          height: 49,
                          child: InkWell(
                            onTap: (){
                              if(Period == null) {

                                Fluttertoast.showToast(msg: "Please Fill From Day, And To Days ");
                              }else{
                                setState(() {
                                  medicineList.add(medicineData?.medicineName.toString());
                                  periodList.add(Period.toString());
                                  todayList.add(_toDays.text);
                                  fromDayList.add(_fromDays.text);
                                  timeList.add(Time.toString());

                                  Map<String, String> newCat = {
                                    "medicine": "${medicineData?.medicineName.toString()}",
                                    "period": "${Period}",
                                    "today": "${_toDays.text}",
                                    "form": "${_fromDays.text}",
                                    "time": "${Time.toString()}",
                                  };
                                  addTableList.add(newCat);

                                     _fromDays.clear();
                                     _tagId.clear();
                                     //pregnantList.clear();
                                    _toDays.clear();

                                animalCat?.name == null;
                                 unitVNew== null;
                                });

                              }
                            },
                            child: Container(
                              height: 45,
                              width: size.width/9,
                              child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: colors.white70,
                                    size: 30,
                                  )),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: colors.darkBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                SizedBox(height: 15,),


                addTableList.isEmpty ? SizedBox.shrink():
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Card(
                        child: Container(
                          child: Column(
                            children: [
                              DataTable(
                                columns: [
                                  DataColumn(label: Text(getTranslated(context, "MEDICINE"))),
                                  DataColumn(label: Text(getTranslated(context, "PEROID"))),
                                  DataColumn(label: Text(getTranslated(context, "FROM"))),
                                  DataColumn(label: Text(getTranslated(context, "TO_DAYS"))),
                                  DataColumn(label: Text(getTranslated(context, "TIME"))),


                                ],
                                rows: addTableList.map((data) => DataRow(
                                  cells: [
                                    DataCell(Text(data["medicine"])),
                                    DataCell(Text(data["period"])),
                                     DataCell(Text(data["today"])),
                                    fromDayList.isEmpty?DataCell(Text("")):DataCell(Text(data["form"])),
                                    DataCell(Text(data["time"])),



                                  ],
                                )).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20,),
                Btn(
                  onPress: (){
                    addMedicineScheduleApi();
                    // if(_tagId.text.isEmpty){
                    //
                    // }else if(catValueNew ==  null){
                    //   Fluttertoast.showToast(msg: "Please select medicine");
                    // }else if(weightValueNew == null){
                    //   Fluttertoast.showToast(msg: "Please select disease");
                    // // }else if(addTableList == null ){
                    // //   Fluttertoast.showToast(msg: "Please select medicine Schedule");
                    // }else if(qtyValueNew == null ){
                    //   Fluttertoast.showToast(msg: "Please select qty");
                    // }else if(unitVNew == null ){
                    //   Fluttertoast.showToast(msg: "Please select unit");
                    // }
                    // else{
                    //   Fluttertoast.showToast(msg: "Please select all field..");
                    // }
                  },

                  height:45,width: MediaQuery.of(context).size.width,
                  title: getTranslated(context, "SAVE"),
                ),


              ],
            ) ,
          ),

        ),
      ),
    );
  }
  String? selectedToDate;
  String? selectedFromDate;

  Widget getViewBasedOnSelectedValue(){
    switch (Period) {
      case 'One Time':
        return onTimeView();
      case 'Continuous':
        return allTimeView();
      default:
        return Container();
    }

}
  Widget getViewOnSelectedValue() {
    switch (Schedule) {
      case 'Individual':
        return onScheduleView();
      case 'Status':
        return onStatusView();
      default:
        return Container();
    }
  }
  onScheduleView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, "TAG_ID"),
          style: TextStyle(color: colors.blacktextColor),
        ),
        SizedBox(height: 5,),
        Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: TextFormField(
            controller: _tagId,
            onChanged: (v){
              getAnimalFilterApi(v);
            },


            // controller: supplementController,
            decoration: InputDecoration(
                suffixIcon:InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanPay())).then((v){
                      if(v != null){
                        getAnimalFilterApi(v);
                      }
                    });;
                  },
                  child: Container(
                    height: 10,
                    width: 10,
                    padding: EdgeInsets.all(10),
                    child: Image.asset("assets/images/Group 72309.png"),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 10,top: 15),
                border: InputBorder.none),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter 2nd onwards';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
  onStatusView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslated(context, "STATUS"),
          style: TextStyle(color: colors.blacktextColor),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 3, bottom: 3),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint:  Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: Text(getTranslated(context, "SELECTED_CATEGORY"),
                    style: TextStyle(
                        color: colors.blackTemp,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                // dropdownColor: colors.primary,
                value: catValueNew,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.black54,
                    size: 30,
                  ),
                ),
                // elevation: 16,
                style: TextStyle(
                    color: colors.secondary,
                    fontWeight: FontWeight.bold),
                underline: Padding(
                  padding: const EdgeInsets.only(
                      left: 0, right: 0),
                  child: Container(
                    // height: 2,
                    color: colors.whiteTemp,
                  ),
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    catValueNew = value!;
                  });
                },

                items: catValueitems.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.all(4.0),
                              child: Text(
                                value,
                                style: const TextStyle(
                                    color: colors.textColor,
                                    fontWeight:
                                    FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                ).toList(),
              ),
            ),
          ),
        ),

      ],
    );

  }
  bool isLoading = true;
  Future<void> addMedicineScheduleApi() async {
    setState(() {
      isLoading = true;
    });

    var prms = {};



    // var parameter = jsonEncode({
    //   'category':catNewList.toString(),
    //   'weight':bodyList.toString(),
    //   'dose':doessList.toString(),
    //   'unit':unitList.toString(),
    //   'direction':directionList.toString(),
    //   'safe_for_pregnant':pregnantList.toString(),
    //   'animal_id':animalIdList.toString(),
    //   'medicine_id':medicineList.toString(),
    //   'period':periodList.toString(),
    //   'date':todayList.toString(),
    //   'day':fromDayList.toString(),
    //   'time':timeList.toString()
    // });
    var parameter = jsonEncode({
      // "medicine_id": extractNumbers(medicineList.toString(),),
      "medicine_name": extractStrings(medicineList.toString(),),
      "period": extractStrings(periodList.toString(),),
      "date": extractStrings(todayList.toString()),
      "day": extractNumbers(fromDayList.toString()),
      "time": extractStrings(timeList.toString()),
    });
    prms ['shDUL'] = parameter ;
    prms["medicine_id"]  = "5";
    var response = await http.post(Uri.parse(ApiService.aadMedicineSchedule), body:prms);
    Fluttertoast.showToast(msg: "Add Medicine Schedule Successfully");
    Navigator.pop(context);
    print('____response_________${prms}______');
  }

  List<String> extractStrings(String input) {
    List<dynamic> list = extractValues(input);
    return list.map((value) => value.toString()).toList();
  }

  List<String> extractNumbers(String input) {
    List<dynamic> list = extractValues(input);
    return list.map((value) => value.toString()).toList();
  }

  List<bool> extractBooleans(String input) {
    List<dynamic> list = extractValues(input);
    return list.map((value) => value.toString().toUpperCase() == "YES").toList();
  }

  List<dynamic> extractValues(String input) {
    List<String> values = input.replaceAll(RegExp(r'[\[\]\s]'), '').split(',');
    return values.map((value) => value.trim()).toList();
  }
  GetSingleDataMedicineModel? milkFiltterModel;
  getAnimalFilterApi(String? tagId) async {
    var parameter = {
      'tag_id':tagId
    };
    apiBaseHelper.postAPICall(Uri.parse(ApiService.getMedicineSingleData), parameter).then((getData) {
      String msg = getData['message'];
      setState(() {
        milkFiltterModel = GetSingleDataMedicineModel.fromJson(getData);
        Fluttertoast.showToast(msg: "${msg}");
      });

    });
  }

  onTimeView(){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Custom_Text(text: '${getTranslated(context, "FROM_DAYS")}'),
            SizedBox(height: 8,),
            GestureDetector(
                onTap: () async {
                  DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2024));
                  if (datePicked != null) {
                    print(
                        'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                    String formettedDate =
                    DateFormat('dd-MM-yyyy').format(datePicked);
                    setState(() {
                      selectedFromDate = formettedDate;

                    });
                  }
                },
                child: Card(
                  elevation: 1,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),

                    child:  TextFormField(
                      readOnly: true,
                      onTap:
                          () async{
                        DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2024));
                        if (datePicked != null) {
                          print(
                              'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                          String formettedDate =
                          DateFormat('dd-MM-yyyy').format(datePicked);
                          setState(() {
                            selectedFromDate = formettedDate;
                            _fromDays.text = formettedDate;
                            // getDateApi(selectedBirthDate!);
                          });
                        }
                      },
                      controller: _fromDays,
                      decoration: InputDecoration(
                        border:InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'dd-mm-yyyy',
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value){
                        if(value==null||value.isEmpty)
                          return "Please enter birth date";
                        return null;
                      },
                    ),
                  ),
                )
            ),

          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Custom_Text(text: '${getTranslated(context, "TO_DAYS")}'),
            SizedBox(height: 8,),
            GestureDetector(
                onTap: () async {
                  DateTime? datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2024));
                  if (datePicked != null) {
                    print(
                        'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                    String formettedDate =
                    DateFormat('dd-MM-yyyy').format(datePicked);
                    setState(() {
                      selectedToDate = formettedDate;

                    });
                  }
                },
                child: Card(
                  elevation: 1,
                  child: Container(
                    width: 150,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child:  TextFormField(
                      readOnly: true,
                      onTap:
                          () async{
                        DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2024));
                        if (datePicked != null) {
                          print(
                              'Date Selected:${datePicked.day}-${datePicked.month}-${datePicked.year}');
                          String formettedDate =
                          DateFormat('dd-MM-yyyy').format(datePicked);
                          setState(() {
                            selectedToDate = formettedDate;
                            _toDays.text = formettedDate;
                            // getDateApi(selectedBirthDate!);
                          });
                        }
                      },
                      controller: _toDays,
                      decoration: InputDecoration(
                        border:InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'dd-mm-yyyy',
                        // border: OutlineInputBorder(
                        //     borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value){
                        if(value==null||value.isEmpty)
                          return "Please enter birth date";
                        return null;
                      },
                    ),
                  ),
                )
            ),

          ],
        ),
      ],
    );
  }
  allTimeView(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Custom_Text(text: '${getTranslated(context, "FROM_DAYS")}'),
            SizedBox(height: 5,),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              elevation: 1,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child:  TextFormField(
                  controller: _fromDays,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty)
                      return "Please enter age";
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Custom_Text(text: '${getTranslated(context, "TO_DAYS")}'),
            SizedBox(height: 5,),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
              ),
              elevation: 1,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),

                child:  TextFormField(
                  controller: _toDays,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border:InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (value){
                    if(value==null||value.isEmpty)
                      return "Please enter age";
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );

  }
  String? catId;
  AnimalCatList? animalCat;
  AnimalCatResponse? animalCatResponse;
  Future<void> animalCatApi() async {
    apiBaseHelper.getAPICall(Uri.parse(ApiService.animalCategory)).then((getData) {
      bool error = getData ['error'];
      if(!error){
        animalCatResponse = AnimalCatResponse.fromJson(getData);
        setState(() {

        });
      }else {

      }

    });

  }



  String? medicineId;
  MedicineDate? medicineData;
  GetMedicineModel? getMedicineModel;
  Future<void> getMedicineListApi() async {
    apiBaseHelper.getAPICall(Uri.parse(ApiService.getMedicineList)).then((getData) {
      bool error = getData ['error'];
      print('___getData_______${getData}_________');
      setState(() {
        getMedicineModel = GetMedicineModel.fromJson(getData);
      });

      // if(!error){
      //
      //   setState(() {
      //
      //   });
      // }else {
      //
      // }

    });

  }

  List medicineList=[];
  List periodList=[];
  List todayList=[];
  List fromDayList=[];
  List timeList=[];


List addTableList=[];
}