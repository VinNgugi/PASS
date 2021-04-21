codeunit 51513027 "Leave Year-Close"
{
    trigger OnRun()
    var
        Rec: Record "HR Leave Periods";
    begin
        AccountingPeriod.COPY(Rec);

        Code();

        Rec := AccountingPeriod;

    end;

    local procedure Code()
    var
        myInt: Integer;
    begin
        WITH AccountingPeriod DO BEGIN
            AccountingPeriod.SETRANGE(Closed, FALSE);
            AccountingPeriod.FINDFIRST;
            FiscalYearStartDate := AccountingPeriod."Starting Date";
            FiscalYearEndDate := AccountingPeriod."Ending Date";

            IF NOT CONFIRM(Text002 + Text003 + Text004, FALSE, FiscalYearStartDate, FiscalYearEndDate) THEN
                EXIT;

            Window.OPEN('#1#################################### :' + '@2@@@@@@@@@@@@@@@' + 'Record:#3###############');
            UpdateMsg := 'Initiating Process';
            Window.UPDATE(1, UpdateMsg);

            FnCreateNewYear;
            FncloseEmployeeLeaveEntries;

            Window.CLOSE;
            FnPostLeaveLedgerEntries;

            //*******Mark period as closed**************//
            FnCloseLeaveLedgerEntries;

            RESET;
            SETRANGE("Starting Date", FiscalYearStartDate);
            MODIFYALL(Closed, TRUE);

            SETRANGE("Starting Date", FiscalYearStartDate);
            MODIFYALL("Date Locked", TRUE);

            RESET;
        END;
        //Window.CLOSE;
        MESSAGE('Leave period %1 Closed. you are now in %2 Leave Period.', DATE2DMY(FiscalYearEndDate, 3), DATE2DMY(CALCDATE('1D', FiscalYearEndDate), 3));
    end;

    local procedure FncloseEmployeeLeaveEntries()
    var
        ObjEmployee: Record Employee;
        ObjLeaveTypes: Record "Leave Types";
        LeaveBalance: Decimal;
        CarryOver: Decimal;
        CodeFactory: Codeunit "Code Factory";
        ObjJnLine: Record "HR Journal Line";
        ObjHRSetup: Record "Human Resources Setup";
        LineNum: Integer;
        DocNoClose: Code[20];
        DocNoOpen: Code[20];
        CurrPeriod: Code[20];
        NewPeriod: Code[20];
        LeaveEntitlement: Decimal;
    begin
        LeaveBalance := 0;
        CarryOver := 0;
        LineNum := 0;
        JTemplate := 'LEAVE';
        JBatchClose := 'CLOSURE';
        JBatchOpen := 'LEAVEALLOC';
        CurrPeriod := FORMAT(DATE2DMY(FiscalYearEndDate, 3));
        NewPeriod := FORMAT(DATE2DMY(CALCDATE('1D', FiscalYearEndDate), 3));
        DocNoClose := 'CLOSE' + CurrPeriod;
        DocNoOpen := 'OPEN' + NewPeriod;

        ObjHRSetup.GET();

        ObjJnLine.RESET;
        ObjJnLine.SETRANGE("Journal Template Name", ObjHRSetup."Leave Template");
        ObjJnLine.SETFILTER("Journal Batch Name", '%1|%2', JBatchClose, JBatchOpen);
        ObjJnLine.DELETEALL(TRUE);


        ObjEmployee.RESET;
        ObjEmployee.SETRANGE(Status, ObjEmployee.Status::Active);
        IF ObjEmployee.FINDSET THEN
            TotalCount := ObjEmployee.COUNT;
        REPEAT
            Percentage := (ROUND(Counter / TotalCount * 10000, 1));
            Counter := Counter + 1;
            UpdateMsg := 'Closing Employee : ' + ObjEmployee."No.";
            Window.UPDATE(1, UpdateMsg);
            Window.UPDATE(2, Percentage);
            Window.UPDATE(3, Counter);
            //************************Get Balances as per Leave type***********************//
            ObjLeaveTypes.RESET;
            ObjLeaveTypes.SETRANGE(Status, ObjLeaveTypes.Status::Active);
            IF ObjEmployee.Gender = ObjEmployee.Gender::Female THEN
                ObjLeaveTypes.SETFILTER(Gender, '%1|%2', ObjLeaveTypes.Gender::Female, ObjLeaveTypes.Gender::Both)
            ELSE
                ObjLeaveTypes.SETFILTER(Gender, '%1|%2', ObjLeaveTypes.Gender::Male, ObjLeaveTypes.Gender::Both);
            if ObjEmployee."Employment Status" = ObjEmployee."Employment Status"::Confirmed then
                ObjLeaveTypes.SetFilter("Eligible Staff", '%1|%2', ObjLeaveTypes."Eligible Staff"::Both, ObjLeaveTypes."Eligible Staff"::Permanent)
            else
                ObjLeaveTypes.SetFilter("Eligible Staff", '%1', ObjLeaveTypes."Eligible Staff"::Temporary);
            IF ObjLeaveTypes.FINDSET THEN
                REPEAT
                    ObjEmployee.SETFILTER("Date Filter", '%1..%2', FiscalYearStartDate, FiscalYearEndDate);
                    ObjEmployee.SETRANGE("Leave Type Filter", ObjLeaveTypes.Code);
                    ObjEmployee.CALCFIELDS("Balance Carried Forward", "Total Leavedays Allocated", "Total Leavedays Taken", "Total Recalled Days", "Total Credited Back");
                    LeaveBalance := ((ObjEmployee."Balance Carried Forward" + ObjEmployee."Total Leavedays Allocated" + ObjEmployee."Total Recalled Days" + ObjEmployee."Total Credited Back") - ObjEmployee."Total Leavedays Taken");

                    CASE ObjEmployee."Employment Status" OF
                        ObjEmployee."Employment Status"::Confirmed:
                            BEGIN
                                LeaveEntitlement := ObjLeaveTypes.Days;
                            END;
                        ObjEmployee."Employment Status"::Probation:
                            BEGIN
                                LeaveEntitlement := ObjLeaveTypes."Days for Unconfirmed";
                            END;
                    END;


                    CASE ObjLeaveTypes.Balance OF
                        ObjLeaveTypes.Balance::"Carry Forward":
                            BEGIN
                                IF LeaveBalance > ObjLeaveTypes."Max Carry Forward Days" THEN
                                    CarryOver := ObjLeaveTypes."Max Carry Forward Days"
                                ELSE
                                    CarryOver := LeaveBalance;

                                //*************************************Create Closure Debit Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchClose, DocNoClose, ObjEmployee."No.", CurrPeriod, FiscalYearEndDate, ObjJnLine."Leave Entry Type"::Negative,
                                              FiscalYearEndDate, 'Leave Period Closure', ObjLeaveTypes.Code, LeaveBalance, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Reversal);
                                //*************************************Create Closure Debit Entry****************************//

                                //*************************************Create Carry Over Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchOpen, DocNoOpen, ObjEmployee."No.", NewPeriod, CALCDATE('1D', FiscalYearEndDate), ObjJnLine."Leave Entry Type"::Positive,
                                              CALCDATE('1D', FiscalYearEndDate), ObjLeaveTypes.Code + 'Leave carry-Over Days', ObjLeaveTypes.Code, CarryOver, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::"Carry Forward");
                                //*************************************Create Carry Over Entry****************************//

                                //*************************************Create Entitlement Allocation Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchOpen, DocNoOpen, ObjEmployee."No.", NewPeriod, CALCDATE('1D', FiscalYearEndDate), ObjJnLine."Leave Entry Type"::Positive,
                                              CALCDATE('1D', FiscalYearEndDate), ObjLeaveTypes.Code + 'Leave Allocation', ObjLeaveTypes.Code, LeaveEntitlement, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Allocation);
                                //*************************************Create Entitlement Allocation Entry****************************//

                            END;
                        ObjLeaveTypes.Balance::"Convert to Cash":
                            BEGIN
                                //*******************Code for convert to cash







                                //*************************************Create Closure Debit Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchClose, DocNoClose, ObjEmployee."No.", CurrPeriod, FiscalYearEndDate, ObjJnLine."Leave Entry Type"::Negative,
                                              FiscalYearEndDate, 'Leave Period Closure', ObjLeaveTypes.Code, LeaveBalance, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Reversal);
                                //*************************************Create Closure Debit Entry****************************//

                                //*************************************Create Entitlement Allocation Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchOpen, DocNoOpen, ObjEmployee."No.", NewPeriod, CALCDATE('1D', FiscalYearEndDate), ObjJnLine."Leave Entry Type"::Positive,
                                              CALCDATE('1D', FiscalYearEndDate), ObjLeaveTypes.Code + 'Leave Allocation', ObjLeaveTypes.Code, LeaveEntitlement, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Allocation);
                                //*************************************Create Entitlement Allocation Entry****************************//

                            END;
                        ObjLeaveTypes.Balance::Ignore:
                            BEGIN
                                //*************************************Create Closure Debit Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchClose, DocNoClose, ObjEmployee."No.", CurrPeriod, FiscalYearEndDate, ObjJnLine."Leave Entry Type"::Negative,
                                              FiscalYearEndDate, 'Leave Period Closure', ObjLeaveTypes.Code, LeaveBalance, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Reversal);
                                //*************************************Create Closure Debit Entry****************************//

                                //*************************************Create Entitlement Allocation Entry****************************//
                                LineNum := LineNum + 1000;
                                CodeFactory.FnCreateLeaveLedgerEntries(LineNum, JTemplate, JBatchOpen, DocNoOpen, ObjEmployee."No.", NewPeriod, CALCDATE('1D', FiscalYearEndDate), ObjJnLine."Leave Entry Type"::Positive,
                                              CALCDATE('1D', FiscalYearEndDate), ObjLeaveTypes.Code + 'Leave Allocation', ObjLeaveTypes.Code, LeaveEntitlement, ObjEmployee."Global Dimension 1 Code",
                                              ObjEmployee."Global Dimension 2 Code", '', FALSE, ObjJnLine."Transaction Type"::Allocation);
                                //*************************************Create Entitlement Allocation Entry****************************//
                            END;
                    END;

                UNTIL ObjLeaveTypes.NEXT = 0;
        UNTIL ObjEmployee.NEXT = 0;
    end;

    local procedure FnCreateNewYear()
    var
        myInt: Integer;
    begin
        WITH AccountingPeriod DO BEGIN
            UpdateMsg := 'Creating ' + FORMAT(DATE2DMY(CALCDATE('1D', FiscalYearEndDate), 3)) + ' Leave Year';
            Window.UPDATE(1, UpdateMsg);
            AccountingPeriod.INIT;
            AccountingPeriod."Starting Date" := CALCDATE('1D', FiscalYearEndDate);
            AccountingPeriod.VALIDATE(AccountingPeriod."Starting Date");
            //AccountingPeriod."Period Code":=FORMAT(DATE2DMY(CALCDATE('1D',FiscalYearEndDate),3));
            AccountingPeriod."New Fiscal Year" := TRUE;
            AccountingPeriod.INSERT;
        END;
    end;

    local procedure FnCloseLeaveLedgerEntries()
    var
        ObjLedgEntry: Record "HR Leave Ledger Entries";
    begin
        WITH ObjLedgEntry DO BEGIN
            SETRANGE("Leave Period", FORMAT(DATE2DMY(FiscalYearEndDate, 3)));
            MODIFYALL(Closed, TRUE);
        END;
    end;

    local procedure FnPostLeaveLedgerEntries()
    var
        ObjJnLine: Record "HR Journal Line";
    begin
        ObjJnLine.RESET;
        ObjJnLine.SETRANGE("Journal Template Name", JTemplate);
        ObjJnLine.SETRANGE("Journal Batch Name", JBatchClose);
        IF ObjJnLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Batch", ObjJnLine);
        END;

        ObjJnLine.RESET;
        ObjJnLine.SETRANGE("Journal Template Name", JTemplate);
        ObjJnLine.SETRANGE("Journal Batch Name", JBatchOpen);
        IF ObjJnLine.FIND('-') THEN BEGIN
            CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Batch", ObjJnLine);
        END;
    end;

    var
        AccountingPeriod: Record "HR Leave Periods";
        AccountingPeriod2: Record "HR Leave Periods";
        AccountingPeriod3: Record "HR Leave Periods";
        FiscalYearStartDate: Date;
        FiscalYearEndDate: Date;
        JTemplate: Code[20];
        JBatchOpen: Code[20];
        JBatchClose: Code[20];
        Window: Dialog;
        TotalCount: Integer;
        Percentage: Integer;
        Counter: Integer;
        UpdateMsg: Text;
        Text001: TextConst ENU = 'You must create a new fiscal year before you can close the old year.';
        Text002: TextConst ENU = 'This function closes the fiscal year from %1 to %2.';
        Text003: TextConst ENU = 'Once the fiscal year is closed it cannot be opened again, and the periods in the fiscal year cannot be changed.';
        Text004: TextConst ENU = 'Do you want to close the fiscal year?';
}