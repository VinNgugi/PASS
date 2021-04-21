table 51513953 "Finance Role Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "User Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(3; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(4; "Approved Imprest"; Integer)
        {
            Caption = 'Approved Imprest For Posting';
            FieldClass = FlowField;
            CalcFormula = count ("Payments HeaderFin" where ("Payment Type" = filter (Imprest | "Imprest Requisitioning"), Status = filter (Released), Posted = filter (false)));
        }
    }

    keys
    {
        key(PK; "Primary Key")
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