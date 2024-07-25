import 'package:example/example_candidate_model.dart';
import 'package:example/example_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'number_card.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Example(),
    ),
  );
}

class Example extends StatefulWidget {
  const Example({
    super.key,
  });

  @override
  State<Example> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<Example> {
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map((e)=>NumberCard(e, 110.0)).toList();
  List<Widget> numberOneList = [];
  List<Widget> primeList = [];
  List<Widget> compositeList = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                width: 400,
                color: Colors.grey.withOpacity(0.2),
                child: Column(
                  children: [
                    Text("1", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
                    Expanded(child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                      itemBuilder: (_, index) {
                        return numberOneList[index];
                      },
                      itemCount: numberOneList.length,
                    ), )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 400,
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [
                          Text("prime", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
                          Expanded(child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                            itemBuilder: (_, index) {
                              return primeList[index];
                            },
                            itemCount: primeList.length,
                          ), )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 400,
                      child: CardSwiper(
                        controller: controller,
                        cardsCount: cards.length,
                        onSwipe: _onSwipe,
                        onUndo: _onUndo,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(16, 16),
                        padding: const EdgeInsets.all(24.0),
                        cardBuilder: (
                            context,
                            index,
                            horizontalThresholdPercentage,
                            verticalThresholdPercentage,
                            ) =>
                        cards[index],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 400,
                      color: Colors.grey.withOpacity(0.2),
                      child: Column(
                        children: [
                          Text("composite", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),),
                          Expanded(child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
                            itemBuilder: (_, index) {
                              return compositeList[index];
                            },
                            itemCount: compositeList.length,
                          ), )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: controller.undo,
                    child: const Icon(Icons.rotate_left),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.left),
                    child: const Icon(Icons.keyboard_arrow_left),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.right),
                    child: const Icon(Icons.keyboard_arrow_right),
                  ),
                  FloatingActionButton(
                    onPressed: () => controller.swipe(CardSwiperDirection.top),
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                  FloatingActionButton(
                    onPressed: () =>
                        controller.swipe(CardSwiperDirection.bottom),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    switch(direction){
      case CardSwiperDirection.top:
        setState(() {
          numberOneList.add(NumberCard(candidates[previousIndex], 36));
        });
      case CardSwiperDirection.left:
        setState(() {
          primeList.add(NumberCard(candidates[previousIndex], 36));
        });
      case CardSwiperDirection.right:
        setState(() {
          compositeList.add(NumberCard(candidates[previousIndex], 36));
        });
      case CardSwiperDirection.none:
        break;
      case CardSwiperDirection.bottom:
        break;
    }
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undoed from the ${direction.name}',
    );
    setState(() {
      numberOneList = [];
      primeList = [];
      compositeList = [];
    });
    return true;
  }
}
