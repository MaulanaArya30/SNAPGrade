import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  final String title;
  final String kelas;

  const DashboardWidget({
    super.key,
    required this.title,
    required this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 80,
              color: Color(0XFF424D72),
            ),
          ),
          Expanded(
            flex: 34,
            child: Container(
              padding: EdgeInsets.all(20),
              height: 80,
              decoration: BoxDecoration(
                color: Color(0XFFEDEEF0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Kelas : $kelas',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
