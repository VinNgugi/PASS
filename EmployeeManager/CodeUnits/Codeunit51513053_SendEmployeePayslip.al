codeunit 51513053 "Send Employee Payslip"
{
    // version PAYROLL


    trigger OnRun();
    var
        emprec9: Record Employee;
        assignmatrix: Record "Assignment Matrix";
    begin
        ERROR('ERROR CODE F45X4512: This function is currently blocked ');
        userchoice := DIALOG.STRMENU('All,One', 1, 'Please Select whether to send to All or One Employee:');
        if userchoice = 1 then begin


            if PAGE.RUNMODAL(51511085, periodrec) = ACTION::LookupOK then begin
                payslipperiod := periodrec."Starting Date";
                PeriodMonth := periodrec.Name;
                periodrec7.RESET;
                periodrec7.SETFILTER(periodrec7."Starting Date", '%1', payslipperiod);
                if periodrec7.FINDSET then begin
                    periodrec8.RESET;
                    periodrec8.SETFILTER(periodrec8.Sendslip, '%1', true);
                    if periodrec8.FINDSET then
                        repeat
                            periodrec8.Sendslip := false;
                            periodrec8.NEXT := 0;
                            periodrec8.MODIFY;
                        until periodrec8.NEXT = 0;

                    periodrec9.RESET;
                    periodrec9.SETFILTER(periodrec9."Starting Date", '%1', payslipperiod);
                    if periodrec9.FINDSET then begin
                        periodrec9.Sendslip := true;
                        periodrec9.MODIFY;
                    end;
                end;
            end;
        end;

        if userchoice = 2 then begin

            if PAGE.RUNMODAL(5201, employeerec) = ACTION::LookupOK then
                empployeeno := employeerec."No.";

            if PAGE.RUNMODAL(51511085, periodrec) = ACTION::LookupOK then begin
                payslipperiod := periodrec."Starting Date";
                PeriodMonth := periodrec.Name;
                periodrec7.RESET;
                periodrec7.SETFILTER(periodrec7."Starting Date", '%1', payslipperiod);
                if periodrec7.FINDSET then begin
                    periodrec8.RESET;
                    periodrec8.SETFILTER(periodrec8.Sendslip, '%1', true);
                    if periodrec8.FINDSET then
                        repeat
                            periodrec8.Sendslip := false;
                            periodrec8.NEXT := 0;
                            periodrec8.MODIFY;
                        until periodrec8.NEXT = 0;

                    periodrec9.RESET;
                    periodrec9.SETFILTER(periodrec9."Starting Date", '%1', payslipperiod);
                    if periodrec9.FINDSET then begin
                        periodrec9.Sendslip := true;
                        periodrec9.MODIFY;
                    end;
                end;
            end;
        end;

        // WITH Emp DO BEGIN
        HRSetup.GET;
        HRSetup.TESTFIELD("Payroll Administrator Email");
        SenderAddress := HRSetup."Payroll Administrator Email";


        SenderName := COMPANYNAME;

        PayPeriod.RESET;
        PayPeriod.SETRANGE(PayPeriod.Closed, false);
        if PayPeriod.FIND('-') then begin

            CurrentMonth := PayPeriod."Starting Date";
            //=========================================
            CurrentMonth := payslipperiod;
            //=========================================
            if payslipperiod <> 0D then begin
                CurrentMonth := payslipperiod;
            end;
            //PeriodMonth:=PayPeriod.Name;

            Day := DATE2DMY(CurrentMonth, 1);
            Month := DATE2DMY(CurrentMonth, 2);
            Year := DATE2DMY(CurrentMonth, 3);
            //MESSAGE(Text000,Day,Month,Year);
            //MESSAGE('%1',CurrentMonth);
        end;

        if CONFIRM('Are you sure you want to Send Employee Payslip for the Period  ' + PeriodMonth + ' Year, ' + FORMAT(Year) + ' ?') = true then begin



            Employee.RESET;
            //Employee.SETRANGE(Employee."No.",'20140008180');
            if empployeeno <> '' then begin
                Employee.SETFILTER(Employee."No.", empployeeno);
                progresslog.OPEN('Processing for Employee: ##1#####');
            end;
            if empployeeno = '' then begin
                //Employee.SETFILTER(Employee."No.",'<>%1','');
                // Employee.SETFILTER(Employee."No.",'%1..%2','0014','0020');
                // Employee.SETFILTER(Employee."No.",'%1|%2','0404','0474');
                progresslog.OPEN('Processing for Employee(s): ##1#####');
                //ERROR('...1');
            end;



            Employee.SETFILTER(Employee."Pay Period Filter", '%1', CurrentMonth);
            Employee.SETFILTER(Employee."E-Mail", '<>%1', '');
            if Employee.FINDSET then begin
                repeat
                    assignmatrix.RESET;
                    assignmatrix.SETFILTER(assignmatrix."Employee No", Employee."No.");
                    assignmatrix.SETFILTER(assignmatrix.Type, '%1', assignmatrix.Type::Payment);
                    //assignmatrix.SETFILTER(assignmatrix.Code,'001');
                    assignmatrix.SETFILTER(assignmatrix."Payroll Period", '%1', CurrentMonth);
                    if assignmatrix.FINDSET then begin
                        //ERROR('...2');

                        Subject := STRSUBSTNO('REF: Payslip for the Period  ' + PeriodMonth + FORMAT(Year));
                        Body := STRSUBSTNO('Dear %1,<br><br> Please receive Payslip for the month of %2, %3.<br><br> Kind regards,<br><br> %4');

                        Body := STRSUBSTNO(Body, Employee."First Name", PeriodMonth, Year, SenderName);
                        Recipients := Employee."E-Mail";
                        SMTPSetup.CreateMessage('Payroll', SenderAddress, Recipients, Subject, Body, true); //1..
                                                                                                            //FileName:=FileMangement.ServerTempFileName('.pdf');
                                                                                                            //FileName:='Payslip.pdf';

                        //SLEEP(3000);
                        //MESSAGE('%1',Employee."No.");
                        emprec9.RESET;
                        emprec9.SETFILTER(emprec9."No.", Employee."No.");
                        if emprec9.FINDSET then begin
                            REPORT.SAVEASPDF(REPORT::"New Payslip", 'C:\Payslips\Payslip_' + Employee."No." + '.pdf', emprec9);
                        end;
                        //filecu.CopyClientFile(FileName,'C:\Payslips\Payslip.pdf',TRUE);
                        SMTPSetup.AddAttachment('C:\Payslips\Payslip_' + Employee."No." + '.pdf', ''); //3...
                        SMTPSetup.Send; //2..
                                        /*
                                        //Insert Email
                                         EmailRec.INIT;
                                         EmailRec.Code:='';
                                         EmailRec."Recepient Email":=Recipients;
                                         EmailRec."Sender Email":=SenderAddress;
                                         EmailRec."Subject REF":=Subject;
                                         EmailRec."Date Sent":=TODAY;
                                         EmailRec.Sender:=SenderName;
                                         EmailRec."Time Sent":=TIME;
                                         EmailRec.INSERT(TRUE);
                                         */
                        progresslog.UPDATE(1, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");
                    end;

                until Employee.NEXT = 0;

                progresslog.CLOSE;

            end;

            MESSAGE('Generation & Mailing Complete...');
        end;


        //END;

    end;

    var
        AvailToPromise: Codeunit "Available to Promise";
        Demand: Decimal;
        Supply: Decimal;
        NewItem: Record Item;
        QtyAvailable: Decimal;
        SMTPSetup: Codeunit "SMTP Mail";
        CompanyInfo: Record "Company Information";
        UserSetup: Record "User Setup";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        Customer: Record Customer;
        CustStatement: Report Statement;
        FileName: Text[250];
        AccPeriod: Record "Accounting Period";
        NextMonth: Date;
        First5thDay: Date;
        First20thDay: Date;
        Next5thDay: Date;
        Next20thDay: Date;
        i: Integer;
        ToFile: Text[50];
        FileMangement: Codeunit "File Management";
        Customer2: Record Customer;
        StartDate: Date;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Emp: Record Employee;
        Employee: Record Employee;
        CurrentMonth: Date;
        PayPeriod: Record "Payroll Period";
        PeriodMonth: Text;
        Text000: Label 'Payslip For Day %1 of Month %2 of the Year %3.';
        EmailRec: Record "Email Sent";
        Day: Integer;
        Month: Integer;
        Year: Integer;
        HRSetup: Record "Human Resources Setup";
        userchoice: Integer;
        employeerec: Record Employee;
        periodrec: Record "Payroll Period";
        periodrec7: Record "Payroll Period";
        periodrec8: Record "Payroll Period";
        periodrec9: Record "Payroll Period";
        payslipperiod: Date;
        empployeeno: Code[40];
        employeePeriod: Date;
        Filerec: Record File;
        filecu: Codeunit "File Management";
        progresslog: Dialog;

    procedure SendIndividualPayslip(var EmpRec: Record Employee);
    begin

        with EmpRec do begin
            HRSetup.GET;
            HRSetup.TESTFIELD("Payroll Administrator Email");
            SenderAddress := HRSetup."Payroll Administrator Email";

            SenderName := COMPANYNAME;

            PayPeriod.RESET;
            PayPeriod.SETRANGE(PayPeriod.Closed, false);
            if PayPeriod.FIND('-') then begin

                CurrentMonth := PayPeriod."Starting Date";
                PeriodMonth := PayPeriod.Name;

                Day := DATE2DMY(CurrentMonth, 1);
                Month := DATE2DMY(CurrentMonth, 2);
                Year := DATE2DMY(CurrentMonth, 3);

                if CONFIRM('Are you sure you want to Send Employee Payslip for the Period  ' + PeriodMonth + ' Year, ' + FORMAT(Year) + ' ?') = true then begin

                    Subject := STRSUBSTNO('REF: Payslip for the Period  ' + PeriodMonth + FORMAT(Year));
                    Body := STRSUBSTNO('Dear %1,<br><br> Please receive Payslip for the month of %2, %3.<br><br> Kind regards,<br><br> %4');

                    Employee.RESET;
                    Employee.SETRANGE(Employee."No.", "No.");
                    Employee.SETRANGE(Employee."Pay Period Filter", CurrentMonth);
                    //Employee.SETFILTER(Employee."E-Mail",'<>%1','');
                    if Employee.FIND('-') then begin
                        Employee.TESTFIELD("E-Mail");
                        Body := STRSUBSTNO(Body, Employee."First Name", PeriodMonth, Year, SenderName);
                        Recipients := Employee."E-Mail";
                        SMTPSetup.CreateMessage(SenderName, SenderAddress, Recipients, Subject, Body, true);

                        FileName := FileMangement.ServerTempFileName('.pdf');

                        //FileName:='Payslip.pdf';
                        REPORT.SAVEASPDF(REPORT::"New Payslipx Send to Emp", FileName, Employee);
                        filecu.CopyClientFile(FileName, 'C:\Payslips\Payslip.pdf', true);
                        SMTPSetup.AddAttachment(FileName, '');
                        SMTPSetup.Send;

                        //Insert Email
                        EmailRec.INIT;
                        EmailRec.Code := '';
                        EmailRec."Recepient Email" := Recipients;
                        EmailRec."Sender Email" := SenderAddress;
                        EmailRec."Subject REF" := Subject;
                        EmailRec."Date Sent" := TODAY;
                        EmailRec.Sender := SenderName;
                        EmailRec."Time Sent" := TIME;
                        EmailRec.INSERT(true);

                    end;

                end;

            end;
        end;
    end;
}

