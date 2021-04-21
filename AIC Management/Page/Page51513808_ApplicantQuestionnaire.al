page 51513808 "Applicant Questionnaire"
{
    PageType = ListPart;
    SourceTable = "Applicant Questionnaire";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Applicant No"; "Applicant No")
                {
                    ApplicationArea = All;

                }
                field(Questionnaire; Questionnaire)
                {
                    MultiLine = true;
                }
                field("Answer Code"; "Answer Code")
                {
                    Editable = EditableData;
                }
                field(Answer; Answer)
                {
                    Editable = (not EditableData);
                    MultiLine = true;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        EditableData := false;

        if "Answer Type" = "Answer Type"::"Multiple Choices" then
            EditableData := true
        else
            EditableData := false;
    end;

    var
        EditableData: Boolean;

}