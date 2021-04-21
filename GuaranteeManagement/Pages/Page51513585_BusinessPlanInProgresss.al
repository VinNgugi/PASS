page 51513585 "Business Plan In Progress"
{
    Caption = 'Business Plan In Progress';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantee Contracts";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = "BP In Progresss Card";
    Editable = false;
    SourceTableView = sorting ("No.") where ("Contract Status" = FILTER ("BP in Progress"));

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