import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goals/cubit/main_cubit.dart';
import 'package:goals/layouts/main_layout/components/goals_item.dart';

import '../../../cubit/main_states.dart';

class MainLayout extends StatelessWidget{
  const MainLayout({super.key});



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MainCubit()..initSql()..getData(),
        child: BlocConsumer<MainCubit , MainStates> (
          listener: (context , state){

          },
          builder: (context , state ){
            return  Scaffold(
              appBar: AppBar(
                title: const Center(
                  child: Text(
                    'GOALS',
                    style: TextStyle(
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 38,
                    ),
                  ),
                ),
                backgroundColor: Colors.blue[900],
              ),
              body: ListView.builder(
                  itemCount: MainCubit.get(context).goalsList.length,
                  itemBuilder:(context , index) => goalItem(context,
                    MainCubit.get(context).goalsList[index]['id'],
                    MainCubit.get(context).goalsList[index]['name'],
                  )
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.teal,
                onPressed: (){
                  showDialog(context: context,
                      builder: (_)=>
                          AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),

                              ),
                              content: Container(
                                  height: 140,
                                  child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius: BorderRadius.circular(5), // ✅ Correct way to apply borderRadius
                                          ),
                                          height: 30,
                                          child: const Center(
                                            child: Text(
                                              'Write your Goals: ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        TextFormField(
                                          controller: MainCubit.get(context).addTextController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              label: const Text('Write Here...'),
                                              // floatingLabelBehavior: FloatingLabelBehavior.never,
                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5)
                                              ),
                                              contentPadding: const EdgeInsets.all(5)
                                          ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Row(
                                          children: [
                                            Expanded(child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty
                                                      .all(Colors.red[700]),
                                                ),
                                                onPressed: (){
                                                  MainCubit.get(context).insertData(
                                                      MainCubit.get(context).
                                                      addTextController.text.toString()
                                                  );
                                                  MainCubit.get(context).
                                                  addTextController.text = '';
                                                  MainCubit.get(context).getData();
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Add',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),)),),
                                            const SizedBox(width: 5,),
                                            Expanded(child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty
                                                      .all(Colors.blue[700]),
                                                ),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel',
                                                  style: TextStyle(
                                                    color: Colors.white,

                                                  ),)),),
                                          ],
                                        )
                                      ]
                                  )
                              )
                          )
                  );
                },
                child: const Icon(Icons.add,
                    size: 33,
                    color: Colors.white),

              ),
            );
          },
        ),);



  }

}