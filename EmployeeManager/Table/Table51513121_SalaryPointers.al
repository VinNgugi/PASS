table 51513121 "Salary Pointers"
{
    // version PAYROLL
    DataClassification = CustomerContent;
    Caption = 'Salary Pointers';
    DrillDownPageID = "Salary Pointers";
    LookupPageID = "Salary Pointers";

    fields
    {
        field(1; "Salary Pointer"; Code[10])
        {
            Caption = 'Salary Pointer';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Basic Pay int"; Integer)
        {
            Caption = 'Basic Pay int';
            DataClassification = CustomerContent;
        }
        field(3; "Basic Pay"; Decimal)
        {
            Caption = 'Basic Pay';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Salary Pointer")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Salary Pointer", "Basic Pay int", "Basic Pay")
        {
        }
    }

}


