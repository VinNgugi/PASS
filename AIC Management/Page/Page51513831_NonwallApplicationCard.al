page 51513831 "Non-Wall Application Card"
{
    PageType = Card;
    SourceTable = "Non-Wall Applications";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application ID"; "Application ID")
                {

                }
                field("Applicant Name"; "Applicant Name")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Application Time"; "Application Time")
                {

                }
                field("Applicant ID"; "Applicant ID")
                {

                }
                field(Submitted; Submitted)
                {

                }
                field("Enterpreneurship Test Score"; "Enterpreneurship Test Score")
                {

                }

            }
            group("Business Details")
            {
                field("Business Name"; "Business Name")
                {

                }
                field("Business Registration No"; "Business Registration No")
                {

                }
                field("Date of Incorporation"; "Date of Incorporation")
                {

                }
                field("Business Age"; "Business Age")
                {

                }
                field(Ownership; Ownership)
                {

                }
            }
            group(Communication)
            {
                field("Business Email"; "Business Email")
                {

                }
                field("Business Website"; "Business Website")
                {

                }
                field("Business Phone No"; "Business Phone No")
                {

                }
                field("Buisness Mobile No."; "Buisness Mobile No.")
                {

                }
                field("Business Address"; "Business Address")
                {

                }
                field("Business Physical Address"; "Business Address 2")
                {

                }
                field(City; City)
                {

                }
                field("Post Code"; "Post Code")
                {

                }
                field("Country/Region Code"; "Country/Region Code")
                {

                }
            }
            group("Certification(s)")
            {
                field(TFDA; TFDA)
                {

                }
                field(TBS; TBS)
                {

                }
                field(Barcode; Barcode)
                {

                }
                field("Business License"; "Business License")
                {

                }
                field("Tax Clearance"; "Tax Clearance")
                {

                }

            }
            part(EnterprenuershipTest; "Enterprenuership Test Entry")
            {
                Caption = 'Enterprenuership Test';
                SubPageLink = "Application ID" = field ("Application ID");
            }
            part(BusinessPerformance; "Business Performance List")
            {
                SubPageLink = "Application No" = field ("Application ID");
            }
            part("Service Types"; "Service Type Line List")
            {
                SubPageLink = "Application ID" = field ("Application ID");
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                Image = SendTo;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    Submitted := true;
                end;
            }
        }
    }

    var
        myInt: Integer;
}