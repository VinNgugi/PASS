report 51513422 "BP Submitted"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'BP Submitted';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/BP Submitted.rdl';

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
                DataItemTableView = sorting() where("Submit to Bank Date" = filter(<> ''));
                RequestFilterFields = "Global Dimension 1 Code", Bank, "BDS/BDO", "Contract Status", "Submit to Bank Date", Product;

                column(No_; "No.")
                {

                }
                column(ClientName; Name)
                {

                }
                column(Product; Product)
                {

                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {

                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {

                }
                column(BDS_BDO; "BDS/BDO")
                {

                }
                column(Submit_to_Bank_Date; "Submit to Bank Date")
                {

                }
                column(Currency_Code; "Currency Code")
                {

                }
                column(Currency; Currency)
                {

                }
                column(Loan_Amount; "Loan Amount")
                {

                }
                column(Loan_Amount_LCY_; "Loan Amount(LCY)")
                {

                }
                column(Bank; Bank)
                {

                }
                column(Receivables_Acc__No_; "Receivables Acc. No.")
                {

                }
                column(Receivables_Acc__Name; "Receivables Acc. Name")
                {

                }
                column(Bank_Branch; "Bank Branch")
                {

                }
                column(Contract_Status; "Contract Status")
                {

                }
                column(Period; Period)
                {

                }
                column(PeriodText; PeriodText)
                {

                }
                column(FilterDim1; FilterDim1)
                {

                }
                column(FilterDim1Text; FilterDim1Text)
                {

                }
                column(BranchCode; BranchCode)
                {

                }
                column(RegionCode; RegionCode)
                {

                }
                dataitem("Subsector & Line of Business"; "Subsector & Line of Business")
                {
                    DataItemLink = "Client No." = field("No.");

                    column(Subsector; Subsector)
                    {

                    }
                    column(Line_of_Business; "Line of Business")
                    {

                    }
                    column(Type; Type)
                    {

                    }
                }

                trigger OnPredataItem()
                var

                begin
                    Period := "Guarantee Contracts".GETFILTER("Submit to Bank Date");

                    IF (Period <> '') THEN
                        PeriodText := 'Submitted Date ' + Period;


                    GetContractFilters("Guarantee Contracts");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    BranchCode := '';
                    RegionCode := '';
                    BankName := '';

                    if "Loan Amount(LCY)" = 0 then begin
                        Validate("Loan Amount");
                        Modify();
                    end;
                    Currency := '';

                    if "Currency Code" <> '' then
                        Currency := "Currency Code"
                    else
                        Currency := 'TZS';

                    GLSetup.Get();

                    DimensionValue.Reset();
                    DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                    DimensionValue.SetRange(Code, "Global Dimension 1 Code");
                    if DimensionValue.Find('-') then begin
                        BranchCode := DimensionValue.Name;
                    end;

                    DimensionValue.Reset();
                    DimensionValue.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                    DimensionValue.SetRange(Code, "Global Dimension 2 Code");
                    if DimensionValue.Find('-') then begin
                        RegionCode := DimensionValue.Name;
                    end;



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

    local procedure GetContractFilters(var Contracts: Record "Guarantee Contracts")
    var
        myInt: Integer;
    begin
        GLSetup.GET;

        FilterDim1 := Contracts.GETFILTER("Global Dimension 1 Code");

        IF (FilterDim1 <> '') THEN BEGIN
            IF DimensionValue.GET(GLSetup."Global Dimension 1 Code", FilterDim1) THEN
                FilterDim1Text := DimensionValue.Name
            ELSE
                FilterDim1Text := FilterDim1;
        END;
    end;

    var
        Currency: Code[10];
        Period: Text;
        PeriodText: Text;
        FilterDim1: Text;
        FilterDim1Text: Text[100];
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        BankName: Text;
        BranchCode: Text;
        RegionCode: Text;
        Customer: Record Customer;

}