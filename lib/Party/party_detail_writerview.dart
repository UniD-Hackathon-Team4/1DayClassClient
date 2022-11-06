import 'package:flutter/material.dart';
import 'package:home_body/Party/party_mainview.dart';

import '../Login/login.dart';
import '../color.dart';
import '../server.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PartyDetailWriterPage extends StatefulWidget {
  final int partyId;

  const PartyDetailWriterPage({Key? key, required this.partyId}) : super(key: key);

  @override
  State<PartyDetailWriterPage> createState() => _PartyDetailWriterPageState();
}

class _PartyDetailWriterPageState extends State<PartyDetailWriterPage> {

  @override
  void initState(){
    super.initState();
    print(widget.partyId);
  }

  void disableElevatedButton(int index) {
     //isEnabled[index] = false;
    setState(() {
      curPeople++;
      isEnabled[index] = false;
    });

    if(curPeople == maxPeople){
      Navigator.pop(context);
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('모집 완료'),
          content: const Text('모집이 완료되었습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );

    }
  }

  // func(int index){
  //   print("clicked");
  //   disableElevatedButton(index);
  // }

  Widget listview_builder() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: userName.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(mainColor),
                          width: 1.0
                      )
                  )
              ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(

                  width: 60,
                  child: Text("${userName[index]}",
                      style:TextStyle(
                          color:Color(0xff333333),
                          fontSize: 14
                      )
                  ),
                ),

                Container(

                  width: 150,
                  child: Text("${userPhone[index]}",
                      style:TextStyle(
                          color:Color(0xff333333),
                          fontSize: 14
                      )
                  ),
                ),

                Container(

                  width: 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: isEnabled[index] ? Color(mainColor) : Color(0xffB8B8B8),
                      padding: EdgeInsets.all(8),
                      textStyle: TextStyle(fontSize: 14),
                    ),
                    child: Text('수락하기'),
                    onPressed: isEnabled[index] ? (){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('수락 여부 확인'),
                          content: const Text('수락하시겠습니까?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                disableElevatedButton(index);
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        ),
                      );

                    }
                    :
                    null,
                  ),
                ),

              ],
            )

          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("파티모집",
            style:TextStyle(
                color:Color(mainColor),
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff333333),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: 22.0, right: 22.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // 글 내용
                Container(
                    padding: EdgeInsets.all(22.0),
                    margin: EdgeInsets.only(),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color(mainColor),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text("${title}",
                                        style:TextStyle(
                                            fontSize: 16,
                                            color:Color(0xff333333),
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),

                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "${curPeople}/${maxPeople}",
                                              style:TextStyle(
                                                fontSize: 10,
                                                color:Color(0xff666666),
                                              )
                                          ),
                                        ),

                                        Container(
                                          child: Icon(
                                            Icons.circle,
                                            size: 9,
                                            color: curPeople == maxPeople? Colors.red : Colors.green,
                                          ),
                                        )

                                      ],
                                    ),
                                  )
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 5, bottom: 15.0),
                                child: Text("${writer}",
                                    style:TextStyle(
                                      fontSize: 10,
                                      color:Color(0xff666666),
                                    )
                                ),
                              )
                            ],
                          )
                        ),

                        // body Container

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text("OTT",
                                          style:TextStyle(
                                              fontSize: 12,
                                              color:Color(mainColor),
                                              fontWeight: FontWeight.w700
                                          )
                                      )
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text("사용기간",
                                          style:TextStyle(
                                              fontSize: 12,
                                              color:Color(mainColor),
                                              fontWeight: FontWeight.w700
                                          )
                                      )
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text("희망가격",
                                          style:TextStyle(
                                              fontSize: 12,
                                              color:Color(mainColor),
                                              fontWeight: FontWeight.w700
                                          )
                                      )
                                  ),

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text("${ottType}",
                                          style:TextStyle(
                                              fontSize: 12,
                                              color:Color(0xff333333),
                                          )
                                      )
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text("${startDate.substring(0,10)} ~ ${endDate.substring(0,10)}",
                                          style:TextStyle(
                                            fontSize: 12,
                                            color:Color(0xff333333),
                                          )
                                      )
                                  ),

                                  Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text("${price}",
                                          style:TextStyle(
                                            fontSize: 12,
                                            color:Color(0xff333333),
                                          )
                                      )
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                ),

                // 신청자 목록
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      Container(
                          child: Row(
                            children: [
                              Text("신청자 목록",
                                  style:TextStyle(
                                    fontSize: 14,
                                    color:Color(mainColor),
                                    fontWeight: FontWeight.bold
                                  )
                              ),

                              Spacer()
                            ],
                          )
                      ),

                      Container(
                        //margin: EdgeInsets.only(top: 0.0),
                        height: 350.0,
                        child: listview_builder(),
                      )


                    ],
                  ),
                ),

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
                      '삭제하기',
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                  ),
                  height: 45,
                ),

              ],
            ),
          )
      ),
    );
  }
}
