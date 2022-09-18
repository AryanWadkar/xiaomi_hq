import 'package:flutter/material.dart';
import 'package:xiaomi_hq/utils/constants.dart';
import 'package:firedart/firedart.dart';

class StoreSaleHome extends StatelessWidget {
  const StoreSaleHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.80,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 35),
              child: TextFormField(
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Stores',
                    hintStyle: TextStyle(fontSize: 14,fontFamily: 'Lato',fontWeight: FontWeight.bold,color: Colors.black.withOpacity(0.50)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.30)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.60)
                        )
                    ),
                    hoverColor: Colors.white70,
                    suffixIcon: Icon(Icons.search),
                    suffixIconColor: Colors.black.withOpacity(0.60),
                    contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                ),

              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: getstorecards(temp:Firestore.instance.collection('stores')),),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> AllStores(){
  return [
    ReportCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
    StoreCard(),
  ];
}

class getstorecards extends StatelessWidget {
  getstorecards({Key? key,required this.temp}) : super(key: key);
  CollectionReference temp;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getdocs(temp),
        builder: (ctx,snapshot){
          if(snapshot.hasData)
          {
            List<Widget> cats=[];
            for(var x in snapshot.data)
            {
              cats.add(StoreCard());
            }
            cats.add(const ReportCard());
            return Wrap(
              spacing: 8,
              runSpacing: 12,
              children: cats,);
          }
          return CircularProgressIndicator();
        });
  }
}

Future getdocs(CollectionReference x){
  return x.get();
}

class StoreCard extends StatelessWidget {
  const StoreCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: MediaQuery.of(context).size.width*0.35,
        height: MediaQuery.of(context).size.height*0.20,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black.withOpacity(0.15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: const Offset(4,4),
              blurRadius: 12
            )
          ]
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  const ReportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: MediaQuery.of(context).size.width*0.35,
        height: MediaQuery.of(context).size.height*0.20,
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black.withOpacity(0.15),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(4,4),
                  blurRadius: 12
              )
            ]
        ),
        child: Center(child: Text('Generate overall sales report',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}

