import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../color.dart';

class RentalWritePage extends StatefulWidget {
  const RentalWritePage({Key? key}) : super(key: key);

  @override
  State<RentalWritePage> createState() => _RentalWritePageState();
}

class _RentalWritePageState extends State<RentalWritePage> {
  final _OTTList = ['넷플릭스', '왓챠', '디즈니플러스', '웨이브','애플티비','티빙'];
  final _NumList = ['1', '2', '3', '4'];
  final double _Width = 236;
  final _formKey = new GlobalKey<FormState>();
  late String _title;
  late String _OTT;
  late String _startDate;
  late String _endDate;
  late String _bills;

  String? _selectedOTT = '넷플릭스';
  String? _selectedNum = '4';
  DateTimeRange _dateTime =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  void validateAndPost() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      _OTT = _selectedOTT!;
      _startDate = _dateTime.start.year.toString() +
          "." +
          _dateTime.start.month.toString() +
          "." +
          _dateTime.start.day.toString();
      _endDate = _dateTime.end.year.toString() +
          "." +
          _dateTime.end.month.toString() +
          "." +
          _dateTime.end.day.toString();
      print('Form is valid Title: $_title, bills: $_bills');

      // 임시 이동
      Navigator.pop(context);
    } else {
      print('Form is invalid Title: $_title, bills: $_bills');
    }
  }

  void _showDatePicker() {
    showDateRangePicker(
      context: context,
      initialDateRange:
          DateTimeRange(start: DateTime.now(), end: DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) => {
          setState(() {
            _dateTime = value!;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("대여글쓰기",style:TextStyle(fontWeight: FontWeight.bold,color:Color(mainColor))),
          backgroundColor: Colors.white,
          elevation: 0.0, //appbar 그림자 제거
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(30),
            child: new Form(
                key: _formKey,
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 28),
                        child: new Column(
                          children: <Widget>[
                            new TextFormField(
                              decoration:
                                  new InputDecoration(labelText: '제목을 입력하세요'),
                              validator: (value) =>
                                  value!.isEmpty ? '제목은 필수입니다' : null,
                              onSaved: (value) => _title = value!,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 24),
                              padding: EdgeInsets.only(
                                  left: 25, top: 8, right: 24, bottom: 4),
                              decoration: BoxDecoration(
                                color: Color(mainColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 80,
                              height: 36,
                              child: Text("OTT",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                            Container(
                              child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: Color(0xffAEB4C2),
                                    ),
                                  ),
                                  width: _Width,
                                  height: 36,
                                  margin: EdgeInsets.only(top: 24),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    isExpanded: true,
                                    value: _selectedOTT,
                                    items: _OTTList.map(
                                      (value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedOTT = value;
                                      });
                                    },
                                  ))),
                            ),
                          ],
                        ),
                      ),

                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(mainColor),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 80,
                              height: 36,
                              child: Text("사용기간",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                            Container(
                                child: Row(children: <Widget>[
                              Container(
                                //padding: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(0xffAEB4C2),
                                  ),
                                ),
                                width: _Width,
                                height: 36,
                                margin: EdgeInsets.only(top: 22),
                                child: new ElevatedButton(
                                  onPressed: _showDatePicker,
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    _dateTime.start.year.toString() +
                                        "." +
                                        _dateTime.start.month.toString() +
                                        "." +
                                        _dateTime.start.day.toString() +
                                        "~" +
                                        _dateTime.end.year.toString() +
                                        "." +
                                        _dateTime.end.month.toString() +
                                        "." +
                                        _dateTime.end.day.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ])),
                          ])),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(mainColor),
                                  borderRadius: BorderRadius.circular(5)),
                              width: 80,
                              height: 36,
                              child: Text("예상가격",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                            Container(
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        width: 1,
                                        color: Color(0xffAEB4C2),
                                      ),
                                    ),
                                    width: _Width,
                                    height: 36,
                                    margin: EdgeInsets.only(top: 22),
                                    child: TextFormField(
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onSaved: (value) => _bills = value!,
                                    ))),
                          ])),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0),
                        child: new ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(mainColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: new Text(
                            '등록하기',
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          onPressed: validateAndPost,
                        ),
                        height: 45,
                      ),
                    ])),
          ),
        ),
      ),
    );
  }
}
