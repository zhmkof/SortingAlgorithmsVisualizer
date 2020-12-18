import 'package:flutter/material.dart';
import 'package:algorithms/constants.dart';
import 'package:algorithms/widgets.dart';

class SortDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SortDetailsScreenState();
}

///https://oi-wiki.org/
///https://mp.weixin.qq.com/s/vn3KiV-ez79FmbZ36SX9lg
class SortDetailsScreenState extends State<SortDetailsScreen> {
	///随机数组
  List<int> numbers;
  List<int> pointers = [];
  ///数组长度
  int n;
  ///updateText每个步骤都更新的文本，selectedAlgorithm当前选择的算法
  String updateText, selectedAlgorithm = sortingAlgorithmsList[0].title;
  bool disableButtons = false, isSelectingDelay = false, isCancelled = false;
  double _delay = 2;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    numbers = new List<int>.generate(10, (i) => i + 1);
    n = numbers.length;
    shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AppBar(elevation: 0,
							title: Text('排序算法'),
              centerTitle: true, backgroundColor: primary
            ),
            ///可选的排序算法
            SoringAlgorithmsList(
              isDisabled: disableButtons,
              onTap: (selected) {
              	selectedAlgorithm = selected;
              	String desc;
								if (sortingAlgorithmsList[0].title == selected)
									desc = "每次找出第i小的元素，然后将这个元素与数组第i个位置上的元素交换，时间复杂度${sortingAlgorithmsList[0].complexity}\n"
											"for (int i = 1; i < n; ++i) {\n"
											"  int ith = i;\n"
											"  for (int j = i + 1; j <= n; ++j) {\n"
											"    if (a[j] < a[ith]) {\n"
											"      ith = j;\n"
											"    }\n"
											"  }\n"
											"  swap(a[i], a[ith]);\n"
											"}";
								if (sortingAlgorithmsList[1].title == selected)
									desc = '将待排列元素划分为“已排序”和“未排序”，每次从“未排序”中选择一个插入到“已排序”中的正确位置，时间复杂度${sortingAlgorithmsList[1].complexity}\n'
											'for (int i = 2; i <= n; ++i) {\n'
											'  int key = a[i];\n'
											'  int j = i - 1;\n'
											'  while (j > 0 && a[j] > key) {\n'
											'    a[j + 1] = a[j];\n'
											'    --j;\n'
											'  }\n'
											'  a[j + 1] = key;\n'
											'}\n';
								if (sortingAlgorithmsList[2].title == selected)
									desc = "每次检查相邻两个元素，如果前面的元素与后面的元素满足给定的排序条件，就将相邻两个元素交换，时间复杂度${sortingAlgorithmsList[2].complexity}\n"
											"bool flag = true;\n"
											"while (flag) {\n"
											"  flag = false;\n"
											"  for (int i = 1; i < n; ++i) {\n"
											"    if (a[i] > a[i + 1]) {\n"
											"      flag = true;\n"
											"      swap(a[i], a[i + 1]);\n"
											"    }\n"
											"  }\n"
											"}";
								setUpdateText(desc);
              }
            ),
            ///随机数组
            ChartWidget(numbers: numbers, activeElements: pointers),
            ///步骤指示器（两个箭头）
            BottomPointer(length: numbers.length, pointers: pointers),
            ///每个步骤都更新的文本
						stepDescription(),
            bottomButtons()
          ],
        ),
      ),
    );
  }

  Widget stepDescription() {
  	return Expanded(
			child: Container(
				padding: const EdgeInsets.all(16.0),
				child: Center(
					child: Text(
						updateText,
						textAlign: TextAlign.left,
						style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
					),
				),
			),
		);
	}

  Widget bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: '开始',
            backgroundColor: primaryDark,
            label: Text(disableButtons ? '取消' : '开始'),
            icon: Icon(disableButtons ? Icons.stop : Icons.play_circle_outline),
            onPressed: () {
              if (disableButtons) {
                setState(() {
                  isCancelled = true;
                });
              } else {
                selectWhichSorting();
              }
            }
          ),
          FloatingActionButton.extended(
            heroTag: '洗牌',
            backgroundColor: disableButtons ? Colors.black : primaryDark,
            label: Text('洗牌'),
            icon: Icon(Icons.shuffle),
            onPressed: () => disableButtons ? null : shuffle()
          ),
          // FloatingActionButton(
          //   heroTag: 'details',
          //   backgroundColor: primaryDark,
          //   child: Icon(Icons.info_outline),
          //   onPressed: () {
          //     showModalBottomSheet(
          //         context: context,
          //         builder: (BuildContext bc) {
          //           return Container(
          //             height: MediaQuery.of(context).size.height / 2,
          //             decoration: BoxDecoration(
          //                 color: primary,
          //                 borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(8.0),
          //                     topRight: Radius.circular(8.0))),
          //           );
          //         });
          //   },
          // ),
        ],
      ),
    );
  }

  void selectWhichSorting() {
    switch (selectedAlgorithm) {
      case bubbleSortTitle:
        bubbleSort();
        break;
      case selectionSortTitle:
        selectionSort();
        break;
      case insertionSortTitle:
        insertionSort();
        break;
      default:
        break;
    }
  }

  ///洗牌
  void shuffle() {
    setState(() {
      updateText = '点击开始按钮开始演示排序过程';
      numbers.shuffle();
    });
  }

  void updatePointers(List<int> currentPointers) {
    setState(() {
      pointers = currentPointers;
    });
  }

  void finishedSorting() {
    setState(() {
      updateText = '排序完成';
      disableButtons = false;
    });
  }

  void cancelledSorting() {
    setState(() {
      updateText = '取消排序';
      disableButtons = false;
    });
  }

  void startSorting() {
    setState(() {
      isCancelled = false;
      disableButtons = true;
      isSelectingDelay = false;
    });
  }

  void setUpdateText(String text) {
    setState(() {
      updateText = text;
    });
  }

  void swap(numbers, i, j) {
    int temp = numbers[i];
    numbers[i] = numbers[j];
    numbers[j] = temp;
  }

  //SelectionSort，每次查找都遍历一次数组
  void selectionSort() async {
    startSorting();
		setUpdateText('把第一个没有排序过的元素设置为最小值');
		await Future.delayed(Duration(seconds: 1));
    // One by one move boundary of unsorted subnumbersay
    for (int i = 0; i < n - 1; i++) {
      if (isCancelled) break;
      // Find the minimum element in unsorted numbersay
      int minIdx = i;
      setUpdateText('遍历每个没有排序过的元素，如果元素 < 现在的最小值');
      for (int j = i + 1; j < n; j++) {
        if (isCancelled) break;
        updatePointers([i, j]);
        await Future.delayed(Duration(milliseconds: 500));///等1/4秒
        if (numbers[j] < numbers[minIdx]) minIdx = j;
      }
      // Swap the found minimum element with the first element
      updatePointers([minIdx, i]);
      setUpdateText('将最小值 ${numbers[minIdx]} 和 ${numbers[i]} 交换位置');
      await Future.delayed(Duration(seconds: 1));
      swap(numbers, minIdx, i);
    }
    isCancelled ? cancelledSorting() : finishedSorting();
  }

  //Insertion Sort
  void insertionSort() async {
    startSorting();
    int i, key, j;
    updatePointers([0]);
    setUpdateText('将第一个元素标记为已排序，遍历除此之外的所有元素');
    await Future.delayed(Duration(seconds: 1));
    for (i = 1; i < n; i++) {
      if (isCancelled) break;
      updatePointers([i]);
      setUpdateText('提取元素值 ${numbers[i]}');
      await Future.delayed(Duration(seconds: 1));
      key = numbers[i];
      j = i - 1;

      while (j >= 0 && numbers[j] > key) {
        updatePointers([numbers.indexOf(key), j]);
        setUpdateText('因为 $key < ${numbers[j]}，所以把 $key 往前移动一个位置');
        await Future.delayed(Duration(seconds: 1));

        swap(numbers, j + 1, j);
        updatePointers([numbers.indexOf(key)]);
        await Future.delayed(Duration(seconds: 1));
        j = j - 1;
      }
      numbers[j + 1] = key;
    }
    isCancelled ? cancelledSorting() : finishedSorting();
  }

	//Bubble Sort
	void bubbleSort() async {
		startSorting();
		int i, step;
		for (step = 0; step < n; step++) {
			if (isCancelled) break;
			for (i = 0; i < n - step - 1; i++) {
				if (isCancelled) break;
				updatePointers([i, i + 1]);
				setUpdateText('${numbers[i]} > ${numbers[i + 1]} ?');
				await Future.delayed(Duration(seconds: (_delay ~/ 2).toInt()));
				if (numbers[i] > numbers[i + 1]) {
					swap(numbers, i, i + 1);
					setUpdateText('成立，交换元素位置');
				} else {
					setUpdateText('不成立，不需要交换位置');
				}
				await Future.delayed(Duration(seconds: (_delay ~/ 2).toInt()));
			}
		}
		isCancelled ? cancelledSorting() : finishedSorting();
	}
}
