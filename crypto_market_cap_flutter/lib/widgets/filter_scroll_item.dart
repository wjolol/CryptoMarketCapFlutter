import 'package:crypto_market_cap_flutter/Models/filter.dart';
import 'package:crypto_market_cap_flutter/Utility/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterScrollItem extends StatefulWidget {
  const FilterScrollItem({
    super.key,
    required this.filterType,
  });

  final FilterType filterType;

  @override
  State<FilterScrollItem> createState() => _FilterScrollItem();
}

class _FilterScrollItem extends State<FilterScrollItem> {
  late Filters filtersModel;
  var currencyFilterList = CurrencyFilter.values;
  var orderFilterList = OrderFilter.values;
  CurrencyFilter? selectedCurrency;
  OrderFilter? selectedOrder;

  @override
  void initState() {
    super.initState();
    filtersModel = Provider.of<Filters>(context, listen: false);
    selectedCurrency = filtersModel.currencyFilter;
    selectedOrder = filtersModel.orderFilter;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              if (widget.filterType == FilterType.order) ...[
                for (OrderFilter filter in orderFilterList)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedOrder = filter;
                          filtersModel.setOrderFilter = filter;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: filter == filtersModel.orderFilter
                              ? CustomColors.selectedElevateButton
                              : CustomColors.clear,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: CustomColors.selectedElevateButton))),
                      child: Text(filter.orderStringForFilter))
              ] else ...[
                for (CurrencyFilter filter in currencyFilterList)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCurrency = filter;
                          filtersModel.setCurrencyFilter = filter;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: filter == filtersModel.currencyFilter
                              ? CustomColors.selectedElevateButton
                              : CustomColors.clear,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: CustomColors.selectedElevateButton))),
                      child: Text(filter.currencySymbol))
              ]
            ]),
      ),
    );
  }
}
