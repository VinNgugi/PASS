report 51513421 "Contracts By Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Contracts By Status';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Contracts By Status.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            dataitem("Guarantee Contracts"; "Guarantee Contracts")
            {
                column(No_; "No.")
                {

                }
                column(ClientName; Name)
                {

                }
                column(Application_Date; "Application Date")
                {

                }
                column(Currency_Code; "Currency Code")
                {

                }
                column(Approved_Loan_Amount; "Approved Loan Amount")
                {

                }
                column(BP_Amount; "BP Amount")
                {

                }
                column(Loan_Amount; "Loan Amount")
                {

                }
                column(Contract_Status; "Contract Status")
                {

                }

                trigger OnPredataItem()
                var

                begin

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin

                end;

            }


            trigger OnPredataItem()
            var

            begin
                "Company Information".CalcFields(Picture)
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}