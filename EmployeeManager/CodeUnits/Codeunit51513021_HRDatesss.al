codeunit 51513021 "HR Datesss"
{
    // version HR


    trigger OnRun();
    begin
    end;

    var
        dayOfWeek: Integer;
        weekNumber: Integer;
        year: Integer;
        weekends: Integer;
        NextDay: Date;
        TEXTDATE1: Label 'The Start date cannot be Greater then the end Date.';

    procedure DetermineAge(DateOfBirth: Date; DateOfJoin: Date) AgeString: Text[45];
    var
        dayB: Integer;
        monthB: Integer;
        yearB: Integer;
        dayJ: Integer;
        monthJ: Integer;
        yearJ: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsToBirth: Integer;
        D: Date;
        DateCat: Integer;
    begin
        if ((DateOfBirth <> 0D) and (DateOfJoin <> 0D)) then begin
            dayB := DATE2DMY(DateOfBirth, 1);
            monthB := DATE2DMY(DateOfBirth, 2);
            yearB := DATE2DMY(DateOfBirth, 3);
            dayJ := DATE2DMY(DateOfJoin, 1);
            monthJ := DATE2DMY(DateOfJoin, 2);
            yearJ := DATE2DMY(DateOfJoin, 3);
            Day := 0;
            Month := 0;
            Year := 0;
            DateCat := DateCategory(dayB, dayJ, monthB, monthJ, yearB, yearJ);
            case (DateCat) of
                1:
                    begin
                        Year := yearJ - yearB;
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            Year := Year - 1;
                        end;

                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                Month := Month - 1;
                            end;

                        AgeString := '%1  Years, %2  Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);

                    end;

                2, 3, 7:
                    begin
                        if (monthJ <> monthB) then begin
                            if monthJ >= monthB then
                                Month := monthJ - monthB
                            //  ELSE ERROR('The wrong date category!');
                        end;

                        if (dayJ <> dayB) then begin
                            if (dayJ >= dayB) then
                                Day := dayJ - dayB
                            else
                                if (dayJ < dayB) then begin
                                    Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                    Month := Month - 1;
                                end;
                        end;

                        AgeString := '%1  Months %2 Days';
                        AgeString := STRSUBSTNO(AgeString, Month, Day);
                    end;
                4:
                    begin
                        Year := yearJ - yearB;
                        AgeString := '#1## Years';
                        AgeString := STRSUBSTNO(AgeString, Year);
                    end;
                5:
                    begin
                        if (dayJ >= dayB) then
                            Day := dayJ - dayB
                        else
                            if (dayJ < dayB) then begin
                                Day := (DetermineDaysInMonth(monthJ, yearJ) + dayJ) - dayB;
                                monthJ := monthJ - 1;
                                Month := (monthJ + 12) - monthB;
                                yearJ := yearJ - 1;
                            end;

                        Year := yearJ - yearB;
                        AgeString := '%1  Years, %2 Months and #3## Days';
                        AgeString := STRSUBSTNO(AgeString, Year, Month, Day);
                    end;
                6:
                    begin
                        if monthJ >= monthB then
                            Month := monthJ - monthB
                        else begin
                            Month := (monthJ + 12) - monthB;
                            yearJ := yearJ - 1;
                        end;
                        Year := yearJ - yearB;
                        AgeString := '%1  Years and #2## Months';
                        AgeString := STRSUBSTNO(AgeString, Year, Month);
                    end;
                else
                    AgeString := '';
            end;
        end else
            MESSAGE('For Date Calculation Enter All Applicable Dates!');
        exit;
    end;

    procedure DifferenceStartEnd(StartDate: Date; EndDate: Date) DaysValue: Integer;
    var
        dayStart: Integer;
        monthS: Integer;
        yearS: Integer;
        dayEnd: Integer;
        monthE: Integer;
        yearE: Integer;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        monthsBetween: Integer;
        i: Integer;
        j: Integer;
        monthValue: Integer;
        monthEnd: Integer;
        p: Integer;
        q: Integer;
        l: Integer;
        DateCat: Integer;
        daysInYears: Integer;
        m: Integer;
        yearStart: Integer;
        t: Integer;
        s: Integer;
        WeekendDays: Integer;
        Holidays: Integer;
    begin
        /*         IF ((StartDate <> 0D) AND (EndDate <> 0D)) THEN BEGIN
                    Day:=0; monthValue:= 0; p:=0; q:=0; l:= 0;
                    Year:= 0; daysInYears:=0; DaysValue:= 0;
                    dayStart:= DATE2DMY(StartDate,1);
                    monthS:= DATE2DMY(StartDate,2);
                    yearS:= DATE2DMY(StartDate,3);
                    dayEnd:= DATE2DMY(EndDate,1);
                    monthE:= DATE2DMY(EndDate,2);
                    yearE:= DATE2DMY(EndDate,3);
        
                    WeekendDays:= 0;
                    AbsencePreferences.FIND('-');
                     IF (AbsencePreferences."Include Weekends" = TRUE) THEN
                       WeekendDays:= DetermineWeekends(StartDate,EndDate);
        
                    Holidays:= 0;
                    AbsencePreferences.FIND('-');
                     IF (AbsencePreferences."Include Holidays" = TRUE) THEN
                        Holidays:= DetermineHolidays(StartDate,EndDate);
        
                    DateCat := DateCategory(dayStart,dayEnd,monthS,monthE,yearS,yearE);
                    CASE (DateCat) OF
                        1: BEGIN
                            p:=0; q:=0;
                            Year := yearE - yearS;
                            yearStart := yearS;
                            t := 1; s := 1;
                            IF (monthE <> monthS) THEN BEGIN
        
                             FOR j := 1 TO (monthS - 1) DO BEGIN
                                 q := q + DetermineDaysInMonth(t,yearS);
                                 t := t+1;
                             END;
                                 q:= q + dayStart;
        
                             FOR i := 1 TO (monthE - 1) DO BEGIN
                                 p := p + DetermineDaysInMonth(s,yearE);
                                 s:= s+1;
                             END;
                                 p:= p + dayEnd;
        
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
                                DaysValue := (((daysInYears - q) + p) - WeekendDays) - Holidays;
                             END;
                           END;
        
                        2,7 : BEGIN
                              FOR l := (monthS + 1) TO (monthE - 1) DO
                                  DaysValue:= DaysValue + DetermineDaysInMonth(l,yearS);
                              DaysValue:= ((DaysValue + (DetermineDaysInMonth(monthS,yearS) - dayStart) + dayEnd)- WeekendDays)- Holidays;
                              END;
        
                        3: BEGIN
                             IF (dayEnd >= dayStart) THEN
                                DaysValue:= dayEnd - dayStart - WeekendDays - Holidays
                                ELSE IF (dayEnd = dayStart) THEN DaysValue:= 0
                                ELSE DaysValue:= ((dayStart - dayEnd) - WeekendDays) - Holidays;
        
                           END;
        
                        4: BEGIN
                            DaysValue:= 0;
                            Year:= yearE - yearS;
                            yearStart := yearS;
                            FOR m:= 1 TO Year DO BEGIN
                             IF (LeapYear(yearStart)) THEN daysInYears:= 366
                                 ELSE daysInYears:= 365;
                                 DaysValue:= DaysValue +  daysInYears;
                                 yearStart:= yearStart + 1;
                            END;
                            DaysValue:= (DaysValue - WeekendDays) - Holidays;
                            END;
        
                         5: BEGIN
                            Year := yearE - yearS;
                            yearStart := yearS;
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
                                DaysValue:= daysInYears;
                              IF dayEnd > dayStart THEN
                                DaysValue:= (DaysValue + (dayEnd - dayStart) - WeekendDays) - Holidays
                              ELSE IF dayStart > dayEnd THEN
                                DaysValue:= (DaysValue - (dayStart - dayEnd) - WeekendDays) - Holidays;
                            END;
        
                         6: BEGIN
                            q:= 0; p:= 0;
                            Year := yearE - yearS;
                            yearStart := yearS;
                            t := 1; s := 1;
        
                             FOR j := 1 TO monthS DO BEGIN
                                 q := q + DetermineDaysInMonth(t,yearS);
                                 t := t+1;
                             END;
        
                             FOR i := 1 TO monthE DO BEGIN
                                 p := p + DetermineDaysInMonth(s,yearE);
                                 s:= s+1;
                             END;
        
                             FOR m := 1 TO Year DO BEGIN
                                IF LeapYear(yearStart) THEN daysInYears := daysInYears + 366
                                ELSE daysInYears:= daysInYears + 365;
                                yearStart := yearStart + 1;
                             END;
        
                              DaysValue := ((daysInYears - q) + p) - WeekendDays - Holidays;
                             END;
                        ELSE DaysValue:= 0;
        
                    END;
                END ELSE MESSAGE('Enter all applicable dates for calculation!');
                    DaysValue += 1;
                    EXIT;
        */

    end;

    procedure DetermineDaysInMonth(Month: Integer; Year: Integer) DaysInMonth: Integer;
    begin
        case (Month) of
            1:
                DaysInMonth := 31;
            2:
                begin
                    if (LeapYear(Year)) then
                        DaysInMonth := 29
                    else
                        DaysInMonth := 28;
                end;
            3:
                DaysInMonth := 31;
            4:
                DaysInMonth := 30;
            5:
                DaysInMonth := 31;
            6:
                DaysInMonth := 30;
            7:
                DaysInMonth := 31;
            8:
                DaysInMonth := 31;
            9:
                DaysInMonth := 30;
            10:
                DaysInMonth := 31;
            11:
                DaysInMonth := 30;
            12:
                DaysInMonth := 31;
            else
                MESSAGE('Not valid date. The month must be between 1 and 12');
        end;

        exit;
    end;

    procedure DateCategory(BDay: Integer; EDay: Integer; BMonth: Integer; EMonth: Integer; BYear: Integer; EYear: Integer) Category: Integer;
    begin
        if ((EYear > BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
            Category := 1
        else
            if ((EYear = BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                Category := 2
            else
                if ((EYear = BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                    Category := 3
                else
                    if ((EYear > BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                        Category := 4
                    else
                        if ((EYear > BYear) and (EMonth = BMonth) and (EDay <> BDay)) then
                            Category := 5
                        else
                            if ((EYear > BYear) and (EMonth <> BMonth) and (EDay = BDay)) then
                                Category := 6
                            else
                                if ((EYear = BYear) and (EMonth <> BMonth) and (EDay <> BDay)) then
                                    Category := 7
                                else
                                    if ((EYear = BYear) and (EMonth = BMonth) and (EDay = BDay)) then
                                        Category := 3
                                    else
                                        if ((EYear < BYear)) then
                                            ERROR(TEXTDATE1)
                                        else begin
                                            Category := 0;
                                            //ERROR('The start date cannot be after the end date.');
                                        end;
        exit;
    end;

    procedure LeapYear(Year: Integer) LY: Boolean;
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year mod 100 = 0;
        DivByFour := Year mod 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
            LY := true
        else
            LY := false;
    end;

    procedure ReservedDates(NewStartDate: Date; NewEndDate: Date; EmployeeNumber: Code[20]) Reserved: Boolean;
    var
        OK: Boolean;
    begin
        /*                 AbsenceHoliday.SETFILTER("Employee No.",EmployeeNumber);
                         OK:= AbsenceHoliday.FIND('-');
                         REPEAT
                             IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewStartDate < AbsenceHoliday."End Date") THEN
                                Reserved := TRUE
                             ELSE
                             IF (NewEndDate < AbsenceHoliday."End Date") AND (NewEndDate > AbsenceHoliday."Start Date") THEN
                                Reserved := TRUE
                             ELSE
                             IF (NewStartDate > AbsenceHoliday."Start Date") AND (NewEndDate < AbsenceHoliday."End Date") THEN
                                Reserved := TRUE
                             ELSE Reserved := FALSE;

                         UNTIL AbsenceHoliday.NEXT = 0;
       */

    end;

    procedure DetermineWeekends(DateStart: Date; DateEnd: Date) Weekends: Integer;
    begin
        Weekends := 0;
        while (DateStart <= DateEnd) do begin
            dayOfWeek := DATE2DWY(DateStart, 1);
            if (dayOfWeek = 6) or (dayOfWeek = 7) then
                Weekends := Weekends + 1;
            NextDay := CalculateNextDay(DateStart);
            DateStart := NextDay;
        end;
    end;

    procedure CalculateNextDay(Date: Date) NextDate: Date;
    var
        today: Integer;
        month: Integer;
        year: Integer;
        nextDay: Integer;
        daysInMonth: Integer;
    begin
        today := DATE2DMY(Date, 1);
        month := DATE2DMY(Date, 2);
        year := DATE2DMY(Date, 3);
        daysInMonth := DetermineDaysInMonth(month, year);
        nextDay := today + 1;
        if (nextDay > daysInMonth) then begin
            nextDay := 1;
            month := month + 1;
            if (month > 12) then begin
                month := 1;
                year := year + 1;
            end;
        end;
        NextDate := DMY2DATE(nextDay, month, year);
    end;

    procedure DetermineHolidays(DateStart: Date; DateEnd: Date) Holiday: Integer;
    var
        NextDay: Date;
    begin
        /*        Holiday:= 0;
                WHILE (DateStart <= DateEnd) DO BEGIN
                  dayOfWeek:= DATE2DWY(DateStart,1);
                  StatutoryHoliday.FIND('-');
                  REPEAT
                   IF (DateStart = StatutoryHoliday."Non Working Dates") THEN
                      Holiday:= Holiday + StatutoryHoliday.Code;

                  UNTIL StatutoryHoliday.NEXT = 0;
                  NextDay:= CalculateNextDay(DateStart);
                  DateStart:= NextDay;
               END;
      */

    end;

    procedure ConvertDate(nDate: Date) strDate: Text[30];
    var
        lDay: Integer;
        lMonth: Integer;
        lYear: Integer;
        strDay: Text[4];
        StrMonth: Text[20];
        strYear: Text[6];
    begin
        //this function converts the date to the format required by ksps
        lDay := DATE2DMY(nDate, 1);
        lMonth := DATE2DMY(nDate, 2);
        lYear := DATE2DMY(nDate, 3);

        if lDay = 1 then begin strDay := '1st' end;
        if lDay = 2 then begin strDay := '2nd' end;
        if lDay = 3 then begin strDay := '3rd' end;
        if lDay = 4 then begin strDay := '4th' end;
        if lDay = 5 then begin strDay := '5th' end;
        if lDay = 6 then begin strDay := '6th' end;
        if lDay = 7 then begin strDay := '7th' end;
        if lDay = 8 then begin strDay := '8th' end;
        if lDay = 9 then begin strDay := '9th' end;
        if lDay = 10 then begin strDay := '10th' end;
        if lDay = 11 then begin strDay := '11th' end;
        if lDay = 12 then begin strDay := '12th' end;
        if lDay = 13 then begin strDay := '13th' end;
        if lDay = 14 then begin strDay := '14th' end;
        if lDay = 15 then begin strDay := '15th' end;
        if lDay = 16 then begin strDay := '16th' end;
        if lDay = 17 then begin strDay := '17th' end;
        if lDay = 18 then begin strDay := '18th' end;
        if lDay = 19 then begin strDay := '19th' end;
        if lDay = 20 then begin strDay := '20th' end;
        if lDay = 21 then begin strDay := '21st' end;
        if lDay = 22 then begin strDay := '22nd' end;
        if lDay = 23 then begin strDay := '23rd' end;
        if lDay = 24 then begin strDay := '24th' end;
        if lDay = 25 then begin strDay := '25th' end;
        if lDay = 26 then begin strDay := '26th' end;
        if lDay = 27 then begin strDay := '27th' end;
        if lDay = 28 then begin strDay := '28th' end;
        if lDay = 29 then begin strDay := '29th' end;
        if lDay = 30 then begin strDay := '30th' end;
        if lDay = 31 then begin strDay := '31st' end;

        if lMonth = 1 then begin StrMonth := ' January ' end;
        if lMonth = 2 then begin StrMonth := ' February ' end;
        if lMonth = 3 then begin StrMonth := ' March ' end;
        if lMonth = 4 then begin StrMonth := ' April ' end;
        if lMonth = 5 then begin StrMonth := ' May ' end;
        if lMonth = 6 then begin StrMonth := ' June ' end;
        if lMonth = 7 then begin StrMonth := ' July ' end;
        if lMonth = 8 then begin StrMonth := ' August ' end;
        if lMonth = 9 then begin StrMonth := ' September ' end;
        if lMonth = 10 then begin StrMonth := ' October ' end;
        if lMonth = 11 then begin StrMonth := ' November ' end;
        if lMonth = 12 then begin StrMonth := ' December ' end;

        strYear := FORMAT(lYear);
        //return the date
        strDate := strDay + StrMonth + strYear;
    end;
}

