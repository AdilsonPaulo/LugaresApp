import 'package:f05_lugares_app/model/pais.dart';
import 'package:flutter/material.dart';

class MultiSelection extends StatefulWidget{
  final List<Pais> items;
  final List<Pais> selectedItems;
  const MultiSelection({super.key, required this.items, required this.selectedItems});

  @override
  State<MultiSelection> createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  
  void _change(Pais p, bool isSelected){
    setState(() {
      if(isSelected){
        widget.selectedItems.add(p);
      } else{
        widget.selectedItems.remove(p);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Selecione os países"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items.map((item) => CheckboxListTile(
            value: widget.selectedItems.contains(item),
            title: Text(item.titulo),
             onChanged: (isChecked) => _change(item, isChecked!)))
             .toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Cancelar')),
        TextButton(onPressed: (){
          Navigator.pop(context, widget.selectedItems);
        }, child: Text('Selecionar'))
      ],
    );
  }
}