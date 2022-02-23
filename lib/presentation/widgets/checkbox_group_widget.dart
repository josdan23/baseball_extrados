
import 'package:baseball_cards/presentation/widgets/checkbox_widget.dart';
import 'package:flutter/material.dart';

class CheckboxGroupWidget extends StatelessWidget {

  final Map<String, String> collectionList;
  final List<String>? selectedList;
  final void Function( String ) selected;
  final void Function( String ) unselected;


  const CheckboxGroupWidget({
    Key? key, 
    required this.collectionList,
    this.selectedList,
    required this.selected,
    required this.unselected,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          'Colecciones',
          style:  TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.w600, 
            color: Colors.black45),
        ),

        const SizedBox(height: 8,),

        Container(
           decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getCheckboxList(),
            // children: collectionList.map((e) {

            //   final isSelected = true;
              
            //   return CheckboxWidget(
            //     title: e, 
            //     value: isSelected,
            //     onChanged: ( value ) {
            //       if (value )
            //         this.selected( e );
            //       else
            //         this.unselected( e );
                  
            //     },
            //   );
            // }).toList()
          ),
        ),
      ],
    );
  }

  List<CheckboxWidget> _getCheckboxList() {

    List<CheckboxWidget> checkboxList = [];
    print(selectedList);
    print(collectionList);
   
    for ( MapEntry<String, String> e in collectionList.entries) {

      final isSelected = selectedList?.contains( e.key );
     
      checkboxList.add( 
        CheckboxWidget(
          title: e.value, 
          value: isSelected ?? false, 
          onChanged: ( value ) {
            if (value )
              this.selected( e.value );
            else
              this.unselected( e.value);
          }
        ) 
      );

    }

    return checkboxList;

  }
}
