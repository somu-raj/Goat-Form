import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:madhu_farma/Helper/CustomButton.dart';
import 'package:madhu_farma/Helper/session.dart';
import 'package:madhu_farma/Medicine/MedicineConsume.dart';


import '../ApiPath/Api.dart';
import '../Helper/Appbar.dart';
import '../Model/MedicineRecord/Get_medicine_model.dart';
import '../Model/MedicineRecord/Get_update_model.dart';
import '../Model/animal_cat_model_response.dart';
import '../Utils/Colors.dart';
import 'package:http/http.dart'as http;


class NewMedicine extends StatefulWidget {
  String ? mId;
  bool? isAdd;
   NewMedicine({Key? key,this.mId,this.isAdd}) : super(key: key);

  @override
  State<NewMedicine> createState() => _NewMedicineState();
}

final _formKey = GlobalKey<FormState>();
String? catValueNew ;

 List<String> catValueitems = [
  'Medicine','Vaccine'
];
String? weightValueNew ;
String? qtyValueNew ;
final List<String> weightQty = ['1', '2', '3','4','1.2','2.5'];


final List<String> weightValueitems = ['Canine Flu', 'Anthrax', 'Botulism','Brucellosis'];
String? typeValueNew;


String? unitVNew;
final List<String> unitType = ['KG', 'Liter', 'No', 'ML', 'G', 'MG'];

String? unitVNew1;
final List<String> unitType1 = ['KG', 'Liter', 'No', 'ML', 'G', 'MG'];

String? male;

class _NewMedicineState extends State<NewMedicine> {
  final medicineIdctr=TextEditingController();
  final medicineNameCtr=TextEditingController();
  final qtyCtr=TextEditingController();
  final selectDeliveryDateCtr=TextEditingController();
  final  doseC=TextEditingController();
  final bodyWeightCtr=TextEditingController();
  final directionCtr=TextEditingController();
  String? selectedDeliveryDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getMedicineListApi();
    animalCatApi();

  }



  GetUpdateModel? getUpdateModel;
  getMedicineListApi() async {
    var parameter = {
      'id':widget.mId.toString()
    };
    apiBaseHelper.postAPICall(Uri.parse(ApiService.getMedicineList), parameter).then((getData) {
      String msg = getData['message'];
      setState(() {
        getUpdateModel = GetUpdateModel.fromJson(getData);
        medicineIdctr.text = "${getUpdateModel?.data?.medicineId}";
        selectDeliveryDateCtr.text = "${getUpdateModel?.data?.expDate}";
        medicineNameCtr.text = "${getUpdateModel?.data?.medicineName}";
        medicineNameCtr.text = "${getUpdateModel?.data?.medicineName}";
        catValueNew = "${getUpdateModel?.data?.medicineType}";
        weightValueNew = "${getUpdateModel?.data?.disease}";
        qtyCtr.text = "${getUpdateModel?.data?.qty}";
        unitVNew1 = "${getUpdateModel?.data?.unit}";

      });

    });
  }



  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Btn(
          onPress: (){
            if(_formKey.currentState!.validate()){
              if(widget.isAdd ==true) {
                updateMedicineApi();
              }else{
                addMedicineApi();
              }
            }else if(catValueNew ==  null){
              Fluttertoast.showToast(msg: "Please select medicine");
            }else if(weightValueNew == null){
              Fluttertoast.showToast(msg: "Please select disease");
              // }else if(addTableList == null ){
              //   Fluttertoast.showToast(msg: "Please select medicine Schedule");
            }else if(qtyValueNew == null ){
              Fluttertoast.showToast(msg: "Please select qty");
            }else if(unitVNew == null ){
              Fluttertoast.showToast(msg: "Please select unit");
            }
            else{
              Fluttertoast.showToast(msg: "Please select all field..");
            }
          },

          height:45,width: MediaQuery.of(context).size.width,
          title: getTranslated(context, "SAVE"),
        ),
      ),
        backgroundColor: colors.grad1Color,
        appBar: customAppBar(
          context: context,
          text: getTranslated(context, "NEW_MEDICINE"),
          // getProperty(context,"NEW_MEDICINE"),
          isTrue: true,

        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            getTranslated(context, "MEDICINE_TYPE"),
                          style: TextStyle(color: colors.blacktextColor),
                        ),
                      ],
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
                                color: colors.secondary,
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
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    getTranslated(context, "MEDICINE_ID"),
                                    style: TextStyle(color: colors.blacktextColor),
                                  ),
                                ],
                              ),
                              Card(
                                child: Container(
                                  height: 55,
                                  child: TextFormField(
                                    controller: medicineIdctr,
                                    decoration: InputDecoration(
                                        suffixIcon: Container(
                                          height: 10,
                                          width: 10,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset("assets/images/Group 72309.png"),
                                        ),
                                        contentPadding: EdgeInsets.only(left: 10,top: 18),
                                        border: InputBorder.none),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter 2nd onwards';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Text(
                                  getTranslated(context, "DISEASE")
                                ,style: TextStyle(color: colors.blacktextColor),),
                              ],
                            ),

                            Card(
                              child: Container(
                                width: size.width / 2.3,
                                // height: size.height / 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            color: colors.blackTemp,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    // dropdownColor: colors.primary,
                                    value: weightValueNew,
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: colors.secondary,
                                        size: 30,
                                      ),
                                    ),
                                    // elevation: 16,
                                    style: TextStyle(
                                        color: colors.secondary,
                                        fontWeight: FontWeight.bold),
                                    underline: Padding(
                                      padding: const EdgeInsets.only(left: 0, right: 0),
                                      child: Container(
                                        // height: 2,
                                        color: colors.whiteTemp,
                                      ),
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        weightValueNew = value!;
                                      });
                                    },

                                    items: weightValueitems
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(4.0),
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: colors.textColor,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Text(
                                  getTranslated(context, "MEDICINE_NAME"),
                                  style: TextStyle(color: colors.blacktextColor),
                                ),
                              ],
                            ),

                            // TextFormCard(
                            //   name:"${getTranslated(context, "MEDICINE_NAME")}" ,
                            //   width: MediaQuery.of(context).size.width/2.3,
                            //   controller: _medicineNameCtr,
                            //   validString:getTranslated(context, "MEDICINE_NAME"),
                            // ),

                            Card(
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child:Container(
                                  width: size.width/2.2,
                                  child: TextFormField(
                                    controller: medicineNameCtr,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.only(left: 7)),
                                    validator: (value){
                                      if(value?.length==null||value!.isEmpty){
                                         return "${getTranslated(context, "MEDICINE_NAME")} ${getTranslated(context, "IS_REQUIRED")}";
                                      }
                                    },
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 5,),
                            Text(getTranslated(context, "EXP_DATE"),style: TextStyle(color: colors.blacktextColor),),
                          ],
                        ),
                        SizedBox(height: 2,),
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
                                  selectedDeliveryDate = formettedDate;

                                });
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              elevation: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                height: 50,
                                width: MediaQuery.of(context).size.width/2.3,

                                child:  TextFormField(
                                  readOnly: true,
                                  onTap: () async{
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
                                        selectedDeliveryDate= formettedDate;
                                        selectDeliveryDateCtr.text =  formettedDate;
                                      });
                                    }
                                  },
                                  controller: selectDeliveryDateCtr,
                                  decoration: InputDecoration(
                                    border:InputBorder.none,
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: 'dd-mm-yyyy',
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(10)),
                                  ),
                                  validator: (value){
                                    if(value==null||value.isEmpty)
                                      return "Please Enter delivery Date";
                                    return null;
                                  },
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated(context, "QTY"),
                                style: TextStyle(color: colors.blacktextColor),

                              ),
                              Card(
                                elevation: 1.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child:Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: qtyCtr,
                                      cursorHeight: 20,
                                      decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.only(left: 7)),
                                      validator: (value){
                                        if(value?.length==null||value!.isEmpty){
                                          return "${getTranslated(context, "QTY")} ${getTranslated(context, "IS_REQUIRED")}";
                                        }
                                      },
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated(context, "UNIT")
                                ,
                                style: TextStyle(
                                    color: colors.blacktextColor),
                              ),
                              Card(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: const Padding(
                                      padding: EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        "",
                                        style: TextStyle(
                                            color: colors.blackTemp,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14),
                                      ),
                                    ),
                                    // dropdownColor: colors.primary,
                                    value: unitVNew1,
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: colors.secondary,
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
                                        unitVNew1 = value!;
                                      });
                                    },

                                    items: unitType
                                        .map<DropdownMenuItem<String>>(
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
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          getTranslated(context, 'ANIMAL_SCHEDULE'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: colors.darkBlue),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          getTranslated(context, "CATEGORIES"),
                          style: TextStyle(color: colors.blacktextColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      //  Custom_Text(text: '${getTranslated(context, "CATEGORIES")}'),
                        SizedBox(height: 8,),
                        Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<AnimalCatList>(
                                hint:  Text(getTranslated(context, "SELECT_CATE"),
                                  style: TextStyle(
                                      color: colors.black54,fontWeight: FontWeight.w500,fontSize:12
                                  ),),
                                value: animalCat,
                                icon:  Icon(Icons.keyboard_arrow_down_rounded,  color:colors.secondary,size: 25,),
                                style:  const TextStyle(color: colors.secondary,fontWeight: FontWeight.bold),
                                underline: Padding(
                                  padding: const EdgeInsets.only(left: 0,right: 0),
                                  child: Container(

                                    // height: 2,
                                    color:  colors.whiteTemp,
                                  ),
                                ),
                                onChanged: (AnimalCatList? value) {
                                  setState(() {
                                    animalCat = value!;
                                    catId =  animalCat?.id;


                                    //animalCountApi(animalCat!.id);
                                  });
                                },
                                items: animalCatResponse?.data?.map((items) {
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
                                                child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:colors.black54),),
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
                    // Card(
                    //   child: Container(
                    //     width: size.width / 2.25,
                    //     height: size.height / 18,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //     child: DropdownButtonHideUnderline(
                    //       child: DropdownButton2<String>(
                    //         isExpanded: true,
                    //         hint: const Padding(
                    //           padding: EdgeInsets.only(bottom: 0),
                    //           child: Text(
                    //             "ml",
                    //             style: TextStyle(
                    //                 color: colors.blackTemp,
                    //                 fontWeight: FontWeight.normal,
                    //                 fontSize: 14),
                    //           ),
                    //         ),
                    //         // dropdownColor: colors.primary,
                    //         value: weightValue,
                    //         icon: const Padding(
                    //           padding: EdgeInsets.only(right: 5),
                    //           child: Icon(
                    //             Icons.keyboard_arrow_down_rounded,
                    //             color: colors.secondary,
                    //             size: 30,
                    //           ),
                    //         ),
                    //         // elevation: 16,
                    //         style: TextStyle(
                    //             color: colors.secondary,
                    //             fontWeight: FontWeight.bold),
                    //         underline: Padding(
                    //           padding: const EdgeInsets.only(left: 0, right: 0),
                    //           child: Container(
                    //             // height: 2,
                    //             color: colors.whiteTemp,
                    //           ),
                    //         ),
                    //         onChanged: (String? value) {
                    //           // This is called when the user selects an item.
                    //           setState(() {
                    //             weightValue = value!;
                    //           });
                    //         },
                    //
                    //         items: weightValueitems
                    //             .map<DropdownMenuItem<String>>((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Column(
                    //               mainAxisSize: MainAxisSize.min,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.all(4.0),
                    //                   child: Text(
                    //                     value,
                    //                     style: const TextStyle(
                    //                         color: colors.textColor,
                    //                         fontWeight: FontWeight.normal),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         }).toList(),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          getTranslated(context, 'BODY_WEIGHT'),
                          style: TextStyle(color: colors.blacktextColor,),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child:Container(
                          width: size.width/2.5,
                          child: TextFormField(
                            controller: bodyWeightCtr,
                            decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.only(left: 5)),
                            validator: (value){
                              if(value?.length==null||value!.isEmpty){
                                return "${getTranslated(context, "BODY_WEIGHT")} ${getTranslated(context, "IS_REQUIRED")}";
                              }
                            },
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          getTranslated(context, "DOSE"),
                          style: TextStyle(color: colors.blacktextColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Container(
                              width: size.width/2.5,
                              child: TextFormField(
                                controller: doseC,
                                decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.only(left: 5)),
                                validator: (value){
                                  if(value?.length==null||value!.isEmpty){
                                    return "${getTranslated(context, "Dose")} ${getTranslated(context, "IS_REQUIRED")}";
                                  }
                                },
                              )),
                        ),
                        Card(
                          child: Container(
                            width: size.width / 2.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Padding(
                                  padding: EdgeInsets.only(bottom: 0),
                                  child: Text(
                                    "ml",
                                    style: TextStyle(
                                        color: colors.blackTemp,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14),
                                  ),
                                ),
                                // dropdownColor: colors.primary,
                                value: unitVNew,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: colors.secondary,
                                    size: 30,
                                  ),
                                ),
                                // elevation: 16,
                                style: TextStyle(
                                    color: colors.secondary,
                                    fontWeight: FontWeight.bold),
                                underline: Padding(
                                  padding: const EdgeInsets.only(left: 0, right: 0),
                                  child: Container(
                                    // height: 2,
                                    color: colors.whiteTemp,
                                  ),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    unitVNew = value!;
                                  });
                                },

                                items: unitType
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: colors.textColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            if(bodyWeightCtr.text.isEmpty||doseC.text.isEmpty||animalCat==null||unitType ==  null) {

                              Fluttertoast.showToast(msg: "Please Fill category, bodyWeight,doseC And Unit ");
                            }else{
                              setState(() {
                                catNewList.add(catId.toString());

                                bodyList.add(bodyWeightCtr.text);
                                doessList.add(doseC.text);
                                unitList.add(unitVNew ?? '');
                                Map<String, String> newCat = {
                                  "cat": "${animalCat?.name}",
                                  "body": "${bodyWeightCtr.text}",
                                  "dose": "${doseC.text}",
                                  "unit": "${unitVNew}",
                                };
                                addTableList.add(newCat);
                                // bodyWeightCtr.clear();
                                // doseC.clear();
                                // animalCat?.name == null;
                                // unitVNew== null;
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
                      ],
                    ),
                    addTableList.isEmpty ? SizedBox.shrink():
                    Card(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(getTranslated(context, "CATEGORY"),
                                  style: TextStyle(
                                      fontSize: 14, color: colors.darkBlue),
                                ),
                                Text(getTranslated(context, "BODY_WEIGHT"),
                                  style: TextStyle(
                                      fontSize: 14, color: colors.darkBlue),
                                ),
                                Text(
                                  getTranslated(context, "DOSE"),
                                  style: TextStyle(
                                      fontSize: 14, color: colors.darkBlue),
                                ),
                                Text(
                                  "Unit",
                                  style: TextStyle(
                                      fontSize: 14, color: colors.darkBlue),
                                ),
                              ],
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics:NeverScrollableScrollPhysics(),
                              itemCount: addTableList.length,
                                itemBuilder: (context,i){
                               return  Container(
                                 decoration: BoxDecoration(
                                   border: Border(
                                     bottom: BorderSide(
                                       color: colors.blacktextColor,
                                       // Specify your desired border color here
                                       width: 1.0, // Adjust the border width
                                     ),
                                   ),
                                 ),
                                 child:


                                 Container(
                                   padding: const EdgeInsets.all(14.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       // SizedBox(width: MediaQuery.of(context).size.width/23,),
                                       Text(
                                         "${addTableList[i]["cat"]}",
                                         style: TextStyle(
                                             fontSize: 16,
                                             color: colors.blacktextColor,
                                             fontWeight: FontWeight.w500),
                                       ),
                                       Text(
                                         "${addTableList[i]["body"]}",
                                         style: TextStyle(
                                             fontSize: 16,
                                             color: colors.blacktextColor,
                                             fontWeight: FontWeight.w500),
                                       ),
                                       Text(
                                         "${addTableList[i]["dose"]}",
                                         style: TextStyle(
                                             fontSize: 16,
                                             color: colors.blacktextColor,
                                             fontWeight: FontWeight.w500),
                                       ),
                                       Text(
                                         "${addTableList[i]["unit"]}",
                                         style: TextStyle(
                                             fontSize: 16,
                                             color: colors.blacktextColor,
                                             fontWeight: FontWeight.w500),
                                       ),

                                     ],
                                   ),
                                 ),
                               );

                                }),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Text(
                          getTranslated(context, "DIRECTION")+" : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: colors.darkBlue),
                        ),
                      ],
                    ),

                    Card(
                      child: Container(
                          child: TextFormField(
                            decoration: InputDecoration(border: InputBorder.none,contentPadding: EdgeInsets.only(left: 7)),
                          )),
                    ),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        Text(getTranslated(context, "MEDICINE_PREGNANT"),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      ],
                    ),

                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: "YES",
                                groupValue: male,
                                // activeColor: MyColors.primaryColor,
                                onChanged: (val) {
                                  setState(() {
                                    male = val!;
                                  });
                                }
                            ),
                            Text(getTranslated(context, "YES"),),

                            // ParagraphText('Male', fontSize: 15, color: MyColors.grey2,),
                          ],
                        ),

                        Row(
                          children: [
                            Radio(
                                value: "NO",
                                groupValue: male,
                                //  activeColor: MyColors.primaryColor,
                                onChanged: (val) {
                                  setState(() {
                                    male = val!;
                                  });
                                }
                            ),

                            Text(getTranslated(context, "NO"),),
                            //ParagraphText('Female', fontSize: 15, color: MyColors.grey2,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Btn(
                      onPress: (){
                        if(_formKey.currentState!.validate()){
                          addMedicineApi();
                        }else if(catValueNew ==  null){
                          Fluttertoast.showToast(msg: "Please select medicine");
                        }else if(weightValueNew == null){
                          Fluttertoast.showToast(msg: "Please select disease");
                        // }else if(addTableList == null ){
                        //   Fluttertoast.showToast(msg: "Please select medicine Schedule");
                        }else if(qtyValueNew == null ){
                          Fluttertoast.showToast(msg: "Please select qty");
                        }else if(unitVNew == null ){
                          Fluttertoast.showToast(msg: "Please select unit");
                        }
                        else{
                          Fluttertoast.showToast(msg: "Please select all field..");
                        }
                      },

                      height:45,width: MediaQuery.of(context).size.width,
                      title: getTranslated(context, "SAVE"),
                    ),

                  ],
                ),
              ),
            ),
        ),
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


  Future<void> addMedicineApi() async {
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
      "category": extractStrings(catNewList.toString(),),
      "body_weight": extractStrings(bodyList.toString(),),
      "dose": extractStrings(doessList.toString()),
      "unit": extractNumbers(unitList.toString()),

    });
    prms ['shadule_data'] = parameter ;
    prms ['medicine_type'] = catValueNew.toString();
    prms ['medicine_id'] = medicineIdctr.text;
    prms ['disease'] = weightValueNew.toString();
    prms ['medicine_name'] = medicineNameCtr.text;
    prms ['unit'] = unitVNew1.toString();
    prms ['qty'] = qtyCtr.text;
    prms ['exp_date'] = selectDeliveryDateCtr.text;
    var response = await http.post(Uri.parse(ApiService.ADDMedicine), body:prms);
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




  bool isLoading = true;
  // Future<void> addMedicineApi() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var parameter = {
  //     'medicine_type':catValueNew.toString(),
  //     'medicine_id':medicineIdctr.text,
  //     'disease':weightValueNew.toString(),
  //     'medicine_name':medicineNameCtr.text,
  //     'unit':unitVNew.toString(),
  //      'qty':qtyCtr.text,
  //     'exp_date':selectDeliveryDateCtr.text,
  //     "shadule_data":jsonEncode({
  //       'category':catNewList.join(','),
  //       'body_weight':bodyList.join(','),
  //       'dose':doessList.join(','),
  //       'unit':unitList.join(','),
  //     }),
  //     'description':directionCtr.text,
  //     'safe_for_pregnent':male
  //   };
  //   print('_____parameter_____$parameter}_________');
  //   apiBaseHelper.postAPICall(Uri.parse(ApiService.getMedicine), parameter).then((getData) async {
  //     bool error = getData['error'];
  //     setState(() {
  //       isLoading = false;
  //     });
  //     if (error ==  false) {
  //       setState(() {
  //         Fluttertoast.showToast(msg: "${getData['message']}");
  //         Navigator.pop(context);
  //
  //       });
  //       catValueNew == null;
  //       weightValueNew == null;
  //       unitVNew == null;
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }
  Future<void> updateMedicineApi() async {
    setState(() {
      isLoading = true;
    });
    var parameter = {
      'medicine_type':catValueNew.toString(),
      'medicine_id':medicineIdctr.text,
      'disease':weightValueNew.toString(),
      'medicine_name':medicineNameCtr.text,
      'qty':qtyCtr.text,
      'unit':unitVNew1.toString(),
      'exp_date':selectDeliveryDateCtr.text,

    };
    print('_____parameter_____$parameter}_________');
    apiBaseHelper.postAPICall(Uri.parse(ApiService.ADDMedicine), parameter).then((getData) async {
      bool error = getData['error'];
      setState(() {
        isLoading = false;
      });
      if (error ==  false) {
        setState(() {
          Fluttertoast.showToast(msg: "${getData['message']}");
          Navigator.pop(context);
        });

      }
      setState(() {
        isLoading = false;
      });
    });
  }



  List<String> bodyList=[];
  List<String> doessList=[];
  List <String>unitList=[];
  List <String> catNewList=[];
  List addTableList=[];


}
