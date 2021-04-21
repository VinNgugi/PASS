codeunit 51513054 "Effect Annual Basic Incre"
{
    // version PAYROLL


    trigger OnRun();
    var
        NoofEmployees: Integer;
        NoofEmployeesEnd: Integer;
    begin
        HRsetup.GET;
        InitialBasicSal := 0;
        ActualDiff := 0;
        DateDiff := 0;
        NoofEmployees := 0;
        NoofEmployeesEnd := 0;
        PayPeriod := 0D;


        Emp.RESET;
        //Emp.SETRANGE(Emp."No.",'0014');
        Emp.SETRANGE(Status, Emp.Status::Active);
        if Emp.FIND('-') then begin
            repeat

                /*
                DateDiff:=TODAY-Emp."Date OfJoining Payroll";
                IF DateDiff > 1 THEN
                ActualDiff:=DateDiff-1;
                Lastyear:=CALCDATE(format(ActualDiff)+'M',Emp."Date OfJoining Payroll");
                LatestDate:=CALCDATE('12M',Lastyear);
                */

                AccPeriod.RESET;
                AccPeriod.SETRANGE("Close Pay", false);
                if AccPeriod.FIND('-') then
                    PayPeriod := AccPeriod."Starting Date";


                //Day := DATE2DMY(CurrentMonth,1);
                if Emp."Date Of Join" > 20000101D then begin
                    Month := DATE2DMY(Emp."Date Of Join", 2);
                end;
                if PayPeriod > 20000101D then begin
                    Month1 := DATE2DMY(PayPeriod, 2);
                end;
                //Year := DATE2DMY(CurrentMonth,3);
                //MESSAGE(Text000,Day,Month,Year);

                if Month = Month1 then begin
                    NoofEmployees := NoofEmployees + 1;

                    if JobGroup.GET(Emp."Salary Scale") then begin

                        AssignMat.RESET;
                        AssignMat.SETRANGE("Employee No", Emp."No.");
                        AssignMat.SETRANGE("Basic Salary Code", true);
                        AssignMat.SETRANGE("Payroll Period", PayPeriod);
                        AssignMat.SETRANGE(Closed, false);
                        if AssignMat.FIND('-') then begin
                            /*
                              SalScale.RESET;
                              SalScale.SETRANGE(Archived,FALSE);
                              SalScale.SETRANGE(SalScale.Code,Emp."Salary Scale");
                              SalScale.SETRANGE("Basic Pay Range",AssignMat.Amount);
                              IF SalScale.FIND('-') THEN BEGIN
                              InitialBasicSal:=AssignMat.Amount;

                              //AssignMat.Amount:=AssignMat.Amount+SalScale."Increament Range";
                              //AssignMat.MODIFY;

                               EffectSalIn.INIT;
                               EffectSalIn.Period:=PayPeriod;
                               EffectSalIn."Initial Basic Salary":=InitialBasicSal;
                               EffectSalIn."Increased by Amount":=SalScale."Increament Range";
                               EffectSalIn."New Basic Salary":=InitialBasicSal+SalScale."Increament Range";
                               EffectSalIn.Date:=TODAY;
                               EffectSalIn.Time:=TIME;
                              // EffectSalIn.INSERT(TRUE);

                              END;
                              */
                        end;

                    end;
                end;

                //Error('%1\%2\%3',Emp."No.",Emp."First Name",Emp."Contract End Date");
                if Emp."Contract End Date" > 20010101D then begin
                    //Contract Expirery
                    Month2 := DATE2DMY(Emp."Contract End Date", 2);
                    if PayPeriod <> 0D then begin
                        Month3 := DATE2DMY(PayPeriod, 2);

                        if Month2 = Month3 then begin
                            NoofEmployeesEnd := NoofEmployeesEnd + 1;
                            Emp.Status := Emp.Status::Inactive;
                            Emp.MODIFY;
                        end;
                    end;
                end;
            until Emp.NEXT = 0;

            //Salary Increment Notification
            //if NoofEmployees > 0 then
            //IncreamentNotification(Emp, PayPeriod, NoofEmployees);

            //Employees Contract End
            //if NoofEmployeesEnd > 0 then
            // EndofContractNotification(Emp, PayPeriod, NoofEmployeesEnd);


        end;

    end;

    var
        HRsetup: Record "Human Resources Setup";
        AssignMat: Record "Assignment Matrix";
        Emp: Record Employee;
        JobGroup: Record "Salary Scales";
        SalScale: Record "Salary Scales";
        EffectSalIn: Record "Effected Basic Salary Incre";
        InitialBasicSal: Decimal;
        DateDiff: Integer;
        ActualDiff: Integer;
        Lastyear: Date;
        LatestDate: Date;
        AccPeriod: Record "Payroll Period";
        PayPeriod: Date;
        Month: Integer;
        Month1: Integer;
        Month2: Integer;
        Month3: Integer;

    local procedure IncreamentNotification(var EmpRec: Record Employee; PeriodMonth: Date; NoofEmployees: Integer);
    var
        Subject: Text[250];
        Body: Text[250];
        CCName: Text[30];
        SMTPMail: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipients: Text[250];
        HRSetup: Record "Human Resources Setup";
        CompInfo: Record "Company Information";
    begin
        HRSetup.GET;

        Subject := 'STAFF SALARY INCREMENT ';
        Body := 'Dear Sir/Madam,<br><br>This is to notify you that ' + FORMAT(NoofEmployees) + ' Employees are due for increment in the next period - ' + FORMAT(PeriodMonth) + '.<br><br>Thank you very much.<br><br>Kind regards,<br><br>NEMA SYSTEM.';
        CompInfo.GET;
        SenderAddress := CompInfo."Administrator Email";
        SenderName := CompInfo.Name;//Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";

        Recipients := HRSetup."Payroll Administrator Email";
        SMTPMail.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
        SMTPMail.Send;
    end;

    local procedure EndofContractNotification(var EmpRec: Record Employee; PeriodMonth: Date; NoofEmployees: Integer);
    var
        Subject: Text[250];
        Body: Text[250];
        CCName: Text[30];
        SMTPMail: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        SenderName: Text[250];
        SenderAddress: Text[250];
        Recipients: Text[250];
        HRSetup: Record "Human Resources Setup";
        CompInfo: Record "Company Information";
    begin
        HRSetup.GET;

        Subject := 'STAFF END OF CONTRACT ';
        Body := 'Dear Sir/Madam,<br><br>This is to notify you that ' + FORMAT(NoofEmployees) + ' Employees Contracts are expiring next period -' + FORMAT(PeriodMonth) + '.<br><br>Thank you very much.<br><br>Kind regards,<br><br>NEMA SYSTEM.';
        CompInfo.GET;
        SenderAddress := CompInfo."Administrator Email";
        SenderName := CompInfo.Name;//Emp."First Name"+' '+Emp."Middle Name"+' '+Emp."Last Name";

        Recipients := HRSetup."Payroll Administrator Email";
        SMTPMail.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);
        SMTPMail.Send;
    end;
}

