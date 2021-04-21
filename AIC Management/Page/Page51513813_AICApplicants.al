page 51513813 "AIC Applicants"
{
    PageType = List;
    SourceTable = "Incubation Applicants";
    SourceTableView = sorting ("No.") order(ascending);
    Editable = false;
    InsertAllowed = false;
    Caption = 'Applicants List';
    CardPageId = "Applicant Card(AIC)";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Name; Name)
                {

                }

                field("Incubation Code"; "Incubation Code")
                {

                }
                field("Incubation Name"; "Incubation Name")
                {

                }
                field(Submitted; Submitted)
                {

                }

                field("E-Mail"; "E-Mail")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }
            }
        }


    }

    actions
    {
        area(Processing)
        {
            action("Proceed to Residential Selection")
            {
                Image = CreateMovement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Applicants.Reset();
                    // Applicants.SetRange("No.", "No.");
                    CurrPage.SetSelectionFilter(Applicants);
                    if Applicants.FindSet() then begin
                        repeat
                            TestField("Resident Selection", false);
                            "Resident Selection" := true;
                            Modify(true);
                        until Applicants.Next() = 0;
                        Message('Successfully moved to resident selection stage');
                    end;
                end;
            }
        }
    }
    var
        Applicants: Record "Incubation Applicants";
}