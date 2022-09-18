import 'package:flutter/material.dart';
import 'package:xiaomi_hq/screens/catagories.dart';
import 'package:xiaomi_hq/screens/store_sale.dart';
import 'package:xiaomi_hq/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firedart/firedart.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize('xiaomio2cproto');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily:'Lato').copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
          primary: kPrimaryColor,
        ),
      ),
      title: 'Xiaomi HQ',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Image.asset('assets/logo_S.png',scale: 8,),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width*0.08,
                    width: 2,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              cursorColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'ID',
                                hintStyle: TextStyle(fontSize: 12,fontFamily: 'Lato'),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.transparent
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent
                                    )
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              cursorColor: kPrimaryColor,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Password',
                                  hintStyle: TextStyle(fontSize: 12,fontFamily: 'Lato'),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent
                                      )
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (ctx)=>const HQHome()));
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    margin: EdgeInsets.symmetric(vertical: 25),
                    child: const Text('LOGIN',style: TextStyle(fontFamily: 'Lato',fontWeight: FontWeight.bold, fontSize: 16),textAlign: TextAlign.center,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}




class HQHome extends StatefulWidget {
  const HQHome({Key? key}) : super(key: key);

  @override
  State<HQHome> createState() => _HQHomeState();
}

class _HQHomeState extends State<HQHome> {

  tabs selt = tabs.stores;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackG,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
          children: [
            GestureDetector(
              onTap: (){
                if(selt!=tabs.stores)
                  {
                    setState(() {
                      selt=tabs.stores;
                    });
                  }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Stores and Sales',textAlign:TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Container(
                        height: 2,
                        margin:EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                        color: selt==tabs.stores?Colors.white:Colors.transparent,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 15,),
            GestureDetector(
              onTap: (){
                if(selt!=tabs.catalogue)
                {
                  setState(() {
                    selt=tabs.catalogue;
                  });
                }
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width*0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Catalogue',textAlign:TextAlign.center,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Container(
                        height: 2,
                        margin:EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                        color: selt==tabs.catalogue?Colors.white:Colors.transparent,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),),
        leadingWidth: MediaQuery.of(context).size.width*0.75,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Center(child: Text('LOGOUT',style: TextStyle(fontFamily: 'Lato',color:Colors.black, fontWeight: FontWeight.bold, fontSize: 12))),
              ),
            ),
          )
        ],
      ),
      body: selt==tabs.stores?StoreSaleHome():CatagoriesHome(),
    );
  }
}

enum tabs{
  catalogue,
  stores
}

