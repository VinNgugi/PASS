report 51513192 "Leave Balance"
{
    // version HR

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Balance.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status = CONST(Active));
            RequestFilterFields = "No.", "Contract Type", Status, "Posting Group";
            column(No_Employee; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Balance_B_FCaptionLbl; Balance_B_FCaptionLbl)
            {
            }
            column(BalanceCaptionLbl; BalanceCaptionLbl)
            {
            }
            column(NameCaptionLbl; NameCaptionLbl)
            {
            }
            column(EntitlmentCaptionLbl; EntitlmentCaptionLbl)
            {
            }
            column(Days_TakenCaptionLbl; Days_TakenCaptionLbl)
            {
            }
            column(Days_RecalledCaptionLbl; Days_RecalledCaptionLbl)
            {
            }
            column(Days_AbsentCaptionLbl; Days_AbsentCaptionLbl)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(Entitlement; Entitlement)
            {
            }
            column(TotalRecalls; TotalRecalls)
            {
            }
            column(TotalAbsence; TotalAbsence)
            {
            }
            column(TotalTaken; TotalTaken)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(DateFilter; STRSUBSTNO('AS AT %1', DateFilter))
            {
            }

            trigger OnAfterGetRecord();
            begin
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //Balance Brought Forward;
                StartDate := CALCDATE('-CY', DateFilter);
                EndDate := CALCDATE('CY', DateFilter);
                BalanceBF := 0;
                Entitlement := 0;
                TotalTaken := 0;
                NewBalance := 0;
                if LeaveTypes.GET(Leavefilter, '128') then begin
                    Additional.RESET;
                    Additional.SETRANGE("Payroll posting Group", Employee."Posting Group");
                    Additional.SETRANGE("Leave Code", Leavefilter);
                    if Additional.FIND('-') then
                        Entitlement := Additional."Total Days Entitled";
                    Periods.RESET;
                    Periods.SETRANGE("Starting Date", StartDate);
                    Periods.SETRANGE("Ending Date", EndDate);
                    if Periods.FIND('-') then begin
                        Ledgers.RESET;
                        Ledgers.SETRANGE("Staff No.", Employee."No.");
                        Ledgers.SETRANGE("Leave Type", Leavefilter);
                        Ledgers.SETRANGE("Leave Period", Periods."Period Code");
                        Ledgers.SETFILTER("Posting Date", '<=%1', DateFilter);
                        if Ledgers.FIND('-') then begin
                            repeat
                                if Ledgers."No. of days" > 0 then
                                    NewBalance := NewBalance + Ledgers."No. of days";
                                if Ledgers."No. of days" < 0 then
                                    TotalTaken := TotalTaken + Ledgers."No. of days";
                                TotalAbsence := 0;

                            until Ledgers.NEXT = 0;
                            if NewBalance > Entitlement then
                                BalanceBF := NewBalance - Entitlement;
                            Balance := BalanceBF + Entitlement + TotalTaken + TotalRecalls + TotalAbsence;


                        end;
                    end;
                end;
                /*
                EmployeeLeaveEntitlement.RESET;
                EmployeeLeaveEntitlement.SETRANGE("Employee No","No.");
                EmployeeLeaveEntitlement.SETFILTER("Maturity Date",'>%',DateFilter);
                EmployeeLeaveEntitlement.SETRANGE("Leave Code",LeaveTypes.Code);
                IF EmployeeLeaveEntitlement.FINDFIRST THEN
                  BEGIN
                   BalanceBF:=EmployeeLeaveEntitlement."Balance Brought Forward";
                   Entitlement:=EmployeeLeaveEntitlement.Entitlement;
                   EndDate:=EmployeeLeaveEntitlement."Maturity Date";
                   StartDate:=CALCDATE('-1Y',EmployeeLeaveEntitlement."Maturity Date")+1;

                END ELSE
                BEGIN
                  EmployeeLeaves.RESET;
                  EmployeeLeaves.SETRANGE("Employee No","No.");
                  EmployeeLeaves.SETFILTER("Maturity Date",'>%',DateFilter);
                  EmployeeLeaves.SETRANGE(EmployeeLeaves."Leave Code",Leavefilter);
                  IF EmployeeLeaves.FINDFIRST THEN
                    BEGIN
                     EndDate:=EmployeeLeaves."Maturity Date";
                     StartDate:=CALCDATE('-1Y',EmployeeLeaves."Maturity Date")+1;
                   END;
               END;
            END;

            TotalTaken:=0;
            EmpLeaveApps.RESET;
            EmpLeaveApps.SETRANGE("Employee No","No.");
            EmpLeaveApps.SETRANGE("Maturity Date",EndDate);
            EmpLeaveApps.SETRANGE(Status,EmpLeaveApps.Status::Approved);
            EmpLeaveApps.SETRANGE("Leave Code",Leavefilter);
            EmpLeaveApps.SETFILTER(EmpLeaveApps."Start Date",'<=%1',DateFilter);
            IF EmpLeaveApps.FINDLAST THEN
              BEGIN REPEAT
               TotalTaken:=TotalTaken+EmpLeaveApps."Days Applied";
              UNTIL EmpLeaveApps.NEXT=0;
              END;

            TotalRecalls:=0;
            IF LeaveTypes."Annual Leave"=TRUE THEN
              BEGIN
              Recalls.RESET;
              Recalls.SETRANGE("Employee No","No.");
              Recalls.SETRANGE("Maturity Date",EndDate);
              Recalls.SETRANGE(Status,Recalls.Status::Released);
              Recalls.SETFILTER(Recalls."Recalled To",'<=%1',DateFilter);
              Recalls.CALCSUMS(Recalls."No. of Off Days");
              TotalRecalls:=Recalls."No. of Off Days";

              Absences.RESET;
              Absences.SETRANGE("Employee No","No.");
              Absences.SETRANGE("Maturity Date",EndDate);
              Absences.SETRANGE(Status,Absences.Status::Released);

              Absences.SETFILTER(Absences."Absent To",'<=%1',DateFilter);
              Absences.CALCSUMS(Absences."No. of  Days Absent");
              TotalAbsence:=Absences."No. of  Days Absent";
              Balance:=BalanceBF+Entitlement-TotalTaken+TotalRecalls-TotalAbsence;
            END;
            */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Date Filter"; DateFilter)
                {
                }
                field(LeaveFilter; Leavefilter)
                {
                    TableRelation = "Leave Types".Code;

                    /*trigger OnLookup(Text: Text): Boolean;
                    begin
                        LeaveTypes.RESET;
                        if PAGE.RUNMODAL(51513154, LeaveTypes) = ACTION::LookupOK then
                            Leavefilter := LeaveTypes.Code;
                    end;*/
                }
            }
        }

        actions
        {
        }
    }

    /*labels
    {
        Label = 'ANNUAL LEAVE BALANCE';
        }*/

    trigger OnPreReport();
    begin
        GeneralLedgerSetupRec.GET;
        GeneralLedgerSetupRec.TESTFIELD("Current Budget End Date");
        MaturityDateFilter := GeneralLedgerSetupRec."Current Budget End Date";
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        Emp: Record Employee;
        Name: Text[50];
        AcctPeriod: Record "Payroll Period";
        MaturityDateFilter: Date;
        CompanyInfo: Record "Company Information";
        EmpLeaveApps: Record "Employee Leave Application";
        TotalTaken: Decimal;
        Recalls: Record "Leave Recall";
        TotalRecalls: Decimal;
        Absences: Record "Employee Absentism";
        TotalAbsence: Decimal;
        ANNUAL_LEAVE_BALANCE_CaptionLbl: Label '"%1  LEAVE BALANCE "';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_No_CaptionLbl: Label 'Staff No.';
        NameCaptionLbl: Label 'Name';
        Balance_B_FCaptionLbl: Label 'Balance B/F';
        BalanceCaptionLbl: Label 'Balance';
        EntitlmentCaptionLbl: Label 'Entitlment';
        Days_TakenCaptionLbl: Label 'Days Taken';
        Days_RecalledCaptionLbl: Label 'Days Recalled';
        Days_AbsentCaptionLbl: Label 'Days Absent';
        BalanceBF: Decimal;
        Entitlement: Decimal;
        Balance: Decimal;
        DateFilter: Date;
        StartDate: Date;
        EndDate: Date;
        Leavefilter: Code[30];
        LeaveTypes: Record "Leave Types";
        StartingDate: Date;
        EmployeeLeaves: Record "Employee Leaves";
        EmployeeLeaveEntitlement: Record "Employee Leave Entitlement";
        GeneralLedgerSetupRec: Record "General Ledger Setup";
        Ledgers: Record "HR Leave Ledger Entries";
        Periods: Record "HR Leave Periods";
        Additional: Record "Additional Leave Set-Up";
        NewBalance: Decimal;
}

