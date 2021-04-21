table 51513244 "Appraisee's Questions-Setup"
{
    // version HR
    Caption = 'Appraisees Questions-Setup';
    DataClassification = CustomerContent;
    //DrillDownPageID = 51511893;
    //LookupPageID = 51511893;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; Question; Text[250])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "User ID"; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; Question)
        {
        }

    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin

        "User ID" := USERID;
        Date := TODAY;
    end;

    var
        Appraisalines: Record "Appraisal Objectives Lines";
        TotalWeightings: Decimal;

    procedure GetNextLine() NxtLine: Integer;
    var
        AppraisalLine: Record "Appraisal Objectives Lines";
    begin
    end;
}

