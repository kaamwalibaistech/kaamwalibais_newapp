import 'package:flutter/material.dart';

import '../../../assets/colors.dart';
import '../../../models/categorylist.dart';
import '../../auth/network/auth_repository.dart';

class JobsPost extends StatefulWidget {
  const JobsPost({super.key});

  @override
  State<JobsPost> createState() => _JobsPostState();
}

class _JobsPostState extends State<JobsPost> {
  @override
  void initState() {
    super.initState();
    loadCategoryUpload();
  }

  Categorylistmodel? categoryitemModel;
  String? categoryvalue;
  Future<void> loadCategoryUpload() async {
    final categorydata = await AuthRepository().getcategorynameid();
    setState(() {
      categoryitemModel = categorydata;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Job Posting",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 5, bottom: 5),
              child: Text(
                "Job Category *",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            SizedBox(
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 6, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hint: const Text("Select Category"),
                value: categoryvalue,
                items: categoryitemModel?.data.map((source) {
                  return DropdownMenuItem(
                    value: source.categoryId,
                    child: Text(source.categoryName),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    categoryvalue = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select Category'; // Validation message
                  }
                  return null; // Valid input
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 5),
              child: Text(
                "Job Location *",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.93,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Age";
                    }
                    return null;
                  },
                  // controller: ageController,
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                    hintText: "Thane, Maharashtra, India",
                    hintStyle: TextStyle(color: textGreyColor),
                    border: OutlineInputBorder(),
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
