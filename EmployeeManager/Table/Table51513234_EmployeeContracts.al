table 51513234 "Employee Contracts"
{
    // version HR

    //DrillDownPageID = "Employee Qualifications List";
    //LookupPageID = "Employee Qualifications List";
    Caption = 'Employee Contracts';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Contract No"; Code[30])
        {
        }
        field(2; "Employee No"; Code[50])
        {
            TableRelation = Employee."No." WHERE (Status = CONST (Active));

            trigger OnValidate();
            begin
                EmpRec.RESET;
                if EmpRec.GET("Employee No") then begin
                    "Employee Name" := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";

                end;
                EmpContracts.RESET;
                EmpContracts.SETRANGE(EmpContracts."Employee No", "Employee No");
                EmpContracts.SETRANGE(EmpContracts."Contract End Date", 0D, TODAY);
                if EmpContracts.FINDLAST then begin
                    EmpContracts.Expired := true;
                    EmpContracts.MODIFY;

                end;
            end;
        }
        field(3; "Contract Start Date"; Date)
        {

            trigger OnValidate();
            begin


                //Calculate balance brought forward from previous contract period
                "Balance Brought Forward" := 0;
                EndDate := CALCDATE('-1D', "Contract Start Date");

                EmpContracts.RESET;
                EmpContracts.SETRANGE(EmpContracts."Employee No", "Employee No");
                EmpContracts.SETRANGE(EmpContracts."Contract End Date", EndDate);
                if EmpContracts.FINDLAST then begin
                    TotalDays1 := 0;
                    Recalled1 := 0;
                    Absent1 := 0;

                    EmpLeaveApps.RESET;
                    EmpLeaveApps.SETRANGE(EmpLeaveApps."Employee No", EmpContracts."Employee No");
                    EmpLeaveApps.SETRANGE(EmpLeaveApps."Leave Code", 'ANNUAL');
                    EmpLeaveApps.SETRANGE(EmpLeaveApps."Start Date", EmpContracts."Contract Start Date", EmpContracts."Contract End Date");
                    EmpLeaveApps.SETRANGE(EmpLeaveApps.Status, EmpLeaveApps.Status::Approved);
                    if EmpLeaveApps.FINDFIRST then begin
                        repeat
                            TotalDays1 := TotalDays1 + EmpLeaveApps."Days Applied";
                        until EmpLeaveApps.NEXT = 0;
                    end;

                    LeaveRecallRec.RESET;
                    LeaveRecallRec.SETRANGE(LeaveRecallRec."Employee No", "Employee No");
                    LeaveRecallRec.SETRANGE(LeaveRecallRec."Recalled From", EmpContracts."Contract Start Date", EmpContracts."Contract End Date");
                    if LeaveRecallRec.FIND('-') then begin
                        repeat
                            Recalled1 := Recalled1 + LeaveRecallRec."No. of Off Days";
                        until LeaveRecallRec.NEXT = 0;
                    end;

                    EmpAbsence.RESET;
                    EmpAbsence.SETRANGE(EmpAbsence."Employee No", "Employee No");
                    EmpAbsence.SETRANGE(EmpAbsence."Absent From", EmpContracts."Contract Start Date", EmpContracts."Contract End Date");
                    if EmpAbsence.FIND('-') then begin
                        repeat
                            Absent1 := Absent1 + EmpAbsence."No. of  Days Absent";
                        until EmpAbsence.NEXT = 0;
                    end;

                    "Balance Brought Forward" := (EmpContracts."Contract Leave Entitlement" + EmpContracts."Balance Brought Forward" + Recalled1) -
                (TotalDays1 + Absent1);
                end;

            end;
        }
        field(4; "Contract End Date"; Date)
        {
        }
        field(6; Expired; Boolean)
        {
        }
        field(7; "Contract Leave Entitlement"; Decimal)
        {
        }
        field(8; "Balance Brought Forward"; Decimal)
        {

            trigger OnValidate();
            begin
                VALIDATE("Employee No");
                VALIDATE("Contract No");
                VALIDATE("Contract Leave Entitlement");

                AccPeriod.RESET;
                AccPeriod.SETRANGE(AccPeriod."Starting Date", 0D, "Contract Start Date");
                AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", true);
                if AccPeriod.FINDFIRST then begin
                    //FiscalStart:=AccPeriod."Starting Date";
                    MaturityDate := CALCDATE('1Y', AccPeriod."Starting Date") - 1;
                end;

                Empleave.INIT;
                Empleave."Employee No" := "Employee No";
                Empleave."Leave Code" := 'ANNUAL';
                Empleave."Maturity Date" := MaturityDate;
                Empleave.Entitlement := "Contract Leave Entitlement";
                Empleave."Balance Brought Forward" := "Balance Brought Forward";
                EVALUATE(Empleave."Temp. Emp. Contract", "Contract No");
                if not Empleave.GET(Empleave."Employee No", Empleave."Leave Code", Empleave."Maturity Date") then
                    Empleave.INSERT;

            end;
        }
        field(9; "Contract Leave Balance"; Decimal)
        {
        }
        field(10; "Employee Name"; Text[80])
        {
        }
        field(11; "User ID"; Code[70])
        {
        }
        field(12; "Creation Date"; Date)
        {
        }
        field(13; "Total Days Taken"; Decimal)
        {
            CalcFormula = Sum ("Employee Leave Application"."Days Applied" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                                 "Contract No." = FIELD ("Contract No"),
                                                                                 Status = CONST (Approved),
                                                                                 "Leave Code" = CONST ('ANNUAL')));
            FieldClass = FlowField;
        }
        field(14; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum ("Leave Recall"."No. of Off Days" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                      "Contract No." = FIELD ("Contract No")));
            FieldClass = FlowField;
        }
        field(15; "Days Absent"; Decimal)
        {
            CalcFormula = Sum ("Employee Absentism"."No. of  Days Absent" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                                "Contract No." = FIELD ("Contract No")));
            FieldClass = FlowField;
        }
        field(16; "Off Days"; Decimal)
        {
        }
        field(17; Status; Option)
        {
            OptionMembers = Active,Expired,Terminated;
        }
        field(18; Created; Boolean)
        {
        }
        field(19; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Date Filter"; Date)
        {
        }
        field(21; "Expiry Date"; Date)
        {
        }
        field(22; "Termination Date"; Date)
        {
        }
        field(23; "Contract Period"; DateFormula)
        {

            trigger OnValidate();
            begin
                "Contract End Date" := CALCDATE("Contract Period", "Contract Start Date");
                // "Contract Leave Entitlement":=2.5*"Contract Period";
            end;
        }
        field(24; "Employee Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Posting Group";
        }
        field(25; "Requires Probation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Probation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Probation End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Probation Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Contract No", "Employee No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Contract No", "Employee No", "Contract Start Date", "Contract End Date")
        {
        }
    }

    trigger OnInsert();
    begin

        "User ID" := USERID;
        "Creation Date" := TODAY;
    end;

    var
        LeaveTypes: Record "HR Learning Intervention";
        EmpContracts: Record "Employee Contracts";
        EndDate: Date;
        EmpLeaveApps: Record "Employee Leave Application";
        LeaveRecallRec: Record "Leave Recall";
        EmpAbsence: Record "Employee Absentism";
        TotalDays: Decimal;
        Recalled: Decimal;
        Absent: Decimal;
        Absent1: Decimal;
        TotalDays1: Decimal;
        Recalled1: Decimal;
        EmpRec: Record Employee;
        Empleave: Record "Employee Leave Entitlement";
        NextMaturityDate: Date;
        CalendarMgmt: Codeunit "Calendar Management";
        NextDate: Date;
        NoOfMonths: Decimal;
        Description: Text[50];
        EndOfYear: Boolean;
        MaturityDate: Date;
        AccPeriod: Record "Payroll Period";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "Human Resources Setup";
}

