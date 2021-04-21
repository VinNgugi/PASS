table 51513369 "Employee Transfer Lines"
{
    // version HR
    Caption = 'Employee Transfer Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transfer No"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transfer No';
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(3; "Employee No."; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Caption = 'Employee No.';

            trigger OnValidate();
            begin
                "Employee Name" := '';
                if EmployeeRec.GET("Employee No.") then begin
                    "Employee Name" := EmployeeRec."Last Name" + ' ' + EmployeeRec."First Name";
                    "Current Job Title" := EmployeeRec."Job Title";
                    DimensionValueRec.RESET;
                    DimensionValueRec.SETRANGE(Code, EmployeeRec."Global Dimension 2 Code");
                    if DimensionValueRec.FINDFIRST then
                        "Curent Department" := DimensionValueRec.Name;
                end;
            end;
        }
        field(4; "Employee Name"; Text[100])
        {
            FieldClass = Normal;
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        field(5; "Current Job Title"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Current Job Title';
        }
        field(7; "New Job Title"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'New Job Title';
        }
        field(8; "Transfer Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ',lateral,Voluntary,Non-Voluntary';
            OptionMembers = ,lateral,Voluntary,"Non-Voluntary";
            Caption = 'Transfer Type';
        }
        field(9; Remark; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remark';
        }
        field(10; "Curent Department"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Curent Department';
        }
        field(11; "New Department"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Name WHERE ("Global Dimension No." = FILTER (1));
            Caption = 'New Department';
        }
    }

    keys
    {
        key(Key1; "Transfer No", "Line No.")
        {
        }
    }



    var
        EmployeeRec: Record Employee;
        DimensionValueRec: Record "Dimension Value";
}

