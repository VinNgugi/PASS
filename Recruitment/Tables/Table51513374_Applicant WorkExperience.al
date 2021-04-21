table 51513374 "Applicant Work Experience"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Work Experience';

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant No.';
            NotBlank = true;


        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
        field(3; "From Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'From Date';
        }
        field(4; "To Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'To Date';
        }
        field(5; "Position Description"; Text[100])
        {
            DataClassification = CustomerContent;
            //FieldClass = FlowField;
            //CalcFormula = Lookup ("Former Positions".Description WHERE (Code = FIELD ("Position Code")));
            Caption = 'Position Description';
        }
        field(6; Responsibility; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility';
        }
        field(7; "Institution/Company"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Institution/Company';
        }
        field(8; "Position Code"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Position Code';
            TableRelation = "Former Positions";
        }
        field(9; "Experience No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Experience No';
        }
        field(10; Salary; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Salary';
        }
    }

    keys
    {
        key(KY; "Applicant No.", "Line No.")
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}