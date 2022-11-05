import 'package:flutter/material.dart';

import '../color.dart';

class PartyDetailNonWriterPage extends StatefulWidget {
  const PartyDetailNonWriterPage({Key? key}) : super(key: key);

  @override
  State<PartyDetailNonWriterPage> createState() => _PartyDetailNonWriterPageState();
}

class _PartyDetailNonWriterPageState extends State<PartyDetailNonWriterPage> {

  final List <bool> isEnabled = <bool>[true, true, true, true, true, true, true, true];

  final List<String> userName = <String>["손님1", "손님2", "손님3"];
  final List<String> userPhone = <String>["010-9999-1234", "010-9999-1234", "010-9999-1234"];

  String writer = "글쓴이";
  String ottType = "넷플릭스";
  String startDate = "2022-11-05";
  String endDate = "2022-12-31";
  String price = "4,250";
  int maxPeople = 3;
  int curPeople = 1;

  void disableElevatedButton(int index) {
    //isEnabled[index] = false;
    setState(() {
      curPeople++;
      isEnabled[index] = false;
    });

    if(curPeople == maxPeople){
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('모집 완료'),
          content: const Text('모집이 완료되었습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
                                      child: Text("넷플릭스 파티원 4명 구해요",
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
                                      child: Text("${startDate} ~ ${endDate}",
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
                      '삭제하기',
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                    onPressed: () => {},
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
