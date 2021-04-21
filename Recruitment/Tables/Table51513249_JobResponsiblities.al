table 51513249 "Job Responsiblities"
{
    DataClassification = CustomerContent;
    caption = 'Job Responsiblities';

    fields
    {
        field(1; "Job ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            TableRelation = "Company Jobs"."Job ID";
            NotBlank = true;

        }
        field(2; Responsibility; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility';
            NotBlank = true;
        }
        field(3; Remarks; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(4; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No")
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