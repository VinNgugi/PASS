page 51513598 "Guarantee App List(Mobile)"
{
    Caption = 'Guarantee Application List(Mobile)';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Guarantee Application";
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = 51513001;
    Editable = false;
    SourceTableView = sorting("No.") where(Status = FILTER(Open), Source = const(Mobile));

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
                field("Customer No."; "Customer No.")
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
                field(Source; Source)
                {

                }
                field(AppID; AppID)
                {

                }
                field(IMEI; IMEI)
                {

                }
                field(TimeStp; TimeStp)
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
