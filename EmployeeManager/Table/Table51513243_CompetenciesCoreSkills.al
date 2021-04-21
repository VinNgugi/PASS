table 51513243 "Competencies/Core Skills"
{
    // version HR

    //DrillDownPageID = 51511883;
    //LookupPageID = 51511883;
    Caption = 'Competencies/Core Skills';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; "Competency Code"; Code[20])
        {
            NotBlank = false;
            //TableRelation = "Budget Approval";
        }
        field(3; Competencies; Text[250])
        {
        }
        field(4; Description; Text[250])
        {
        }
        field(5; "Self Assessment"; Option)
        {
            OptionCaption = '" ,Very Poor,Poor,Fair,Good,Excellent"';
            OptionMembers = " ","Very Poor",Poor,Fair,Good,Excellent;
        }
        field(6; "Reviewer's Assessment"; Option)
        {
            OptionCaption = '" ,Very Poor-1,Poor-2,Fair-3,Good-4,Excellent-5"';
            OptionMembers = " ","Very Poor-1","Poor-2","Fair-3","Good-4","Excellent-5";
        }
        field(7; "Review Comments/ Achievements"; Text[250])
        {
        }
        field(8; Type; Option)
        {
            OptionCaption = '" ,Values,Core,Managerial"';
            OptionMembers = " ",Values,Core,Managerial;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Competency Code")
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

