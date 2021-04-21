table 51513136 "Overtime Line"
{
    // version PAYROLL

    Caption = 'Overtime Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Empl.GET("Employee No") then
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
            end;
        }
        field(4; "Employee Name"; Text[120])
        {
        }
        field(5; "Hours Normal"; Decimal)
        {

            trigger OnValidate();
            var
                OvertimePayrollComputation: Codeunit "Overtime Payroll Computation";
                Earn2: Record Earnings;
                Basicpaycode: Code[20];
                AssignMatrix: Record "Assignment Matrix";
                BasicSalary: Decimal;
                Overtimerate: Decimal;
                OvertimehoursPM: Decimal;
                Overtimepaid: Decimal;
                overcode: Code[20];
                OvertimeSetUp: Record "Overtime Set Up";
            begin
                Amount := 0;
                if OvertimeHeader.GET(Code) then
                    PayPeriod := OvertimeHeader."Pay Period";
                OverSetup.RESET;
                OverSetup.SETRANGE(Type, OverSetup.Type::Weekday);
                if OverSetup.FIND('-') then begin
                    Earnings.RESET;
                    Earnings.SETRANGE("Basic Salary Code", true);
                    if Earnings.FIND('-') then begin
                        repeat
                            AssignMatrix.RESET;
                            AssignMatrix.SETRANGE("Employee No", "Employee No");
                            AssignMatrix.SETRANGE("Payroll Period", PayPeriod);
                            AssignMatrix.SETRANGE(Code, Earnings.Code);
                            AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                            if AssignMatrix.FINDFIRST then
                                Amount := Amount + (((AssignMatrix.Amount * 12) / 2080) * OverSetup."Rates Normal" * "Hours Normal");
                        until Earnings.NEXT = 0;
                    end;
                end;



                /*TESTFIELD("Overttime Code");
                IF "Hours Normal">0 THEN BEGIN
                  Earn.RESET;
                  Earn.SETRANGE(OverTime,TRUE);
                  IF Earn.FINDFIRST THEN BEGIN
                    overcode:=Earn.Code;
                  END;
                  //=======basic pay code
                  Earn2.RESET;
                  Earn2.SETRANGE("Basic Salary Code",TRUE);
                  IF Earn2.FINDFIRST THEN BEGIN
                    Basicpaycode:=Earn2.Code;
                  END;
                    BasicSalary:=0;
                    Overtimerate:=0;
                    OvertimehoursPM:=0;
                    Overtimepaid:=0;
                  //=====get basic pay
                  AssignMatrix.RESET;
                  AssignMatrix.SETRANGE(Code,Basicpaycode);
                  AssignMatrix.SETRANGE("Employee No","Employee No");
                  AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                  AssignMatrix.SETRANGE("Payroll Period","pay period");
                  IF AssignMatrix.FINDFIRST THEN BEGIN
                    BasicSalary:=AssignMatrix.Amount;
                  END ELSE BEGIN
                    MESSAGE('Please Set Basic Pay for %1 For Payroll Period %2',"Employee Name","pay period");
                END;
                   //======
                  IF OvertimeSetUp.GET("Overttime Code") THEN BEGIN
                    Overtimerate:=OvertimeSetUp."Rates Normal";
                    OvertimehoursPM:=OvertimeSetUp."Max Hours Per Month";
                  END;
                  Overtimepaid:=ROUND((BasicSalary/OvertimehoursPM)*("Hours Normal"*Overtimerate),0.01);
                  Amount:=Overtimepaid;
                  IF Amount<>0 THEN
                  MODIFY;
                 END;
                 */

            end;
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Paid; Boolean)
        {
        }
        field(8; "pay period"; Date)
        {
        }
        field(9; "Overttime Code"; Code[50])
        {
            TableRelation = "Overtime Set Up";
        }
        field(10; "Hours Double"; Decimal)
        {

            trigger OnValidate();
            begin
                Amount := 0;
                if OvertimeHeader.GET(Code) then
                    PayPeriod := OvertimeHeader."Pay Period";
                OverSetup.RESET;
                OverSetup.SETRANGE(Type, OverSetup.Type::Weekend);
                if OverSetup.FIND('-') then begin
                    Earnings.RESET;
                    Earnings.SETRANGE("Basic Salary Code", true);
                    if Earnings.FIND('-') then begin
                        repeat
                            AssignMatrix.RESET;
                            AssignMatrix.SETRANGE("Employee No", "Employee No");
                            AssignMatrix.SETRANGE("Payroll Period", PayPeriod);
                            AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SETRANGE(Code, Earnings.Code);
                            if AssignMatrix.FINDFIRST then
                                Amount := Amount + (((AssignMatrix.Amount * 12) / 2080) * OverSetup."Rates Normal" * "Hours Double");
                        until Earnings.NEXT = 0;
                    end;
                end;
            end;
        }
        field(11; Unit; Code[10])
        {
            CaptionClass = '1,1,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
        }
        field(12; Added; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Date; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                Empl.GET("Employee No");
                DateDesc := '';
                Working := CalendarMgmt.CheckDateStatus(Empl."Base Calendar Code", Date, DateDesc);
                //MESSAGE('Calendar %1 Status %2',Date,Working);
                if Working = true then begin
                    Amount := 0;
                    "Hours Normal" := 0;
                    "Hours Double" := Hours;
                    VALIDATE("Hours Double");
                end else begin
                    Amount := 0;
                    "Hours Double" := 0;
                    "Hours Normal" := Hours;
                    VALIDATE("Hours Normal");
                end;

            end;
        }
        field(14; Hours; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                VALIDATE(Date);
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No", "pay period", Date)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Empl: Record Employee;
        OvertimeHeader: Record "Overtime Header";
        AssignmentMatrix: Record "Assignment Matrix";
        Earnings: Record Earnings;
        Earn: Record Earnings;
        overcode: Code[20];
        OverSetup: Record "Overtime Set Up";
        PayPeriod: Date;
        AssignMatrix: Record "Assignment Matrix";
        BaseCalender: Record Date;
        CalendarMgmt: Codeunit "Calendar Management";
        BaseCalendar: Record "Base Calendar Change";
        Working: Boolean;
        DateDesc: Text;
}

