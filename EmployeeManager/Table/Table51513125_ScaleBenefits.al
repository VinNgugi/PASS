table 51513125 "Scale Benefits"
{
    // version PAYROLL
    DataClassification = CustomerContent;
    Caption = 'Scale Benefits';
    fields
    {
        field(1; "Salary Scale"; Code[10])
        {
            TableRelation = "Salary Scales";
        }
        field(2; "Salary Pointer"; Code[10])
        {
            //TableRelation = sal;
        }
        field(3; "ED Code"; Code[20])
        {
            NotBlank = true;
            //TableRelation =Earnings;

            trigger OnValidate();
            begin
                /*  if EarningRec.GET("ED Code") then begin
                      "ED Description" := EarningRec.Description;
                  end;*/
            end;
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; "ED Description"; Text[30])
        {
        }
        field(6; "G/L Account"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Salary Scale", "Salary Pointer", "ED Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //EarningRec: Record Earnin;
}

