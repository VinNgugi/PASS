page 51513014 "Contract Signing"
{
    Caption = 'Application Under Contract Signing';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantee Application";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = "Contract Signing Card";
    Editable = false;
    SourceTableView = sorting ("No.") where ("Application Status" = FILTER ("Contract Prepared"));

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