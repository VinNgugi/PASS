table 51513138 "Overtime Template"
{
    // version PAYROLL
    Caption = 'Overtime Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[30])
        {
        }
        field(2; "Payroll period"; Date)
        {
            TableRelation = "Payroll Period";
        }
        field(3; "Employee Name"; Text[130])
        {
        }
        field(4; Department; Code[80])
        {
        }
        field(5; Hours; Decimal)
        {
        }
        field(6; Double; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Payroll period")
        {
        }
    }

    fieldgroups
    {
    }

    procedure Rundataforpayperiod();
    var
        OvertimeTemplate: Record "Overtime Template";
        PayrollPeriod: Record "Payroll Period";
        OvertimeExcel: Record "Overtime Excel";
    begin
        PayrollPeriod.RESET;
        PayrollPeriod.SETRANGE("Close Pay", false);
        if PayrollPeriod.FINDFIRST then begin
            OvertimeExcel.RESET;
            if OvertimeExcel.FINDFIRST then begin
                repeat
                    OvertimeTemplate.INIT;
                    OvertimeTemplate."Employee No" := OvertimeExcel."Employee No";
                    OvertimeTemplate."Employee Name" := OvertimeExcel."Employee Name";
                    OvertimeTemplate.Hours := OvertimeExcel."Hours Normal";
                    OvertimeTemplate.Double := OvertimeExcel."Hours Double";
                    OvertimeTemplate."Payroll period" := PayrollPeriod."Starting Date";
                    if not OvertimeTemplate.GET(OvertimeExcel."Employee No", PayrollPeriod."Starting Date") then
                        OvertimeTemplate.INSERT;
                until OvertimeExcel.NEXT = 0;
            end;
        end;
    end;
}

