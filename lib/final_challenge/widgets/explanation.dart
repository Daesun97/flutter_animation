import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

List<Map<String, String>> coffe_explanation = [
  {'title': '커피콩의 종류', "description": ''},
  {
    'title': '아라비카 (Arabica)',
    "description":
        '아라비카 커피는 세계 커피 생산량의 약 60-70%를 차지하는 가장 인기 있는 커피 종류입니다. 고지대에서 재배되며, 기후와 토양의 영향을 많이 받아 풍부하고 복잡한 맛을 제공합니다. 신맛이 도드라지고, 향이 좋으며, 다양한 맛의 노트를 지닙니다.'
  },
  {
    'title': '로부스타 (Robusta)',
    "description":
        '로부스타 커피는 주로 저지대에서 재배되며, 병충해에 강하고 생산 비용이 저렴합니다. 아라비카에 비해 쓴맛이 강하고 카페인 함량이 높습니다. 맛이 강하고 진하며, 에스프레소 블렌드나 인스턴트 커피에 주로 사용됩니다.'
  },
  {
    'title': '리베리카 (Liberica)',
    "description":
        '리베리카 커피는 전체 커피 생산량의 극히 일부를 차지하는 드문 종류입니다. 주로 필리핀과 말레이시아 같은 특정 지역에서 재배됩니다. 독특한 꽃향기와 과일향을 지니며, 아라비카나 로부스타와는 다른 독특한 맛 프로파일을 제공합니다. 콩의 크기가 크고 불규칙한 모양을 가지며, 맛이 강하고 독특합니다.'
  }
];

class ExplainationCard extends StatelessWidget {
  const ExplainationCard({
    super.key,
    required PageController bgPageController,
    required this.size,
    required bool isAlbumTap,
  })  : _bgPageController = bgPageController,
        _isPlayPauseTap = isAlbumTap;

  final PageController _bgPageController;
  final Size size;
  final bool _isPlayPauseTap;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 100,
      bottom: 50,
      child: PageView.builder(
        controller: _bgPageController,
        pageSnapping: false,
        itemCount: coffe_explanation.length,
        itemBuilder: (context, index) => Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: size.width * 1.8,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colors_List[index],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.width - 130,
                  ),
                  Text(
                    '${coffe_explanation[index]['title']}',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      textAlign: TextAlign.start,
                      '${coffe_explanation[index]['description']}',
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate(
            target: _isPlayPauseTap ? 1 : 0,
          )
          .slideY(
            begin: 2,
            end: 0,
            duration: 1.seconds,
            curve: _isPlayPauseTap ? Curves.easeInOutCubic : Curves.easeInExpo,
          ),
    );
  }
}

List<Color> colors_List = [
  const Color(0xFFC7BCAC),
  const Color(0xFFE3B964),
  const Color(0xFF452F2B),
  const Color(0xFFAD8845)
];


// Center(
//           child: Container(
//             margin: const EdgeInsets.symmetric(horizontal: 10),
//             height: size.width * 1.8,
//             width: size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: const Color(0xFFC7BCAC),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: size.width - 130,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     coffe_explanation[index],
//                     style: const TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),