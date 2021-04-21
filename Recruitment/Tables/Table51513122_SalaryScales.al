table 51513122 "Salary Scales"
{
    DataClassification = CustomerContent;
    Caption = 'Salary Scales';
    DrillDownPageId = "Salary Scales List";
    LookupPageId = "Salary Scales List";

    fields
    {
        field(1; Scale; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Scale';
        }
        field(2; "Minimum Pointer"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Pointer';
        }

        field(3; "Maximum Pointer"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Pointer';
        }
        field(4; "Responsibility Allowance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Allowance';
        }
        field(5; "Commuter Allowance"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Commuter Allowance';
        }
        field(6; "In Patient Limit"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'In Patient Limit';
        }
        field(7; "Out Patient Limit"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Out Patient Limit';
        }
        field(8; "Grade Identifier"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Grade Identifier';
            TableRelation = "Grade Identifier Tables";
        }
        field(9; "Medical Cover Category"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Medical Cover Category';
            TableRelation = "Medical Cover Category";

            trigger OnValidate()
            begin
                IF MedCat.GET("Medical Cover Category") THEN BEGIN
                    "In Patient Limit" := MedCat.Inpatient;
                    "Out Patient Limit" := MedCat.Outpatient;
                END ELSE BEGIN
                    "In Patient Limit" := MedCat.Inpatient;
                    "Out Patient Limit" := MedCat.Outpatient;

                END;
            end;
        }

        field(50001; "Basic Pay int"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Basic Pay int';
        }
        field(50002; "Basic Pay"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Basic Pay';
        }
        field(50003; "Minimum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Salary';
        }
        field(50004; "Maximum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Salary';
        }

    }

    keys
    {
        key(PK; Scale)
        {
            Clustered = true;
        }
    }

    var
        MedCat: Record "Medical Cover Category";

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