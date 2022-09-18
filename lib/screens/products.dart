import 'package:flutter/material.dart';
import 'package:xiaomi_hq/utils/constants.dart';
import 'package:firedart/firedart.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key,required this.heading}) : super(key: key);
  final String heading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
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
                    hintText: 'Search Products',
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
                  child: getprodcards(temp: Firestore.instance.collection('catalogue/$heading/Products'),)),
              )
            ],
          ),
        ),
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
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
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

class getprodcards extends StatelessWidget {
  getprodcards({Key? key,required this.temp}) : super(key: key);
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
              cats.add(ProductCard(title: x['Title'],url: x['PhotoURL'],));
            }
            cats.add(const AddCard());
            return Wrap(
              spacing: 20,
              runSpacing: 15,
              children: cats,);
          }
          return CircularProgressIndicator();
        });
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key,required this.title,required this.url}) : super(key: key);
  final String title;
  final String url;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
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

Future getdocs(CollectionReference x){
  return x.get();
}