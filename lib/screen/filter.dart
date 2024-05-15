import 'package:employeeforumsassignment/provider/postprovider.dart';
import 'package:employeeforumsassignment/utils/colors_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget{
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selected = '';
  final List<String> category = ['Sports', 'Concert'];

  void changedSelected(String value){
    setState(() {
      selected = value;
    });
  }

  void getFilter(){
    final postProvider = Provider.of<PostProvider>(context, listen:false);
    setState(() {
      selected = postProvider.filter;
    });
  }

  Future applyFilter() async {
    final postProvider = Provider.of<PostProvider>(context, listen:false);
    await postProvider.applyFilter(selected);
  }

  Future clearFilter() async {
    final postProvider = Provider.of<PostProvider>(context, listen:false);
    setState(() {
      selected = '';
    });
    await postProvider.applyFilter('');
  }

  @override
  void initState(){
    super.initState();
    getFilter();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back, color: blackText),
          ),
          title: Text("FILTER", style: GoogleFonts.roboto(color: textColor, fontSize: 18, fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListTile(title: Text("Choose Event Category:", style: GoogleFonts.roboto(color: textColor, fontSize: 18, fontWeight: FontWeight.w500),),),
            Expanded(
              child: ListView.builder(
                itemCount: category.length,
                itemBuilder: (context, index){
                  return RadioListTile(
                      title: Text(category[index]),
                      value: category[index].toLowerCase(),
                      groupValue: selected,
                      onChanged: (value){
                        changedSelected(value!);
                      }
                  );
                },
              ),
            ),
            InkWell(
              onTap: () async {
                await applyFilter();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                margin: const EdgeInsets.fromLTRB(9, 15, 9, 15),
                height: 80,
                width: double.infinity,
                child: Center(child: Text("Apply", style: GoogleFonts.roboto(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),)),
              ),
            ),
            InkWell(
              onTap: () async {
                await clearFilter();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: greyColor,
                ),
                margin: const EdgeInsets.fromLTRB(9, 15, 9, 15),
                height: 80,
                width: double.infinity,
                child: Center(child: Text("Clear", style: GoogleFonts.roboto(color: textColor, fontSize: 16, fontWeight: FontWeight.w400),),),
              ),
            ),
          ],
        )
      ),
    );
  }
}