import 'package:alarm_app/_utils/alarm_time.dart';
import 'package:alarm_app/_utils/show_toast.dart';
import 'package:alarm_app/models/list_info.dart';
import 'package:alarm_app/src/myList_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyListForm extends StatelessWidget {
  final MyListInfo? myListInfo;
  final int? colorIndex;
  const MyListForm({
    Key? key,
    this.myListInfo,
    this.colorIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _myListHelper = context.read<MyListHelper>();
    final myListIsNull = myListInfo == null;
    String? _title = myListInfo?.title;
    String? _description = myListInfo?.description;
    bool? _value = myListInfo?.isImportant;
    bool _isImportant = false;

    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  myListIsNull ? 'Add List' : 'Edit List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        maxLines: 1,
                        initialValue: _title,
                        validator: (_title) {
                          if (_title!.isEmpty) {
                            return 'The title can\'t be empty';
                          }
                          return null;
                        },
                        onChanged: (value) => _title = value,
                        decoration: InputDecoration(
                          hintText: 'Title',
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        maxLines: 3,
                        initialValue: _description,
                        onChanged: (value) => _description = value,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Switch(
                            value: myListIsNull
                                ? _isImportant
                                : _value ?? myListInfo!.isImportant,
                            onChanged: (value) {
                              setState(() {
                                myListIsNull
                                    ? _isImportant = value
                                    : _value = value;
                              });
                            },
                          ),
                          Text(
                            'Is It Important?',
                            style: TextStyle(
                              fontSize: 13,
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: FloatingActionButton(
                    onPressed: () {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        if (!myListIsNull) {
                          myListInfo!.title = _title!;
                          myListInfo!.description = _description ?? '';
                          myListInfo!.createdTime = DateTime.now();
                          myListInfo!.isImportant = _value!;
                          _myListHelper.update(myListInfo!);
                        } else {
                          var myListInfo = MyListInfo(
                            id: AlarmTime.createUniqueId(),
                            isImportant: _value ?? _isImportant,
                            title: _title!,
                            description: _description ?? '',
                            createdTime: DateTime.now(),
                            colorIndex: colorIndex!,
                          );
                          _myListHelper.insert(myListInfo);
                        }
                        Navigator.pop(context);
                        ShowToast.showToast(
                          myListIsNull
                              ? 'Your list has been saved'
                              : 'Your list has been edited',
                          context,
                        );
                      }
                      return null;
                    },
                    child: Text(
                      myListIsNull ? 'Save' : 'Edit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
