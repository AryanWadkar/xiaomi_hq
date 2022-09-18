import 'package:flutter/material.dart';
import 'package:xiaomi_hq/utils/constants.dart';
import 'package:firedart/firedart.dart';

class NewCategory extends StatefulWidget {
  const NewCategory({Key? key}) : super(key: key);

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  CollectionReference cats = Firestore.instance.collection('catalogue');
  GlobalKey<FormState> mainkey = GlobalKey();
  List<Property> props=[];
  String title='';
  String desc='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackG,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 40),
        child: SingleChildScrollView(
          child: Form(
            key: mainkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Category',textAlign:TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                                child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: TextFormField(
                                onSaved: (val){
                                  desc=val!;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (val){
                                  if(val!=null && val=='')
                                  {
                                    return 'Enter Value';
                                  }
                                },
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Title',
                                    hintStyle: const TextStyle(fontSize: 12,fontFamily: 'Lato'),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color: Colors.black.withOpacity(0.60)
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.60)
                                      )
                                  ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.80)
                                      )
                                  ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.80)
                                      )
                                  ),
                                ),
                              ),
                            )),
                            const SizedBox(height: 10,),
                            Expanded(flex:4,child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextFormField(
                                onSaved: (val){
                                  desc=val!;
                                },
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (val){
                                  if(val!=null && val=='')
                                  {
                                    return 'Enter Value';
                                  }
                                },
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Description (optional)',
                                  hintStyle: const TextStyle(fontSize: 12,fontFamily: 'Lato'),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.60)
                                      )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black.withOpacity(0.60)
                                      )
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.80)
                                      )
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.red.withOpacity(0.80)
                                      )
                                  ),
                                  //contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)
                                ),
                              ),
                            )),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300
                            ),
                            child: const Icon(Icons.image),
                          ),
                        ),
                      )
                    ],
              ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                      child: Text('Properties',textAlign:TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    GestureDetector(
                      onTap: ()async {

                        await showDialog(context: context, builder: (ctx){
                          GlobalKey<FormState> addkey = GlobalKey();
                          String desc='';
                          String title='';
                          return AlertDialog(
                            title: const Text('New Property'),
                            content: Form(
                              key: addkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Title'
                                    ),
                                    onSaved: (val){
                                      title=val??' ';
                                    },
                                    validator: (val){
                                      if(val!=null && val.trim()=='')
                                        {
                                          return 'Enter Valid Name';
                                        }
                                    },
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Description'
                                    ),
                                    onSaved: (val){
                                      desc=val??' ';
                                    },
                                    validator: (val){
                                      if(val!=null && val.trim()=='')
                                      {
                                        return 'Enter Valid Name';
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(onPressed: (){
                                if(addkey.currentState?.validate() ?? false)
                                  {
                                    addkey.currentState?.save();
                                    props.add(Property(desc: desc, title: title));
                                    Navigator.pop(context);
                                  }
                              }, child: const Text('Add'))
                            ],
                          );
                        });
                        setState(() {

                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(4,4),
                                    color: Colors.black.withOpacity(0.30),
                                    blurRadius: 12
                                )
                              ],
                              color: kPrimaryColor
                          ),
                          child: const Text('Add Property',style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                      ),
                    )

                  ],
                ),
                for(var i in props)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: i),
                      TextButton(onPressed: (){
                        setState(() {
                          props.remove(i);
                        });
                      }, child:const  Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Icon(Icons.delete),
                      ))
                    ],
                  ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: ()async{
                      if(mainkey.currentState?.validate()??false)
                        {
                          mainkey.currentState?.save();
                          await cats.add({
                            'Title':title,
                            'Desc':desc,
                            'Props':[
                              props.toString()
                            ]
                          });
                        }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor)
                    ), child:const  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('SAVE',style: TextStyle(color: Colors.white),),
                    ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Property extends StatelessWidget {
  Property({Key? key,required this.desc,required this.title}) : super(key: key);
  String title;
  String desc;
  GlobalKey<FormState> editkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: editkey,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val){
                    if(val!=null && val=='')
                    {
                      return 'Enter Value';
                    }
                  },
                  onChanged: (val){
                    title=val;
                  },
                  initialValue: title,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(fontSize: 12,fontFamily: 'Lato'),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.60)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.60)
                        )
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.80)
                        )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.80)
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val){
                    if(val!=null && val=='')
                      {
                        return 'Enter Value';
                      }
                  },
                  initialValue: desc,
                  onChanged: (val){
                    desc=val;
                  },
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: const TextStyle(fontSize: 12,fontFamily: 'Lato'),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.60)
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.60)
                        )
                    ),
errorBorder: OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
          color: Colors.red.withOpacity(0.80)
    )
),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.red.withOpacity(0.80)
                        )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



