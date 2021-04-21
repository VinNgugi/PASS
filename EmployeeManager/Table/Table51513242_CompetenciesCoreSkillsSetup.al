table 51513242 "Competencies/Core Skills-Setup"
{
    // version HR

    //DrillDownPageID = 51511885;
    //LookupPageID = 51511885;
    Caption = 'Competencies/Core Skills-Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
        }
        field(2; "Competency Code"; Code[30])
        {
        }
        field(3; Competencies; Text[250])
        {
        }
        field(4; Description; Text[250])
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; "User ID"; Code[100])
        {
        }
        field(7; Type; Option)
        {
            OptionCaption = '" ,Values,Core,Managerial"';
            OptionMembers = " ",Values,Core,Managerial;
        }
    }

    keys
    {
        key(Key1; Description)
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

