table 51513105 "Payroll Period"
{
    // version PAYROLL

    DrillDownPageID = "Pay Periods";
    LookupPageID = "Pay Periods";
    Caption = 'Payroll Period';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
            NotBlank = true;

            trigger OnValidate();
            begin
                Name := FORMAT("Starting Date", 0, '<Month Text>') + ' ' + FORMAT(Type);
                "Period code" := FORMAT(DATE2DMY("Starting Date", 3)) + FORMAT(DATE2DMY("Starting Date", 2)) + FORMAT(DATE2DMY("Starting Date", 1))
            end;
        }
        field(2; Name; Text[20])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Period code" := FORMAT(DATE2DMY("Starting Date", 3)) + FORMAT(DATE2DMY("Starting Date", 2)) + FORMAT(DATE2DMY("Starting Date", 1))
            end;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            Caption = 'New Fiscal Year';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                TESTFIELD("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(5; "Date Locked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Locked';
            Editable = true;
        }
        field(50000; "Pay Date"; Date)
        {
            Caption = 'Pay Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Close Pay"; Boolean)
        {
            Caption = 'Close Pay';
            DataClassification = CustomerContent;
            Editable = true;

            trigger OnValidate();
            begin
                //TESTFIELD("Close Pay",FALSE);
                /*
                IF "Close Pay"=TRUE THEN BEGIN
                  "Closed By":=USERID;
                  "Closed on Date":=CURRENTDATETIME;
                END;
                */

            end;
        }
        field(50002; "P.A.Y.E"; Decimal)
        {
            Caption = 'P.A.Y.E';
            CalcFormula = Sum("Assignment Matrix".Amount WHERE("Payroll Period" = FIELD("Starting Date"),
                                                                Paye = CONST(true)));
            FieldClass = FlowField;
        }
        field(50003; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
            //CalcFormula = Sum ("Staff Ledger Entry"."Basic Pay" WHERE ("Payroll Period" = FIELD ("Starting Date")));
            FieldClass = FlowField;
        }
        field(50004; "Market Interest Rate %"; Decimal)
        {
            Caption = 'Market Interest Rate %';
            DataClassification = CustomerContent;
        }
        field(50005; "CMS Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CMS Starting Date';
        }
        field(50006; "CMS End Date"; Date)
        {
            Caption = 'CMS End Date';
            DataClassification = CustomerContent;
        }
        field(50007; "Closed By"; Code[30])
        {
            Caption = 'Closed By';
            DataClassification = CustomerContent;
        }
        field(50008; "Closed on Date"; DateTime)
        {
            Caption = 'Closed on Date';
            DataClassification = CustomerContent;
        }
        field(50009; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = '" ,Daily,Weekly,Bi-Weekly,Monthly"';
            OptionMembers = " ",Daily,Weekly,"Bi-Weekly",Monthly;
        }
        field(50010; Sendslip; Boolean)
        {
            Caption = '50010';
            DataClassification = CustomerContent;
        }
        field(50015; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Pending Approval,Released,Canceled,Rejected';
            OptionMembers = Open,"Pending Approval",Released,Canceled,Rejected;
        }
        field(50016; "Approver 1"; Boolean)
        {
            Caption = 'Approver 1';
            DataClassification = CustomerContent;
        }
        field(50017; "Approver 2"; Boolean)
        {
            Caption = 'Approver 2';
            DataClassification = CustomerContent;
        }
        field(50018; "Approver 3"; Boolean)
        {
            Caption = 'Approver 3';
            DataClassification = CustomerContent;
        }
        field(50019; "Approver 4"; Boolean)
        {
            Caption = 'Approver 4';
            DataClassification = CustomerContent;
        }
        field(50020; "Approver 5"; Boolean)
        {
            Caption = 'Approver 5';
            DataClassification = CustomerContent;
        }
        field(50021; "Approver 6"; Boolean)
        {
            Caption = 'Approver 6';
            DataClassification = CustomerContent;
        }
        field(50022; "Approver 7"; Boolean)
        {
            Caption = 'Approver 7';
            DataClassification = CustomerContent;
        }
        field(50023; "Start Approval"; Boolean)
        {
            Caption = 'Start Approver';
            DataClassification = CustomerContent;
        }
        field(50024; "Period code"; Code[20])
        {
            Caption = 'Period code';
            DataClassification = CustomerContent;
        }
        field(50025; "Approval Status"; Integer)
        {
            Caption = 'Approver Status';
            //DataClassification = CustomerContent;
            //CalcFormula = Count ("Approval Entry" WHERE ("Document Type" = CONST ("Contract Extension"),
            //                                                  "Document No." = FIELD ("Period code")));
            FieldClass = FlowField;
        }
        field(50026; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(50027; "Country/Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(50028; "L.Allowance Cutoff Date"; Date)
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Starting Date")
        {
        }
        key(Key2; "New Fiscal Year", "Date Locked")
        {
        }
        key(Key3; Closed)
        {
        }
        key(Key4; Type)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //TESTFIELD("Date Locked",FALSE);
    end;

    trigger OnInsert();
    begin
        AccountingPeriod2 := Rec;
        if AccountingPeriod2.FIND('>') then
            AccountingPeriod2.TESTFIELD("Date Locked", false);
    end;

    trigger OnRename();
    begin
        TESTFIELD("Date Locked", false);
        AccountingPeriod2 := Rec;
        if AccountingPeriod2.FIND('>') then
            AccountingPeriod2.TESTFIELD("Date Locked", false);
    end;

    var
        AccountingPeriod2: Record "Payroll Period";

    procedure CreateLeaveEntitlment(var PayrollPeriod: Record "Payroll Period");
    var
        AccPeriod: Record "Payroll Period";
        NextDate: Date;
        EndOfYear: Boolean;
        Empleave: Record "Employee Leave Entitlement";
        LeaveType: Record "Leave Types";
        MaturityDate: Date;
        NextMaturityDate: Date;
        Emp: Record Employee;
        CarryForwardDays: Decimal;
        EmpleaveCpy: Record "Employee Leave Entitlement";
    begin
        EndOfYear := FALSE;
        NextDate := CALCDATE('1M', "Starting Date");
        IF AccPeriod.GET(NextDate) THEN
            IF AccPeriod."New Fiscal Year" THEN
                EndOfYear := TRUE;

        IF EndOfYear THEN BEGIN

            MaturityDate := CALCDATE('1M', PayrollPeriod."Starting Date") - 1;
            NextMaturityDate := CALCDATE('1Y', MaturityDate);

            LeaveType.RESET;
            LeaveType.SETRANGE(LeaveType."Annual Leave", TRUE);
            IF LeaveType.FIND('-') THEN BEGIN

                Emp.RESET;
                Emp.SETRANGE(Emp.Status, Emp.Status::Active);
                //Emp.SETFILTER(Emp."Posting Group",'<>%1','INTERN');
                IF Emp.FIND('-') THEN
                    REPEAT
                        // IF (Emp."Posting Group"='PARMANENT') THEN BEGIN

                        IF EmpleaveCpy.GET(Emp."No.", LeaveType.Code, MaturityDate) THEN BEGIN
                            EmpleaveCpy.CALCFIELDS(EmpleaveCpy."Total Days Taken");
                            CarryForwardDays := EmpleaveCpy.Entitlement + EmpleaveCpy."Balance Brought Forward" + EmpleaveCpy."Recalled Days"
                            - EmpleaveCpy."Total Days Taken";
                            IF CarryForwardDays > LeaveType."Max Carry Forward Days" THEN
                                CarryForwardDays := LeaveType."Max Carry Forward Days";
                        END;

                        //MKU LEAVES
                        CarryForwardDays := 0;

                        Empleave.INIT;
                        Empleave."Employee No" := Emp."No.";
                        Empleave."Leave Code" := LeaveType.Code;
                        Empleave."Maturity Date" := NextMaturityDate;
                        // IF Emp."Date Of Join">"Starting Date" THEN
                        //   Empleave.Entitlement:=
                        // ELSE
                        Empleave.Entitlement := LeaveType.Days;
                        Empleave."Balance Brought Forward" := CarryForwardDays;
                        IF NOT Empleave.GET(Empleave."Employee No", Empleave."Leave Code", Empleave."Maturity Date") THEN
                            Empleave.INSERT;

                    /*
                     END ELSE

                   IF (Emp."Posting Group"='TEMP') OR (Emp."Posting Group"='INTERN') THEN BEGIN

                    IF EmpleaveCpy.GET(Emp."No.",LeaveType.Code,MaturityDate) THEN
                    BEGIN
                    EmpleaveCpy.CALCFIELDS(EmpleaveCpy."Total Days Taken");
                    CarryForwardDays:=EmpleaveCpy.Entitlement+EmpleaveCpy."Balance Brought Forward"+EmpleaveCpy."Recalled Days"
                    -EmpleaveCpy."Total Days Taken";
                    IF CarryForwardDays>LeaveType."Max Carry Forward Days" THEN
                    CarryForwardDays:=LeaveType."Max Carry Forward Days";
                    END;

                    Empleave.INIT;
                    Empleave."Employee No":=Emp."No.";
                    Empleave."Leave Code":=LeaveType.Code;
                    Empleave."Maturity Date":=NextMaturityDate;
                   // IF Emp."Date Of Join">"Starting Date" THEN
                   //   Empleave.Entitlement:=
                   // ELSE
                    Empleave.Entitlement:=ROUND(((Emp."Contract End Date"-Emp."Contract Start Date")/30),1)*2.5;
                    Empleave."Balance Brought Forward":=CarryForwardDays;
                    IF NOT Empleave.GET(Empleave."Employee No", Empleave."Leave Code",Empleave."Maturity Date") THEN
                    Empleave.INSERT;
                   END;

                  */
                    UNTIL Emp.NEXT = 0;

            END
            ELSE
                ERROR('You must select one leave type as annual on the leave setup');

        END;
    end;

}

