import 'package:crypto_market_cap_flutter/Models/filter.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatefulWidget {
  const FilterContainer({super.key});
  
  @override
  State<FilterContainer> createState() => _FilterContainer();
}

class _FilterContainer extends State<FilterContainer> {

  var _isVisible = false;
  var currencyFilterList = CurrencyFilter.values;
  var orderFilterList = OrderFilter.values;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(width: double.infinity, height: 50, child: 
          ElevatedButton(onPressed: () {
              setState(() {
                  _isVisible = !_isVisible;
              });
            }, 
            child: Row(children: const [
              Text("Filters"), 
              Spacer(),
              Icon(Icons.arrow_downward)
            ],)
          )
        ),
          
          Visibility(visible: _isVisible, 
            child: 
            Column(children: [
              SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    controller: ScrollController(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.end,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          runAlignment: WrapAlignment.spaceEvenly,
                          children: [
                            for (CurrencyFilter filter in currencyFilterList)
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(filter.currencySymbol))
                          ]),
                    ),
                  ),

                   SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    controller: ScrollController(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1.1,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.end,
                          spacing: 5.0,
                          runSpacing: 5.0,
                          runAlignment: WrapAlignment.spaceEvenly,
                          children: [
                            for (OrderFilter filter in orderFilterList)
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(filter.orderStringForFilter))
                          ]),
                    ),
                  ),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  }, child: const Text("APPLY"))
            ],)
          )
      ],),
    );
  }
}
