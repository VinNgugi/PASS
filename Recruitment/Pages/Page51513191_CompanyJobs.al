page 51513191 "Company Jobs"
{
    PageType = Card;

    SourceTable = "Company Jobs";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Job ID"; "Job ID")
                {

                }
                field("Job Description"; "Job Description")
                {

                }
                field("Position Reporting To"; "Position Reporting To")
                {
                    Caption = 'Immediate Supervisor';
                }
                field(Grade; Grade)
                {

                }
                field(Objective; Objective)
                {

                }
                field("No. of Posts"; "No. of Posts")
                {

                }
                field("Occupied Establishments"; "Occupied Establishments")
                {

                }
                field("Vacant Establishments"; "Vacant Establishments")
                {

                }
                field("Notice Period"; "Notice Period")
                {

                }
                field("Probation Period"; "Probation Period")
                {

                }
                field("Date Active"; "Date Active")
                {

                }
                field(Status; Status)
                {

                }
            }
            group("Dimension Values")
            {
                field("Dimension 1"; "Dimension 1")
                {

                }
                field("Dimension 2"; "Dimension 2")
                {

                }
                field("Dimension 3"; "Dimension 3")
                {

                }
                field("Dimension 4"; "Dimension 4")
                {

                }
                field("Dimension 5"; "Dimension 5")
                {

                }
                field("Dimension 6"; "Dimension 6")
                {

                }
                field("Dimension 7"; "Dimension 7")
                {

                }
                field("Dimension 8"; "Dimension 8")
                {

                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Job)
            {
                action("Positions Reporting to Job Holder")
                {
                    Image = Job;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "J. Position Supervised";
                    RunPageLink = "Job ID" = FIELD ("Job ID");
                    Caption = 'Positions Reporting to Job Holder';

                }
                action("Job Specification")
                {
                    Image = Description;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "J. Specification";
                    RunPageLink = "Job ID" = FIELD ("Job ID");
                    Caption = 'Job Specification';

                }
                action("Key Responsibilities")
                {
                    Image = TaskList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "J. Responsiblities";
                    RunPageLink = "Job ID" = FIELD ("Job ID");
                    Caption = 'Key Responsibilities';

                }
                action("Vacant Positions")
                {
                    Image = OpportunitiesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Vacant Establishments";
                    RunPageLink = "Job ID" = FIELD ("Job ID");
                    Caption = 'Vacant Positions';

                }
                action("Over Staffed Positions")
                {
                    Image = Lot;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Over Staffed Establishments";
                    RunPageLink = "Job ID" = FIELD ("Job ID");
                    Caption = 'Over Staffed Positions';

                }
            }
        }
    }
    trigger OnAfterGetRecord()

    begin
        OnAfterGetCurrRecord1;
    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin
        OnAfterGetCurrRecord1;
    end;

    local procedure OnAfterGetCurrRecord1()

    begin
        xRec := Rec;
        IF "No. of Posts" <> xRec."No. of Posts" THEN
            "Vacant Establishments" := "No. of Posts" - "Occupied Establishments";

    end;
}