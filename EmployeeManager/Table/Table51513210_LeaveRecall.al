table 51513210 "Leave Recall"
{
    // version HR

    DrillDownPageID = "Leave Recalls List";
    LookupPageID = "Leave Recalls List";
    Caption = 'Leave Recall';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Emp.GET("Employee No") then begin
                    "Employee Name" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    if Emp."Contract Number" <> '' then
                        "Contract No." := Emp."Contract Number";
                end;

            end;
        }
        field(3; Date; Date)
        {
            // ValidateTableRelation = false;
        }
        field(4; Approved; Boolean)
        {

            trigger OnValidate();
            begin

                LeaveTypes1.RESET;
                LeaveTypes1.SETRANGE(LeaveTypes1."Off/Holidays Days Leave", true);
                if LeaveTypes1.FIND('-') then;
                "Employee Leave".RESET;
                "Employee Leave".SETRANGE("Employee Leave"."Employee No", "Employee No");
                "Employee Leave".SETRANGE("Employee Leave"."Leave Code", LeaveTypes1.Code);
                if "Employee Leave".FIND('-') then;
                if Approved = true then begin
                    ;
                    "Employee Leave".Balance := "Employee Leave".Balance + 1;
                    "Employee Leave".MODIFY;
                end
                else begin
                    "Employee Leave".Balance := "Employee Leave".Balance - 1;
                    "Employee Leave".MODIFY;
                end;

            end;
        }
        field(5; "Leave Application"; Code[20])
        {
            TableRelation = "Employee Leave Application" WHERE (Status = CONST (Approved));

            trigger OnValidate();
            begin
                GeneralOptions.GET;

                if LeaveApplication.GET("Leave Application") then begin
                    //****************************Get Base Calendar*****************//
                    HumanResSetup.Get();
                    CalendarCode := HumanResSetup."Base Calender Code";
                    //****************************Get Base Calendar*****************//
                    NoOfDaysOff := 0;
                    "Leave Ending Date" := LeaveApplication."End Date";
                    if LeaveApplication."End Date" <> 0D then begin
                        NextDate := "Recall Date";
                        repeat
                            if not CalendarMgmt.CheckDateStatus(CalendarCode, NextDate, Description) then
                                NoOfDaysOff := NoOfDaysOff + 1;

                            NextDate := CALCDATE('1D', NextDate);
                        until NextDate = LeaveApplication."End Date";
                    end;

                end;
                //"No. of Off Days" := NoOfDaysOff;

                LeaveApplication.RESET;
                if LeaveApplication.GET("Leave Application") then begin
                    //  NoOfDaysOff:=0;
                    "Leave Ending Date" := LeaveApplication."End Date";
                    "Employee No" := LeaveApplication."Employee No";
                    "Employee Name" := LeaveApplication."Employee Name";
                    "Recall Leave Type" := LeaveApplication."Leave Code";
                    "Directorate Code" := LeaveApplication."Global Dimension 2 Code";
                    Clear("No. of Off Days");

                    DimensionsValue.RESET;
                    DimensionsValue.SETRANGE(DimensionsValue."Global Dimension No.", 1);
                    DimensionsValue.SETRANGE(DimensionsValue.Code, LeaveApplication."Global Dimension 1 Code");
                    if DimensionsValue.FIND('-') then
                        "Department Name" := DimensionsValue.Name;
                    DimensionsValue.RESET;
                    DimensionsValue.SETRANGE(DimensionsValue."Global Dimension No.", 2);
                    DimensionsValue.SETRANGE(DimensionsValue.Code, LeaveApplication."Global Dimension 2 Code");
                    if DimensionsValue.FIND('-') then
                        "Directorate Name" := DimensionsValue.Name;
                end;

            end;
        }
        field(6; "Recall Date"; Date)
        {

            trigger OnValidate();
            begin
                VALIDATE("Leave Application");
            end;
        }
        field(7; "No. of Off Days"; Decimal)
        {
            Editable = true;

            trigger OnValidate();
            begin
                RecalledDays := 0;
                ObjRecall.Reset();
                ObjRecall.SetRange("Leave Application", Rec."Leave Application");
                ObjRecall.SetRange("No.", '<>%1', Rec."No.");
                if ObjRecall.FindSet() then
                    repeat
                        RecalledDays := RecalledDays + ObjRecall."No. of Off Days";
                    until ObjRecall.Next() = 0;

                if LeaveApplication.Get("Leave Application") then begin
                    if "No. of Off Days" >= LeaveApplication."Days Applied" then
                        Error('Days recalled cannot be more than the applied leave days for leave application %1', LeaveApplication."Application No");
                    if (RecalledDays + Rec."No. of Off Days") > LeaveApplication."Days Applied" then
                        Error('Total Number of recalled days is more than the days applied on the leave application');
                end;


            end;
        }
        field(8; "Leave Ending Date"; Date)
        {
        }
        field(9; "Maturity Date"; Date)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Employee Name"; Text[50])
        {
        }
        field(12; "No."; Code[20])
        {
        }
        field(13; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(14; "Fiscal Start Date"; Date)
        {
        }
        field(15; "Recalled By"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Emp.GET("Recalled By") then begin
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    DimensionsValue.RESET;
                    DimensionsValue.SETRANGE("Global Dimension No.", 2);
                    DimensionsValue.SETRANGE(Code, Emp."Global Dimension 2 Code");
                    if DimensionsValue.FINDLAST then
                        "Head Of Department" := DimensionsValue.Name;
                end;
            end;
        }
        field(16; Name; Text[50])
        {
            Editable = false;
        }
        field(17; "Reason for Recall"; Text[130])
        {
        }
        field(18; "Head Of Department"; Text[100])
        {
        }
        field(20; "Recalled From"; Date)
        {
            NotBlank = false;

            trigger OnValidate();
            begin
                if LeaveApplication.Get("Leave Application") then begin
                    if ("Recall Date" < LeaveApplication."Start Date") or ("Recall Date" > LeaveApplication."End Date") then
                        Error('Recall date must be within the leave start date and end date.Start date is %1, and end date is %2', LeaveApplication."Start Date", LeaveApplication."End Date");
                end;

                GeneralOptions.GET;
                if "Recalled From" <> 0D then
                    d := "Recalled From";

                //****************************Get Base Calendar*****************//
                HumanResSetup.Get();
                CalendarCode := HumanResSetup."Base Calender Code";

                //****************************Get Base Calendar*****************//
                NoOfDaysOff := 0;

                NotworkingDaysRecall := 0;
                FullDays := ROUND("No. of Off Days", 1, '<');
                HalfDays := "No. of Off Days" - FullDays;

                if ("No. of Off Days" <> 0) and ("No. of Off Days" >= 1) then begin
                    repeat
                        if not CalendarMgmt.CheckDateStatus(CalendarCode, d, Description) then
                            NotworkingDaysRecall := NotworkingDaysRecall + 1;

                        LeaveApplication.RESET;
                        if LeaveApplication.GET("Leave Application") then
                            LeaveCode := LeaveApplication."Leave Code";

                        if LeaveTypes.GET(LeaveCode) then begin
                            if LeaveTypes."Inclusive of Holidays" then begin
                                BaseCalendar.RESET;
                                BaseCalendar.SETRANGE(BaseCalendar."Base Calendar Code", CalendarCode);
                                BaseCalendar.SETRANGE(BaseCalendar.Date, d);
                                BaseCalendar.SETRANGE(BaseCalendar.Nonworking, true);
                                BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                if BaseCalendar.FIND('-') then begin
                                    NotworkingDaysRecall := NotworkingDaysRecall + 1;
                                end;

                            end;

                            if LeaveTypes."Inclusive of Saturday" then begin
                                BaseCalender.RESET;
                                BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                BaseCalender.SETRANGE(BaseCalender."Period No.", 6);

                                if BaseCalender.FIND('-') then begin
                                    NotworkingDaysRecall := NotworkingDaysRecall + 1;
                                end;
                            end;

                            if LeaveTypes."Inclusive of Sunday" then begin
                                BaseCalender.RESET;
                                BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SETRANGE(BaseCalender."Period Start", d);
                                BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                if BaseCalender.FIND('-') then begin
                                    NotworkingDaysRecall := NotworkingDaysRecall + 1;
                                end;
                            end;


                            if LeaveTypes."Off/Holidays Days Leave" then
                                ;

                        end;

                        d := CALCDATE('1D', d);

                    until NotworkingDaysRecall = FullDays;
                    "Recalled To" := d - 1;
                end else
                    if ("No. of Off Days" <> 0) and ("No. of Off Days" < 1) then begin
                        "Recalled To" := "Recalled From";
                    end;

                if "Recalled To" <> 0D then
                    VALIDATE("Recalled To");

            end;
        }
        field(21; "Recalled To"; Date)
        {
            NotBlank = false;

            trigger OnValidate();
            begin




                if ("Recalled To" = "Recalled From") then
                    "No. of Off Days" := 1

                else begin

                    GeneralOptions.GET;
                    if LeaveApplication.GET("Leave Application") then begin
                        NoOfDaysOff := 1;
                        "Leave Ending Date" := LeaveApplication."End Date";
                        if LeaveApplication."End Date" <> 0D then begin
                            NextDate := "Recalled From";
                            repeat
                                if not CalendarMgmt.CheckDateStatus(CalendarCode, NextDate, Description) then
                                    NoOfDaysOff := NoOfDaysOff + 1;

                                NextDate := CALCDATE('1D', NextDate);
                            until NextDate = "Recalled To";
                        end;

                    end;
                    "No. of Off Days" := NoOfDaysOff;
                end;

            end;
        }
        field(22; "Department Name"; Text[80])
        {
        }
        field(23; "Contract No."; Code[50])
        {
        }
        field(24; "Directorate Code"; Code[10])
        {
        }
        field(25; "Directorate Name"; Text[80])
        {
        }
        field(26; "Recall Leave Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Employee No", "Maturity Date")
        {
            SumIndexFields = "No. of Off Days";
        }
        key(Key3; "Employee No", "Contract No.")
        {
            SumIndexFields = "No. of Off Days";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "No." = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Leave Recall Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Recall Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;

        Date := TODAY;
        "Recall Date" := TODAY;

        if UserSetup.GET(USERID) then begin
            "Recalled By" := UserSetup."Employee No.";
            VALIDATE("Recalled By");
        end;

        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
    end;

    trigger OnModify();
    begin
        //MESSAGE('You are modifying leave recall data for %1 are you sure you want to do this', "Employee Name");
    end;

    var
        Holidays: Record "Holidays_Off Days";
        "Employee Leave": Record "Employee Leave Entitlement";
        LeaveTypes1: Record "Leave Types";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        FiscalStart: Date;
        MaturityDate: Date;
        Emp: Record Employee;
        LeaveApplication: Record "Employee Leave Application";
        NextDate: Date;
        NoOfDaysOff: Decimal;
        CalendarMgmt: Codeunit "Calendar Management";
        GeneralOptions: Record "Company Information";
        Description: Text[30];
        BaseCalender: Record Date;
        NonWorkingDay: Boolean;
        NotworkingDaysRecall: Integer;
        LeaveTypes: Record "Leave Types";
        BaseCalendar: Record "Base Calendar Change";
        d: Date;
        DimensionsValue: Record "Dimension Value";
        LeaveCode: Code[30];
        FullDays: Decimal;
        HalfDays: Decimal;
        GLSetup: Record "General Ledger Setup";
        GLBudgets: Record "G/L Budget Name";
        CalendarCode: Code[10];
        ObjRecall: Record "Leave Recall";
        RecalledDays: Decimal;

    procedure FindMaturityDate();
    var
        AccPeriod: Record "Accounting Period";
    begin
        GLSetup.GET;
        /* GLSetup.TESTFIELD("Current Budget");

         GLBudgets.RESET;
         GLBudgets.GET(GLSetup."Current Budget");
         GLBudgets.TESTFIELD("Start Date");
         GLBudgets.TESTFIELD("End Date");
         "Fiscal Start Date" := GLBudgets."Start Date";
         MaturityDate := GLBudgets."End Date";*/
    end;
}

