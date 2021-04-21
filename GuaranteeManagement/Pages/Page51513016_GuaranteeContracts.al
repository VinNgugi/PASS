page 51513016 "Guarantee Contracts"
{
    Caption = 'Contracts';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantee Contracts";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = "Guarante Contract Card";
    Editable = false;
    DeleteAllowed = false;
    //SourceTableView = sorting ("No.") where ("Application Status" = FILTER ("Contract Signed"));

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
                field("Loan No."; "Loan No.")
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field(Status; Status)
                {

                }
                field("Contract Status"; "Contract Status")
                {

                }
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {

                }


            }
            /*part("Aging Information"; "Loan Account Entries")
            {
                SubPageView = sorting ("Contract No.", "Reporting Date");
                SubPageLink = "Contract No." = field ("No.");
            }*/

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
        //Validate("Guarantee Source");
        Validate("Date of Birth");

    end;


}