import 'package:crypto_market_cap_flutter/Models/filter.dart';
import 'package:crypto_market_cap_flutter/widgets/filter_scroll_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterContainer extends StatefulWidget {
  const FilterContainer({super.key, required this.applyFiltersAndReload});
  final Function applyFiltersAndReload;
  @override
  State<FilterContainer> createState() => _FilterContainer();
}

class _FilterContainer extends State<FilterContainer> {
  var _isVisible = false;
  late Filters filtersModel;

  @override
  void initState() {
    super.initState();
    filtersModel = Provider.of<Filters>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  child: Row(
                    children: const [
                      Text("Filters"),
                      Spacer(),
                      Icon(Icons.arrow_downward)
                    ],
                  ))),
          Visibility(
              visible: _isVisible,
              child: Column(
                children: [
                  const FilterScrollItem(filterType: FilterType.currency),
                  const FilterScrollItem(filterType: FilterType.order),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              filtersModel.saveFilters(
                                  filtersModel.currencyFilter,
                                  filtersModel.orderFilter);
                              widget.applyFiltersAndReload();
                              _isVisible = !_isVisible;
                            });
                          },
                          child: const Text("APPLY")
                      )
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}
