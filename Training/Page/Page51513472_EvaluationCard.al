page 51513472 "Evaluation Card"
{
    PageType = Card;
    SourceTable = "Training Evaluation H";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; "Document Date")
                {

                }
                field("Employee No"; "Employee No")
                {

                }
                field("Employee Name"; "Employee Name")
                {

                }
                field("Training No."; "Training No.")
                {

                }
                field("Training Description"; "Training Description")
                {

                }
                field("Training Provider"; "Training Provider")
                {

                }
                field("Provider Name"; "Provider Name")
                {

                }
                field("Trainer Name"; "Trainer Name")
                {

                }
                field("Created By"; "Created By")
                {

                }
            }
            part("Evaluation Lines"; "Evaluation Lines")
            {
                SubPageLink = "Header No." = field ("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Caption = 'Training Evaluation Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Reset();
                    SetRange("No.", Rec."No.");
                    Report.Run(Report::"Course Evaluation Sheet", true, true, Rec);
                    Reset();
                end;
            }
        }
    }

    var
        myInt: Integer;
}