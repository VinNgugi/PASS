report 51513501 "FD Maturity Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/FD Maturity Report.rdl';
    Caption = 'FD Maturity Report';

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
            dataitem("Investment Header"; "Investment Header")
            {
                DataItemTableView = SORTING ("No.");
                RequestFilterFields = "No.", Status, "Source Bank", "Destination Bank Account";

                column(No_; "No.")
                {

                }
                column(Source_Bank; "Source Bank")
                {

                }
                column(Source_Bank_Name; "Source Bank Name")
                {

                }
                column(Destination_Bank_Account; "Destination Bank Account")
                {

                }
                column(Destination_Bank_Acc_Name; "Destination Bank Acc Name")
                {

                }
                column(Investment_Start_Date; "Investment Start Date")
                {

                }
                column(Investment_End_Date; "Investment End Date")
                {

                }
                column(Currency_Code; "Currency Code")
                {

                }
                column(Investment_Principal; "Investment Principal")
                {

                }
                column(Investment_Principle_LCY_; "Investment Principle(LCY)")
                {

                }
                column(Investment_Rate; "Investment Rate")
                {

                }
                column(Expected_Interest; "Expected Interest")
                {

                }
                column(FDRDays; FDRDays)
                {

                }
                column(FDRRemainingDays; FDRRemainingDays)
                {

                }

                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    FDRDays := 0;
                    FDRRemainingDays := 0;
                    if ("Investment End Date" <> 0D) and ("Investment Start Date" <> 0D) then begin
                        FDRDays := ("Investment End Date" - "Investment Start Date");

                        if "Investment End Date" < Today then
                            FDRRemainingDays := ("Investment End Date" - Today);
                    end;



                    if "Currency Code" = '' then
                        "Currency Code" := 'TZS';
                end;
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
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
        FDRDays: Decimal;
        FDRRemainingDays: Decimal;
}