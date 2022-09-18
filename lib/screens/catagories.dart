import 'package:flutter/material.dart';
import 'package:xiaomi_hq/screens/add_category.dart';
import 'package:xiaomi_hq/screens/products.dart';
import 'package:firedart/firedart.dart';

class CatagoriesHome extends StatelessWidget {
  CatagoriesHome({Key? key}) : super(key: key);

  CollectionReference cats = Firestore.instance.collection('catalogue');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Categories',textAlign:TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: MediaQuery.of(context).size.width*0.075,
                  children: [
                    getcards(temp: cats),
                  ],
                ),
              ),
            ),
          )],
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (ctx)=>NewCategory()));
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Container(
                height: 200,
                width: 260,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(4,4),
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12
                      ),
                    ]
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 3
                        )
                      ),
                      height: 80,
                      width: 80,
                    ),
                    Icon(Icons.add,color: Colors.black,size: 36,)
                  ],
                ),
              ),
              Container(
                child: const Text('Add',style: TextStyle(color: Colors.black,fontSize: 14,),),
                margin: EdgeInsets.symmetric(vertical: 3),
              )
            ],
          )
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key,required this.url,required this.title}) : super(key: key);
  final String url;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (ctx)=>ProductsPage(heading: title,)));
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Column(
          children: [
            Container(
          height: 200,
          width: 260,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    offset: Offset(4,4),
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12
                ),
              ]
          ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(url,fit: BoxFit.cover,),
            ),
          ),
            Container(
              child: Text(title,style: TextStyle(color: Colors.black,fontSize: 14,),),
              margin: EdgeInsets.symmetric(vertical: 3),
            )
          ],
        )
    ),
      );
  }
}

class getcards extends StatelessWidget {
  getcards({Key? key,required this.temp}) : super(key: key);
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
              cats.add(CategoryCard(title: x['Title'],url: x['PhotoURL'],));
            }
            cats.add(const AddCard());
            return Wrap(
              spacing: 30,
              runSpacing: 15,
              children: cats,);
          }
          return CircularProgressIndicator();
        });
  }
}

Future getdocs(CollectionReference x){
  return x.get();
}

