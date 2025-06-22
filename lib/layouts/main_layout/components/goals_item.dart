import 'package:flutter/material.dart';

import '../../../cubit/main_cubit.dart';

Widget goalItem(context,id,goalName,) =>  InkWell(
  onTap: (){
    showDialog(
        context: context,
        builder: (_)=> AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
                            'Editing : ',
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
                                MainCubit.get(context).deleteData(id);
                                MainCubit.get(context).
                                addTextController.text = '';
                                MainCubit.get(context).getData();
                                Navigator.pop(context);
                              },
                              child: const Text('Delete',
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
        ));
  },
  child:   Container(
    height: 80,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(
                  2,2
              )
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.blue[900]!,
          ],
        )
    ),
    child: Center(
      child: Text(
        '$id : $goalName',
        style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600
        ),
      ),
    ),
  ),
);