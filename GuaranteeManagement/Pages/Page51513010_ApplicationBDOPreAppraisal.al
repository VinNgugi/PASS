page 51513010 "Application BDO Pre-Appraisal"
{
    Caption = 'Application BDO Pre-Appraisal';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantee Application";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = "Application Pre-Appraisal";
    Editable = false;
    SourceTableView = sorting ("No.") where (Status = filter (Released), "Application Status" = FILTER (" " | "Commitment Paid"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Application Date"; "Application Date")
                {


                }
                field(Name; Name)
                {

                }

                field(Address; Address)
                {

                }
                field(City; City)
                {

                }
                field(Gender; Gender)
                {

                }
                field("Phone No."; "Phone No.")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }

            }

        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

            }
        }
    }

    trigger OnOpenPage()

    begin
        Validate("Date of Birth");
    end;
}