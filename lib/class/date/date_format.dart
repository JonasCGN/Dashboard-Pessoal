class DateFormat {
	static String formatDayWeekName(DateTime date){
		List<String> weekDays = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
		String dayWeekName = weekDays[date.weekday % 7];
		return dayWeekName;
	}
}