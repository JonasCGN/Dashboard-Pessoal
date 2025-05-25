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

	static String traduzDate(DateTime selecioned) {
		final now = DateTime.now();
		final today = DateTime(now.year, now.month, now.day);
		final selectedDay = DateTime(selecioned.year, selecioned.month, selecioned.day);

		if (selectedDay == today) {
			return "Hoje";
		} else if (selectedDay == today.subtract(Duration(days: 1))) {
			return "Ontem";
		} else if (selectedDay == today.add(Duration(days: 1))) {
			return "Amanhã";
		} else if (selectedDay.year == today.year && selectedDay.month == today.month) {
			return "${selectedDay.day}/${selectedDay.month}";
		} else {
			return "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}";
		}
	}
}