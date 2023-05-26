package com;

import java.sql.Date;
import java.time.LocalDate;

public class MuUtil {
    private MuUtil() {
    }

    public static LocalDate convertToLocalDateViaSqlDate(Date dateToConvert) {
        return new java.sql.Date(dateToConvert.getTime()).toLocalDate();
    }
}
