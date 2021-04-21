table 51513248 "Position Supervised"
{
    DataClassification = CustomerContent;
    Caption = 'Position Supervised';

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";

        }
        field(2; "Position Supervised"; Code[20])

        {
            DataClassification = CustomerContent;
            Caption = 'Position Supervised';
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate()

            begin
                Jobs.RESET;
                IF Jobs.GET("Position Supervised") THEN
                    Description := Jobs."Job Description";
            end;
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
    }

    keys
    {
        key(PK; "Job ID", "Position Supervised")
        {

        }
    }

    var
        Jobs: Record "Company Jobs";

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