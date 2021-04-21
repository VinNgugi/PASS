table 51513815 "Subsector & Business Type"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Request No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Request No.';
            TableRelation = "Recruitment Needs";
        }
        field(3; "Job ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Jobs" where ("Job Funcion" = filter ("AIC Job"));
        }
        field(4; "Business Type"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Line Of Business";

            trigger OnValidate()
            var
                BusinessType: Record "Line Of Business";
            begin
                BusinessType.Reset();
                BusinessType.SetRange(Code, "Business Type");
                if BusinessType.FindFirst() then
                    Subsector := BusinessType.Subsector;

            end;
        }
        field(5; Subsector; Code[50])
        {
            DataClassification = CustomerContent;
            tablerelation = Subsector;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Line No.", "Job ID")
        {
            Clustered = true;
        }
        key(PK2; "Request No.")
        {

        }
        key(PK3; "Job ID", "Business Type")
        {
            Unique = true;
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