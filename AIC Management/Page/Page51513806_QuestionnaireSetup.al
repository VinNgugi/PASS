page 51513806 "Questionnaire Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Questionnaire Setup";
    PromotedActionCategories = 'Processing';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Incubation Code"; "Incubation Code")
                {
                    ApplicationArea = All;

                }
                field("Question Code"; "Question Code")
                {

                }
                field(Questionnaire; Questionnaire)
                {
                    MultiLine = true;
                }
                field("Answer Type"; "Answer Type")
                {

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Answers Setup")
            {
                Caption = 'Answers Setup';
                Image = Answers;
                Promoted = true;
                Enabled = EditableData;
                PromotedCategory = Process;
                RunObject = Page "Questionnaire Options";
                RunPageLink = "Question Code" = FIELD("Question Code"), "Incubation Code" = field("Incubation Code");
                RunPageOnRec = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EditableData := false;
        if "Answer Type" = "Answer Type"::"Multiple Choices" then
            EditableData := true;
    end;

    var
        EditableData: Boolean;

}