page 51513807 "Questionnaire Options"
{
    PageType = List;
    SourceTable = "Questionnaire Options";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Question Code"; "Question Code")
                {
                    ApplicationArea = All;

                }
                field("Answer Code"; "Answer Code")
                {

                }
                field(Questionnaire; Questionnaire)
                {
                    MultiLine = true;
                }
                field(Answer; Answer)
                {
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

    var


    trigger OnAfterGetRecord()

    begin

    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin

    end;
}