import 'package:flutter/material.dart';
import 'package:home_body/Party/party_mainview.dart';

import '../color.dart';

class PartyDetailNonWriterPage extends StatefulWidget {

  final int partyId;

  const PartyDetailNonWriterPage({Key? key, required this.partyId}) : super(key: key);

  @override
  State<PartyDetailNonWriterPage> createState() => _PartyDetailNonWriterPageState();
}

class _PartyDetailNonWriterPageState extends State<PartyDetailNonWriterPage> {

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
                      '신청하기',
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
