page 51513816 "Resident Selection Card(BS)"
{
    PageType = Card;
    SourceTable = "Residential Selection Header";
    SourceTableView = sorting ("No.") order(ascending) where (Selection = filter ("Business Skills"));
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; "Document Date")
                {

                }
                field(Selection; Selection)
                {

                }
                field("Instructor Resource No."; "Instructor Resource No.")
                {

                }
                field("Trainer Name"; "Instructor Name")
                {

                }
                field(Gender; Gender)
                {

                }
                field("Incubation Code"; "Incubation Code")
                {

                }
                field("Selection Start Date"; "Selection Start Date")
                {

                }
                field("Selection End Date"; "Selection End Date")
                {

                }
                field("Created By"; "Created By")
                {

                }
                field(Status; Status)
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                    Editable = false;
                }
            }
            part("Selection Lines"; "Resident Selection Lines")
            {
                SubPageLink = "Document No" = field ("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Setup Question/Statement")
            {
                Image = QuestionaireSetup;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Residential Selection Test";
                RunPageLink = "Incubation Code" = field ("Incubation Code");


            }
            action("Start Assessment")
            {
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    AICCode.PopulateResidentialTestEntries(Rec, Selection);

                end;
            }
        }
    }
    trigger OnOpenPage()

    begin

    end;

    trigger OnNewRecord(BelowRec: Boolean)
    var

    begin
        Selection := Selection::"Business Skills";
    end;

    trigger OnAfterGetRecord()

    begin

    end;


    trigger OnAfterGetCurrRecord()
    var

    begin

    end;

    var
        AICCode: Codeunit "AIC Management";
}