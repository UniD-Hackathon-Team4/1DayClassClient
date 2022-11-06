import 'package:flutter/material.dart';
import 'package:home_body/Party/party_detail_writerview.dart';
import 'package:home_body/Party/party_mainview.dart';
import 'package:home_body/Rental/rental_detail_writerview.dart';
import 'package:home_body/Rental/rental_mainview.dart';
import 'package:home_body/color.dart';
import '../dummy/myparty_dummydata.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  Image appLogo = new Image(
      image: new ExactAssetImage("images/appbar.png"),
      alignment: Alignment.center,
  );

  String isChecked = "0";
  String currentLocation="total";
  late MyPartyDummydata mypartydummydata;

  @override
  void initState(){
    super.initState();
    mypartydummydata=MyPartyDummydata();
  }

  //상단 appbar 위젯
  PreferredSizeWidget _mainappbarWidget(){
    return AppBar(
      title: appLogo,
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0.0, //appbar 그림자 제거
    );
  }

  _loadContents(){
      return mypartydummydata.loadContentsFromLocation3(currentLocation);
  }

  _makeDataList(List<Map<String,String>> datas){
    return ListView.separated(
      itemBuilder: (BuildContext _context, int index){
        if (datas[index]["ischecked"] == "1"){
          return GestureDetector(
            onTap: (){
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => PartyDetailWriterPage()),
              // );
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Text(
                            datas[index]["title"]!,
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Text(
                                  "${datas[index]["curPeople"]!}/${datas[index]["maxPeople"]!}",
                                  style:TextStyle(
                                    fontSize: 10,
                                    color:Color(0xff666666),
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.circle,
                                  size: 9,
                                  color: datas[index]["curPeople"]! == datas[index]["maxPeople"]!? Colors.red : Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Text(
                      datas[index]["ischecked"]! == "1" !? datas[index]["writer"]! : " ",
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(graytextcolor),
                      ),
                    ),
                  ),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:10,right:15),
                            child: Text(
                              "예상가격",
                              textAlign: TextAlign.left,
                              style:TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(mainColor),
                              ),
                            ),
                          ),
                          Text(datas[index]["price"]!),
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Container();
        }
      },
      itemCount: 10,
      separatorBuilder: (BuildContext _context, int index){
        return Container(height: 1, color: Color(mainColor));
      },
    );
  }

  _makeDataList2(List<Map<String,String>> datas){
    return ListView.separated(
      itemBuilder: (BuildContext _context, int index){
        if (datas[index]["ischecked"] == "1"){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RentalDetailWriterPage()),
              );
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Text(
                            datas[index]["title"]!,
                            textAlign: TextAlign.left,
                            style:TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Text(
                      datas[index]["ischecked"]! == "1" !? datas[index]["writer"]! : " ",
                      textAlign: TextAlign.left,
                      style:TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(graytextcolor),
                      ),
                    ),
                  ),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:10,right:15),
                            child: Text(
                              "예상가격",
                              textAlign: TextAlign.left,
                              style:TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(mainColor),
                              ),
                            ),
                          ),
                          Text(datas[index]["price"]!),
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Container();
        }
      },
      itemCount: 10,
      separatorBuilder: (BuildContext _context, int index){
        return Container(height: 1, color: Color(mainColor));
      },
    );
  }

  //content 목록
  Widget _MyPartyContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10,top: 30,right:10),
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,

      child: FutureBuilder(
          future: _loadContents(),
          builder: (BuildContext context,dynamic snapshot) {
            //print(snapshot);
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("데이터 오류"));
            }
            if (snapshot.hasData) {
              return _makeDataList(snapshot.data);
            }
            return Center(child: Text("해당 지역에 데이터 없습니다."));
          }
      ),
    );
  }

  Widget _MyPartyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:30,left:20,right: 20),
              child: Text("내 파티보기",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => PartyMainPage()),
                );
              },
              child:
                  Padding(
                    padding: const EdgeInsets.only(top:30,right: 20),
                    child: Text("모든 파티 보러가기",style:TextStyle(fontSize: 10,color:Color(graytextcolor))),
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _MyRentalWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:45,left:20,right: 20),
              child: Text("대여신청목록",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RentalMainPage()),
                );
              },
              child:
              Padding(
                padding: const EdgeInsets.only(top:45,right: 20),
                child: Text("모든 대여 보러가기",style:TextStyle(fontSize: 10,color:Color(graytextcolor))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //content 목록
  Widget _MyRentalContent() {
    return Container(
      padding: const EdgeInsets.only(left: 10,top: 30,right:10),
      height: MediaQuery.of(context).size.height*0.3,
      width: MediaQuery.of(context).size.width,

      child: FutureBuilder(
          future: _loadContents(),
          builder: (BuildContext context,dynamic snapshot) {
            //print(snapshot);
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("데이터 오류"));
            }
            if (snapshot.hasData) {
              return _makeDataList2(snapshot.data);
            }
            return Center(child: Text("해당 지역에 데이터 없습니다."));
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_mainappbarWidget(),
      body:
        Column(
          children: [
            _MyPartyWidget(), //내 파티보기
            _MyPartyContent(),
            _MyRentalWidget(), //대여 신청 목록
            _MyRentalContent(),
          ],
        ),
    );
  }

}