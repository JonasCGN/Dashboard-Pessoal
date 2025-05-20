import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateFormatString {
	static String formatDayWeekName(DateTime date){
		List<String> weekDays = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
		String dayWeekName = weekDays[date.weekday % 7];
		return dayWeekName;
	}
	static String formatMonthName(DateTime date) {
		initializeDateFormatting('pt_BR');

		String monthName = DateFormat('MMM', 'pt_BR')
			.format(date).replaceFirst('.', '')
			.replaceFirstMapped(RegExp(r'^\w'), (match) => match.group(0)!.toUpperCase());

		if(date.year != DateTime.now().year){
			monthName += "/${date.year.toString().substring(2)}";
		}

		return monthName;
	}
}