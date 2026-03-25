package com.kh.jipshop.admin.model.vo;

public class AdminOrderSearch {

    private String startYear;
    private String startMonth;
    private String startDay;

    private String endYear;
    private String endMonth;
    private String endDay;

    public AdminOrderSearch() {}

    public String getStartYear() {
        return startYear;
    }

    public void setStartYear(String startYear) {
        this.startYear = startYear;
    }

    public String getStartMonth() {
        return startMonth;
    }

    public void setStartMonth(String startMonth) {
        this.startMonth = startMonth;
    }

    public String getStartDay() {
        return startDay;
    }

    public void setStartDay(String startDay) {
        this.startDay = startDay;
    }

    public String getEndYear() {
        return endYear;
    }

    public void setEndYear(String endYear) {
        this.endYear = endYear;
    }

    public String getEndMonth() {
        return endMonth;
    }

    public void setEndMonth(String endMonth) {
        this.endMonth = endMonth;
    }

    public String getEndDay() {
        return endDay;
    }

    public void setEndDay(String endDay) {
        this.endDay = endDay;
    }

    public String getStartDate() {
        if(startYear == null || startYear.equals("") ||
           startMonth == null || startMonth.equals("") ||
           startDay == null || startDay.equals("")) {
            return null;
        }

        return startYear + "-"
                + String.format("%02d", Integer.parseInt(startMonth)) + "-"
                + String.format("%02d", Integer.parseInt(startDay));
    }

    public String getEndDate() {
        if(endYear == null || endYear.equals("") ||
           endMonth == null || endMonth.equals("") ||
           endDay == null || endDay.equals("")) {
            return null;
        }

        return endYear + "-"
                + String.format("%02d", Integer.parseInt(endMonth)) + "-"
                + String.format("%02d", Integer.parseInt(endDay));
    }

    @Override
    public String toString() {
        return "AdminOrderSearch [startYear=" + startYear + ", startMonth=" + startMonth + ", startDay=" + startDay
                + ", endYear=" + endYear + ", endMonth=" + endMonth + ", endDay=" + endDay + "]";
    }
}