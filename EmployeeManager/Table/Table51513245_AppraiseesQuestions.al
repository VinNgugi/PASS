table 51513245 "Appraisee's Questions"
{
    // version HR

    //DrillDownPageID = 51511883;
    // LookupPageID = 51511883;
    Caption = 'Appraisee Questions';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; Question; Code[20])
        {
            NotBlank = false;
            // TableRelation = "Budget Approval";
        }
        field(3; Type; Option)
        {
            OptionCaption = '" ,Yes,No"';
            OptionMembers = " ",Yes,No;
        }
        field(4; "Review Comments/ Achievements"; Text[250])
        {
        }
        field(5; "Appraisee's Comments"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", Question)
        {
        }

    }

    fieldgroups
    {
    }

    var
        Appraisalines: Record "Appraisal Objectives Lines";
        TotalWeightings: Decimal;

    procedure GetNextLine() NxtLine: Integer;
    var
        AppraisalLine: Record "Appraisal Objectives Lines";
    begin
    end;
}

