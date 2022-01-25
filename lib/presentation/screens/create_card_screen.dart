 
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class CreateCardScreen extends StatelessWidget {

  static const String routeName = 'create_card';
  
  CreateCardScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final List<String> teams = ['boca', 'river', 'velez', 'independiente'];
    String dropdownTeamValue = 'boca';

    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva carta'),
      ),

      body: SingleChildScrollView(
        child: Form(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
      
                const _ImageViewer( path: 'assets/placeholder.png', ),

                SizedBox(height: 4,),

                TextButton(
                  child: const Text('Cambiar imagen'),
                  onPressed: () async {
                    
                    // final ImagePicker _picker = ImagePicker();

                    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                  }, 
                ),

                SizedBox(height: 16),
      
                _TextField( 
                  labelText: 'Nombre del jugador',
                  prefixIcon: Icon(Icons.person),
                  onChange: ( value ) {
                    print(value);
                  },
                ),
      
                SizedBox(height: 16),
      
                _TextField(
                  labelText: 'Apellido del jugador',
                  prefixIcon: Icon(Icons.person),
                  onChange: ( value ) {
                    print( value );
                  },
                ),
      
                const SizedBox(height: 16),
                
                //*Team
                _DropDownMenu(
                  labelText: 'Elija un equipo', 
                  listOfItems: ['boca', 'river', 'velez', 'independiente']),
      
                const SizedBox(height: 16),
      
                //*Team
                _DropDownMenu(
                  labelText: 'Elija su rol', 
                  listOfItems: ['primera base', 'segunda base', 'tercera base', 'lanzador']),
      
                const SizedBox(height: 16),
      
      
                //rareza
                _DropDownMenu(
                  labelText: 'Elija una rareza', 
                  listOfItems: ['gold', 'silver', 'cupper']
                ),
      
                 const SizedBox(height: 16),
      
                //serie
                _DropDownMenu(
                  labelText: 'Elija una serie', 
                  listOfItems: ['serie1', 'serie2', 'serie3']
                ),
      
                 const SizedBox(height: 56),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: (){},
      ),
    );
  }
}

class _ImageViewer extends StatelessWidget {
  
  final String? path;

  const _ImageViewer({
    this.path
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(12), 
      ),
      clipBehavior: Clip.antiAlias,
      child: Image(
        image: AssetImage( path ?? 'assets/riquelme.jpeg' ),
        fit: BoxFit.cover,
      ),
    );
  }
}


class _TextField extends StatelessWidget {

  final String? labelText;
  final Icon? prefixIcon;
  final Function(String)? onChange;

  const _TextField({
    Key? key, 
    required this.labelText,
    this.prefixIcon,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  
    return TextFormField(
      decoration: InputDecoration( 
        fillColor: Colors.grey.shade200,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        filled: true,
        // labelText: this.labelText,
        hintText: this.labelText,
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: Colors.grey.shade200)
        ),

        prefixIcon: this.prefixIcon,
      ),
      onChanged: onChange,
    );
  }
}


class _DropDownMenu extends StatelessWidget {

  final List<String> listOfItems;
  final String? labelText;
  final Icon? icon;
  String dropdownItemValue = '';
  final Function(String)? function;

  _DropDownMenu({
    this.labelText = '',
    this.icon,
    required this.listOfItems,
    this.function
  }) {
    dropdownItemValue = listOfItems[0];
  }

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<String>(
      value: dropdownItemValue,

      decoration: InputDecoration(
        prefixIcon: Icon( Icons.person ),
        labelText: labelText,
        fillColor: Colors.grey.shade200,
        filled: true,
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
           borderSide: BorderSide(color: Colors.grey.shade200)
        ),
      ),
      items: listOfItems.map((e) {
        return DropdownMenuItem<String>(
            value: e,
            child: Text( e ),
          );
      }).toList(),

      onChanged: ( value ) {
        dropdownItemValue = value!;
        
        if ( function != null)
          this.function!(value);
      },

    );
  }
}