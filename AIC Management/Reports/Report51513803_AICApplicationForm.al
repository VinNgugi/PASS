report 51513803 "AIC Application Form"
{

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    EnableHyperlinks = true;
    RDLCLayout = './Layouts/AIC Application Form.rdl';
    caption = 'AIC Application Form';

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
            column(AIC_Logo; "AIC Logo")
            {

            }
            column(AIC_Company_Name; "AIC Company Name")
            {

            }


            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture, "AIC Logo")
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