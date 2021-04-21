page 51513397 "Appraiser and Appraisee Narrat"
{
    // version HR

    AutoSplitKey = false;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    //SourceTableView = WHERE ("Appraisal Heading Type" = FILTER (6 | 5 | " "));
    Caption = 'Appraiser and Appraisee Narrat';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Description; Description)
                {
                    Editable = true;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        DescriptionOnFormat;
    end;

    var
        AppraisalTypes: Record "Appraisee's Questions";
        [InDataSet]
        DescriptionEmphasize: Boolean;

    local procedure DescriptionOnFormat();
    begin
        if Bold then
            DescriptionEmphasize := true;
    end;
}

