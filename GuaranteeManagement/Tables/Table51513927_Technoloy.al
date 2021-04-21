table 51513927 Technology
{
    DataClassification = ToBeClassified;
    DrillDownPageId = Technology;
    LookupPageId = Technology;

    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }

        field(3; "Business Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Type';
            TableRelation = "Line Of Business";

            trigger OnValidate()
            var
                BusinessType: Record "Line Of Business";
            begin
                BusinessType.Reset();
                BusinessType.SetRange(Code, "Business Type");
                if BusinessType.Find('-') then begin
                    SubSector := BusinessType.Subsector;
                end;
            end;
        }
        field(4; SubSector; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Subsector;
        }


    }

    keys
    {
        key(PK; Code, "Business Type")
        {
            Clustered = true;
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